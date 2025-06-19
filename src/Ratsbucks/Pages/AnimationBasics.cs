using MauiReactor;
using Button = MauiReactor.Button;
using ContentPage = MauiReactor.ContentPage;
using Label = MauiReactor.Label;

namespace Ratsbucks.Pages;

public class AnimationBasicsState
{
    public bool ToggleState { get; set; }
}

public class AnimationBasics : Component<AnimationBasicsState>
{
    private Microsoft.Maui.Controls.Label _labelRef;

    public override VisualNode Render()
    {
        return new ContentPage()
        {
            new VStack(spacing: 10)
                {
                    new Label(labelRef => _labelRef = labelRef)
                        .Text("Moving Label")
                        .HStart()
                        .TranslationX(State.ToggleState ? 0 : 200)
                        .WithAnimation(duration: 1000),
                    new Button("Move")
                        .OnClicked(() => SetState(s => s.ToggleState = !s.ToggleState))
                }
                .WidthRequest(400)
                .HCenter()
                .VCenter()
        };
    }
}