//
//  Oscillator.swift
//  testFilter
//
//  Backend nodes for running the AudioKit Oscillator - particularly for waveform selection.
//
//  Created by Oisin Carlin on 22/07/2022.
//
//

import Foundation
import Foundation
import AVFoundation
import AudioKit
import AudioKitEX
import CAudioKitEX

/// Reads from the table sequentially and repeatedly at given frequency.
/// Linear interpolation is applied for table look up from internal phase values.
///
public class Oscillator: DynamicWaveformNode {
    
    /// Connected nodes
    public var connections: [Node] { [] }
    
    /// Underlying AVAudioNode
    public var avAudioNode = instantiate(instrument: "csto")
    
    fileprivate var waveform: Table?
    
    /// Callback when the wavetable is updated
    public var waveformUpdateHandler: ([Float]) -> Void = { _ in }
    
    /// Specification details for frequency
    public static let frequencyDef = NodeParameterDef(
        identifier: "frequency",
        name: "Frequency (Hz)",
        address: akGetParameterAddress("DynamicOscillatorParameterFrequency"),
        defaultValue: 440.0,
        range: 0.0 ... 20_000.0,
        unit: .hertz)
    
    /// Frequency in cycles per second
    @Parameter(frequencyDef) public var frequency: AUValue
    
    /// Specification details for amplitude
    public static let amplitudeDef = NodeParameterDef(
        identifier: "amplitude",
        name: "Amplitude",
        address: akGetParameterAddress("DynamicOscillatorParameterAmplitude"),
        defaultValue: 1.0,
        range: 0.0 ... 10.0,
        unit: .generic)
    
    /// Output Amplitude.
    @Parameter(amplitudeDef) public var amplitude: AUValue
    
    /// Specification details for detuningOffset
    public static let detuningOffsetDef = NodeParameterDef(
        identifier: "detuningOffset",
        name: "Frequency offset (Hz)",
        address: akGetParameterAddress("DynamicOscillatorParameterDetuningOffset"),
        defaultValue: 0.0,
        range: -1_000.0 ... 1_000.0,
        unit: .hertz)
    
    /// Frequency offset in Hz.
    @Parameter(detuningOffsetDef) public var detuningOffset: AUValue
    
    /// Specification details for detuningMultiplier
    public static let detuningMultiplierDef = NodeParameterDef(
        identifier: "detuningMultiplier",
        name: "Frequency detuning multiplier",
        address: akGetParameterAddress("DynamicOscillatorParameterDetuningMultiplier"),
        defaultValue: 1.0,
        range: 0.9 ... 1.11,
        unit: .generic)
    
    /// Frequency detuning multiplier
    @Parameter(detuningMultiplierDef) public var detuningMultiplier: AUValue
    
    // MARK: - Initialization
    
    /// Initialize this DynamicOscillator node
    ///
    /// - Parameters:
    ///   - waveform: The waveform of oscillation
    ///   - frequency: Frequency in cycles per second
    ///   - amplitude: Output Amplitude.
    ///   - detuningOffset: Frequency offset in Hz.
    ///   - detuningMultiplier: Frequency detuning multiplier
    ///
    public init(
        waveform: Table = Table(.sawtooth),
        frequency: AUValue = frequencyDef.defaultValue,
        amplitude: AUValue = amplitudeDef.defaultValue,
        detuningOffset: AUValue = detuningOffsetDef.defaultValue,
        detuningMultiplier: AUValue = detuningMultiplierDef.defaultValue)
    {
        setupParameters()
        
        self.stop()
        
        au.setWavetable(waveform.content)
        
        self.waveform = waveform
        self.frequency = frequency
        self.amplitude = amplitude
        self.detuningOffset = detuningOffset
        self.detuningMultiplier = detuningMultiplier
        
    }
    
    // MARK: - DynamicWaveformNode Protocol methods
    
    /// Sets the wavetable of the oscillator node
    /// - Parameter waveform: The waveform of oscillation
    public func setWaveform(_ waveform: Table) {
        au.setWavetable(waveform.content)
        self.waveform = waveform
        waveformUpdateHandler(waveform.content)
    }
    
    /// Gets the floating point values stored in the oscillator's wavetable
    public func getWaveformValues() -> [Float] {
        return waveform?.content ?? []
    }
    
    /// Set the waveform change handler
    /// - Parameter handler: Closure with an array of floats as the argument
    public func setWaveformUpdateHandler(_ handler: @escaping ([Float]) -> Void) {
        waveformUpdateHandler = handler
    }
}
