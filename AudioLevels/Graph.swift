//
//  Graph.swift
//  AudioLevels
//
//  Created by Sravan Karuturi on 2/1/24.
//

import SwiftUI
import Charts

struct ChartData: Identifiable, Equatable {
    var id: UUID = UUID()
    
    let value: Float
    let time: Float
}

struct Graph: View {
    
    @Binding var data: [ChartData]
    
    let stops = [
        Gradient.Stop(color: .red, location: 0.0),
        Gradient.Stop(color: .orange, location: 0.5),
        Gradient.Stop(color: .green, location: 0.8)
    ]
    
    var body: some View {
        
        VStack{
            
            Chart{
                
                ForEach(data){ element in
                    LineMark(x: .value("Time", element.time), y: .value("Value", element.value))
                        .foregroundStyle(.linearGradient(Gradient(stops: stops), startPoint: .bottom, endPoint: .top))
                }
                
            }
            .chartXScale(domain: (data.first?.time ?? 0.0)...(data.last?.time ?? 5.0))
            
            
        }
        
    }
}

#Preview {
    Graph(data: .constant([
        ChartData(value: -40, time: 0.0),
        ChartData(value: -20, time: 0.1),
        ChartData(value: -20, time: 0.2),
        ChartData(value: -10, time: 0.3),
        ChartData(value: -30, time: 0.4),
        ChartData(value: -40, time: 0.5)
    ])
    )
}
