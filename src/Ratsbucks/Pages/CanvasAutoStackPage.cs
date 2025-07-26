using MauiReactor.Canvas;

namespace Ratsbucks.Pages;

class CanvasAutoStackPageState
{
    public float FullHeight { get; set; }
    public float AutoSizedBoxHeight { get; set; } = float.NaN;

    public float FullWidth { get; set; }
    public float AutoSizedBoxWidth { get; set; } = float.NaN;
}

class CanvasAutoStackPage : Component<CanvasAutoStackPageState>
{
    public override VisualNode Render()
    {
        return new ContentPage("Canvas Auto V/H Stack Test Page")
        {
            new CanvasView
            {
                new Column("*, *")
                {
                    new Column("100, *")
                    {
                        new Text($"Total Stack Height: {State.FullHeight}")
                            .HorizontalAlignment(HorizontalAlignment.Center)
                            .VerticalAlignment(VerticalAlignment.Center),

                        new VAutoStack()
                            {
                                new Box()
                                    {
                                        new Text("Height = 200 (default)")
                                            .HorizontalAlignment(HorizontalAlignment.Center)
                                            .VerticalAlignment(VerticalAlignment.Center)
                                            .FontColor(Colors.White)
                                    }
                                    .BackgroundColor(Colors.Red),

                                new Box()
                                    {
                                        new Text($"Height = {State.AutoSizedBoxHeight}")
                                            .HorizontalAlignment(HorizontalAlignment.Center)
                                            .VerticalAlignment(VerticalAlignment.Center)
                                            .FontColor(Colors.White)
                                            .OnMeasure((s, args) => SetState(s => s.AutoSizedBoxHeight = args.Size.Height))
                                    }
                                    .AutoStackHeight(State.AutoSizedBoxHeight)
                                    .BackgroundColor(Colors.Green),
                            }
                            .DefaultHeight(200)
                            .OnSizeChanged((s, args) => SetState(s => s.FullHeight = args.Size.Height))
                    },

                    new Column("100, *")
                    {
                        new Text($"Total Stack Width: {State.FullWidth}")
                            .HorizontalAlignment(HorizontalAlignment.Center)
                            .VerticalAlignment(VerticalAlignment.Center),

                        new HAutoStack()
                            {
                                new Box()
                                    {
                                        new Text("Width = 300 (default)")
                                            .HorizontalAlignment(HorizontalAlignment.Center)
                                            .VerticalAlignment(VerticalAlignment.Center)
                                            .FontColor(Colors.White)
                                    }
                                    .BackgroundColor(Colors.Red),

                                new Box()
                                    {
                                        new Text($"Auto Sized Width")
                                            .HorizontalAlignment(HorizontalAlignment.Center)
                                            .VerticalAlignment(VerticalAlignment.Center)
                                            .FontColor(Colors.White)
                                            .OnMeasure((s, args) => SetState(s => s.AutoSizedBoxWidth = (int)args.Size.Width))
                                    }
                                    .AutoStackWidth(State.AutoSizedBoxWidth)
                                    .BackgroundColor(Colors.Green),
                            }
                            .DefaultWidth(300)
                            .OnSizeChanged((s, args) => SetState(s => s.FullWidth = args.Size.Width))
                    }
                }
            }
        };
    }
}