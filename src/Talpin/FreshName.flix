mod Talpin {

pub eff FreshName {
    def get(): Int32
}

mod FreshName {
    use Add.add

    pub def handleWithState(f: a -> b \ ef): a -> b \ ef - FreshName =
        x -> runWithState(() -> f(x))

    pub def runWithState(f: Unit -> b \ ef): b \ ef - FreshName = region local {
        let counter = Ref.fresh(local, -1);
        def next() = {
            counter |> Ref.transform(add(1));
            Ref.get(counter)
        };
        run f() with handler FreshName {
            def get(k) = k(next())
        }
    }

}
}
