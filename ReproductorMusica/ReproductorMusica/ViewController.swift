//
//  ViewController.swift
//  ReproductorMusica
//
//  Created by jesus serrano on 26/11/16.
//  Copyright © 2016 gezuzm. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }
    
    private var reproductor : AVAudioPlayer!
    private var numCancionAleatoria : Int!
    private var hayCancion: Bool = false
    
    @IBOutlet weak var valorVolumen: UILabel!
    @IBOutlet weak var cancionesUIPicker: UIPickerView!
    @IBOutlet weak var imagenDisco: UIImageView!
    @IBOutlet weak var labTitulo: UILabel!
    
    var pickerData = ["RollingsTones", "TheKillers", "JohnLegend", "PitBull", "CartelSanta"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.cancionesUIPicker.dataSource = self
        self.cancionesUIPicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


  
    @IBAction func play() {
     if hayCancion == true
     {
    if !reproductor.isPlaying
    {
        reproductor.play()
        }
    }
    }
    
    
    @IBAction func pause() {
    
         if hayCancion == true
         {
    if reproductor.isPlaying
    {
        reproductor.pause()
        }
        }
    }
    
    
    @IBAction func stop2() {
        
        if hayCancion == true
        {
        if reproductor.isPlaying
        {
            reproductor.stop()
            reproductor.currentTime = 0.0
            
        }
        }

    }
 
    
    @IBAction func cancionAleatoria(_ sender: UIButton) {
        
        let numCancionAleatoria : Int = Int(arc4random_uniform(5)) + 1
        
         self.MuestraCancion(eleccion: numCancionAleatoria)
    }


    func MuestraCancion(eleccion : Int)
    {
        var nombreArtista : String = ""
        var nombreCancion : String = ""
        
        switch(eleccion) {
        case 1:
            nombreArtista = "RollingsTones"
            nombreCancion = "Ride Em On Down"

                        break
        case 2:
            nombreArtista = "TheKillers"
            nombreCancion = "Dont Shoot Me Santa"
                        break
        case 3:
            nombreArtista = "JohnLegend"
            nombreCancion = "I Know Better"
            break
        case 4:
            nombreArtista = "PitBull"
            nombreCancion = "Cant Have"
            break
            
        default:
            nombreArtista = "CartelSanta"
            nombreCancion = "Volvio el Sensei"
            break
            
        }
        
        let image: UIImage = UIImage(named: nombreArtista)!
        self.imagenDisco.image = image
        
        let sonidoURL = Bundle.main.url(forResource: nombreCancion, withExtension: "mp3")
         
         do{
         try reproductor = AVAudioPlayer(contentsOf: sonidoURL!)
            
            self.hayCancion = true
            
            self.labTitulo.text = nombreArtista
         }
         catch{
                print("Error al cargar el archivo de sonido")
                self.hayCancion = false
         }
    }
    
    
    

    @IBAction func volumen(_ sender: UIStepper) {
        
        if hayCancion == true
        {
        
        if (sender.value > 100)
        {
            reproductor.volume = 1.0
        }
        else if (sender.value < 0)
            {
        
                reproductor.volume = 0.0
        }
        else
        {
            let var1 = Float(sender.value) / Float( 100.0)
            reproductor.volume  =  var1
        }
        
        valorVolumen.text = String(Int(sender.value))
        }
    }

    func roundToPlaces(value: Double, decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return round(value * divisor) / divisor
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        self.MuestraCancion(eleccion:  row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    /*
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      //  myLabel.text = pickerData[row]
    }
 */
}

