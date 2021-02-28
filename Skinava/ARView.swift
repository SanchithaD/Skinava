//
//  ARView.swift
//  Skinava
//
//  Created by Sanchitha Dinesh on 2/27/21.
//

import Foundation
import ARKit
import SwiftUI
// MARK: - ARViewIndicator
struct ARViewIndicator: UIViewControllerRepresentable {
   typealias UIViewControllerType = ARView
   
   func makeUIViewController(context: Context) -> ARView {
      return ARView()
   }
   func updateUIViewController(_ uiViewController:
   ARViewIndicator.UIViewControllerType, context:
   UIViewControllerRepresentableContext<ARViewIndicator>) { }
}

class ARView: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView {
       return self.view as! ARSCNView
    }
    private var viewportSize: CGSize!
    private var detectImage: Bool = true

     override var shouldAutorotate: Bool { return false }

    override func loadView() {
      self.view = ARSCNView(frame: .zero)
    }
    override func viewDidLoad() {
    super.viewDidLoad()
         // Set the view's delegate
         sceneView.delegate = self
        
        //Add recognizer to sceneview
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))
        sceneView.addGestureRecognizer(tapRec)
        viewportSize = sceneView.frame.size
    }
    
    //Method called when tap
    @objc func handleTap(rec: UITapGestureRecognizer){
        
        if rec.state == .ended {
            let location: CGPoint = rec.location(in: sceneView)
            let hits = self.sceneView.hitTest(location, options: nil)
            var alert = UIAlertController(title: "Keratosis Pilaris", message: "A condition that causes rough patches and small, acne-like bumps on the skin. This condition develops when the skin produces too much of a protein called keratin, which can block hair follicles and cause bumps to develop.The bumps are usually on the arms, thighs, cheeks, and buttocks. They're white, sometimes red, and typically don't hurt or itch.The condition isn't often serious and usually disappears by age 30. Medicated creams may help skin appearance.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            if !hits.isEmpty{
                let tappedNode = hits.first?.node
            }
        }
    }
    // MARK: - Functions for standard AR view handling
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

       // Create a session configuration
      let configuration = ARImageTrackingConfiguration()
        
      if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources",
                                                              bundle: Bundle.main) {
            
          configuration.trackingImages = imagesToTrack
              
        // this tells ARKit how many images it is supposed to track simultaneously,
        //ARKit can do upto 100
          configuration.maximumNumberOfTrackedImages = 2
        
        }
      
      // Run the view's session
      sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
    }
    private func resetTracking() {
         let configuration = ARWorldTrackingConfiguration()
         configuration.planeDetection = []
         sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
         detectImage = true
     }
    func createHostingController(for node: SCNNode) {

        
        // Do this on the main thread
        DispatchQueue.main.async {
            // create a hosting controller with SwiftUI view
            let view1 = SwiftUIARCardView()
            //view1.allowsHitTesting(true)
            
            let arVC = UIHostingController(rootView: view1)
            
            arVC.willMove(toParent: self)
            // make the hosting VC a child to the main view controller
            self.addChild(arVC)
            
            // set the pixel size of the Card View
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            
            // add the ar card view as a subview to the main view
            self.view.addSubview(arVC.view)
            
            // render the view on the plane geometry as a material
            self.show(hostingVC: arVC, on: node)
        }
    }
    
    func show(hostingVC: UIHostingController<SwiftUIARCardView>, on node: SCNNode) {
        // create a new material
        let material = SCNMaterial()
        
        // this allows the card to render transparent parts the right way
        hostingVC.view.isOpaque = false
        
        // set the diffuse of the material to the view of the Hosting View Controller
        material.diffuse.contents = hostingVC.view
        
        // Set the material to the geometry of the node (plane geometry)
        node.geometry?.materials = [material]
        
        hostingVC.view.backgroundColor = UIColor.clear
    }
    func processDetections(for request: VNRequest, error: Error?) {
        guard error == nil else {
            print("Object detection error: \(error!.localizedDescription)")
            return
        }
        
        guard let results = request.results else { return }
        
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation,
                let topLabelObservation = objectObservation.labels.first,
                topLabelObservation.identifier == "remote",
                topLabelObservation.confidence > 0.9
                else { continue }
            
            guard let currentFrame = sceneView.session.currentFrame else { continue }
        
            // Get the affine transform to convert between normalized image coordinates and view coordinates
            let fromCameraImageToViewTransform = currentFrame.displayTransform(for: .portrait, viewportSize: viewportSize)
            // The observation's bounding box in normalized image coordinates
            let boundingBox = objectObservation.boundingBox
            // Transform the latter into normalized view coordinates
            let viewNormalizedBoundingBox = boundingBox.applying(fromCameraImageToViewTransform)
            // The affine transform for view coordinates
            let t = CGAffineTransform(scaleX: viewportSize.width, y: viewportSize.height)
            // Scale up to view coordinates
            let viewBoundingBox = viewNormalizedBoundingBox.applying(t)

            let midPoint = CGPoint(x: viewBoundingBox.midX,
                       y: viewBoundingBox.midY)

            let results = sceneView.hitTest(midPoint, types: .featurePoint)
            guard let result = results.first else { continue }

            let anchor = ARAnchor(name: "remoteObjectAnchor", transform: result.worldTransform)
            sceneView.session.add(anchor: anchor)
            
            detectImage = false
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
            let node = SCNNode()
            
            // Cast the found anchor as image anchor
            guard let imageAnchor = anchor as? ARImageAnchor else { return nil }
            
            // get the name of the image from the anchor
            guard let imageName = imageAnchor.name else { return nil }
            
            // Check if the name of the detected image is the one you want
        if imageName == "keratosis_pilaris" {
                   let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                        height: imageAnchor.referenceImage.physicalSize.height)
                   
                   
                   let planeNode = SCNNode(geometry: plane)
                   // When a plane geometry is created, by default it is oriented vertically
                   // so we have to rotate it on X-axis by -90 degrees to
                   // make it flat to the image detected
                   planeNode.eulerAngles.x = -.pi / 2
                   
                   createHostingController(for: planeNode)
                   
                   node.addChildNode(planeNode)
                   return node
               } else {
                   return nil
               }

        }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
         guard detectImage,
             let capturedImage = sceneView.session.currentFrame?.capturedImage
             else { return }
         
         let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: capturedImage, orientation: .leftMirrored, options: [:])
         
         do {
             try imageRequestHandler.perform([objectDetectionRequest])
         } catch {
             print("Failed to perform image request.")
         }
     }
    lazy var objectDetectionRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: SkinClassifier().model)
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                self?.processDetections(for: request, error: error)
            }
            return request
        } catch {
            fatalError("Failed to load Vision ML model.")
        }
    }()
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {}
    
    func sessionInterruptionEnded(_ session: ARSession) {}
    func session(_ session: ARSession, didFailWithError error: Error)
    {}
    func session(_ session: ARSession, cameraDidChangeTrackingState
    camera: ARCamera) {}
}
