namespace Ratsbucks.Pages.Practices;

public class ElementRefPage : Component
{
    private MauiControls.Entry? _entryRef;

    public override VisualNode Render()
    {
        return ContentPage("Element Reference",
            VStack(spacing: 10,
                Entry(entryRef => _entryRef = entryRef)
                    .Text("Hi!")
                    .HCenter()
                    .VCenter()
            ),
            Button("Focus Entry")
                .BackgroundColor(Colors.Green)
                .HCenter()
                .OnClicked(() => _entryRef?.Focus())
        );
    }
}