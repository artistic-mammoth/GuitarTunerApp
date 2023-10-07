//
//  TunerScreenBuilder.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import UIKit

final class TunerScreenBuilder {
    static func build() -> UIViewController {
        let tuner = TunerBuilder.build()
        let view = TunerViewImpl(notePickerView: NotePickerViewImpl(),
                                 tunerOffsetView: TunerOffsetViewImpl())
        let presenter = TunerPresenterImpl(view: view, tuner: tuner)
        view.presenter = presenter
        return view
    }
}
