extension ScrollViewProxy {

    // - SeeAlso: ScrollViewProxy.scrollTo(_:, anchor:)
    func fluidScroll(to id: Int, anchor: UnitPoint = .top) {
        withAnimation {
            scrollTo(id, anchor: anchor)
        }
    }
}