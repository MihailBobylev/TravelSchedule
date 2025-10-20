//
//  DestinationView.swift
//  TravelSchedule
//
//  Created by Михаил Бобылев on 11.10.2025.
//

import SwiftUI

struct DestinationView: View {
    @ObservedObject var tripSelection: TripSelection
    
    private var fromText: String {
        if let from = tripSelection.fromStation?.title, !from.isEmpty {
            return from
        } else {
            return "Откуда"
        }
    }
    
    private var toText: String {
        if let to = tripSelection.toStation?.title, !to.isEmpty {
            return to
        } else {
            return "Куда"
        }
    }
    
    private var fromColor: Color {
        if let from = tripSelection.fromStation?.title, !from.isEmpty {
            return .black
        } else {
            return .grayUniversal
        }
    }
    
    private var toColor: Color {
        if let to = tripSelection.toStation?.title, !to.isEmpty {
            return .black
        } else {
            return .grayUniversal
        }
    }
    
    let actionFrom: () -> ()
    let actionTo: () -> ()
    let reverseDestination: () -> ()
    let findSchedule: () -> ()
    
    var body: some View {
        VStack(spacing: 16.dvs) {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(fromText)
                            .lineLimit(1)
                            .foregroundColor(fromColor)
                            .font(.system(size: 17.dfs, weight: .regular))
                            .frame(maxWidth: .infinity, minHeight: 48.dvs, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                actionFrom()
                            }
                        
                        Text(toText)
                            .lineLimit(1)
                            .foregroundColor(toColor)
                            .font(.system(size: 17.dfs, weight: .regular))
                            .frame(maxWidth: .infinity, minHeight: 48.dvs, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                actionTo()
                            }
                    }
                    .padding(.leading, 13.dhs)
                    .padding(.trailing, 16.dhs)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                
                Button(action: {
                    reverseDestination()
                }) {
                    Image("ic-reverse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(6)
                        .background(.white)
                        .clipShape(Circle())
                }
                .padding(.trailing, 16.dhs)
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blueUniversal)
            )
            .padding(.horizontal, 16.dhs)
            
            
            if !fromText.isEmpty && !toText.isEmpty && fromText != "Откуда" && toText != "Куда" {
                Button(action: {
                    findSchedule()
                }) {
                    Text("Найти")
                        .foregroundColor(.white)
                        .font(.system(size: 17.dfs, weight: .bold))
                        .frame(maxWidth: 150.dhs)
                        .frame(height: 60.dvs)
                        .background(.blueUniversal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .transition(.opacity)
            }
        }
    }
}

//#Preview {
//    DestinationView(tripSelection: TripSelection(),
//                    actionFrom: {
//        
//    }, actionTo: {
//        
//    })
//}
