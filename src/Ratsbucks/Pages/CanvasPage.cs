using MauiReactor.Canvas;

namespace Ratsbucks.Pages;

public class CanvasPageState
{
    public float Degrees { get; set; }

    public float ScaleX { get; set; } = 1.0f;

    public float ScaleY { get; set; } = 1.0f;

    public bool IsMouseHoverImage { get; set; }
}

public class CanvasPage : Component<CanvasPageState>
{
    public override VisualNode Render()
    {
        return new ContentPage("Canvas")
        {
            new CanvasView()
            {
                new Column("100,*")
                {
                    new Box()
                        {
                            new ClipRectangle
                            {
                                new Text("This a Text element!")
                                    .HorizontalAlignment(HorizontalAlignment.Center)
                                    .VerticalAlignment(VerticalAlignment.Center)
                                    .FontColor(Colors.Black)
                                    .FontSize(14)
                            }
                        }
                        .Margin(10)
                        .BackgroundColor(Colors.Green)
                        .CornerRadius(10),
                    new Box()
                        {
                            new Column("*, 50")
                            {
                                new PointInteractionHandler
                                    {
                                        //new Picture("Ratsbucks.Resources.Images.Embedded.norway_1.jpeg"),
                                        new Picture("norway_1.jpeg"),
                                    }
                                    .AutomationId("NorwayImage")
                                    .OnHoverIn(() => SetState(s => s.IsMouseHoverImage = true))
                                    .OnHoverOut(() => SetState(s => s.IsMouseHoverImage = false)),

                                new Text(State.IsMouseHoverImage ? "Mouse hovering" : "Awesome Norway!")
                                    .AutomationId("NorwayLabel")
                                    .HorizontalAlignment(HorizontalAlignment.Center)
                                    .VerticalAlignment(VerticalAlignment.Center)
                                    .FontColor(Colors.White)
                                    .FontSize(24)
                            },
                        }
                        .Margin(10)
                        .BackgroundColor(Colors.Red)
                        .CornerRadius(10)
                }
            }
        };
    }
}