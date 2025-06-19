using MauiReactor;

namespace Ratsbucks.Pages;

public class Card
{
    public int Index { get; init; }
    public int Position { get; set; }
}

public class CardAnimationPageState
{
    public List<Card> Cards { get; set; } = Enumerable.Range(1, 10).Select(index => new Card()
    {
        Index = index - 1,
        Position = index
    }).ToList();
}

public class CardsAnimationPage : Component<CardAnimationPageState>
{
    public override VisualNode Render()
    {
        return ContentPage(
            [
                Grid(
                        State.Cards
                            .Select(card => new CardPage()
                                .Index(card.Index)
                                .Position(card.Position)
                                .OnMovedBack(cardIndex =>
                                {
                                    SetState(s =>
                                    {
                                        foreach (var card in s.Cards)
                                        {
                                            card.Position++;
                                        }

                                        s.Cards[cardIndex].Position = 1;
                                    });
                                })
                            )
                            .ToArray()
                    )
                    .Background(Microsoft.Maui.Controls.Brush.Black)
            ])
            .Title("Animation Sample");
    }
}

public class CardPageState
{
    public double Rotation { get; set; } = Random.Shared.NextDouble() * 5 - 2.5;

    public bool MovingBack { get; set; }
}

public partial class CardPage : Component<CardPageState>
{
    private static readonly Microsoft.Maui.Controls.Brush[] _cardBackgrounds = new[]
        {
            (From: "#36D1DC", To: "#5B86E5"),
            (From: "#CB356B", To: "#BD3F32"),
            (From: "#283c86", To: "#45a247"),
            (From: "#EF3B36", To: "#FFFFFF"),
            (From: "#c0392b", To: "#8e44ad"),
            (From: "#159957", To: "#155799"),
            (From: "#000046", To: "#1CB5E0"),
            (From: "#007991", To: "#78ffd6"),
            (From: "#56CCF2", To: "#2F80ED"),
            (From: "#F2994A", To: "#F2C94C"),
        }
        .Select(MakeBrush)
        .ToArray();

    public static Microsoft.Maui.Controls.Brush MakeBrush((string From, string To) fromTo)
    {
        var brush = new Microsoft.Maui.Controls.LinearGradientBrush();
        brush.GradientStops.Add(new Microsoft.Maui.Controls.GradientStop(Color.FromArgb(fromTo.From), 0.0f));
        brush.GradientStops.Add(new Microsoft.Maui.Controls.GradientStop(Color.FromArgb(fromTo.To), 1.0f));
        return brush;
    }

    [Prop] private int _index;

    [Prop] private int _position;

    [Prop] private Action<int>? _onMovedBack;

    public override VisualNode Render()
    {
        return Border(
                [
                    Timer()
                        .Interval(300)
                        .OnTick(() =>
                        {
                            if (State.MovingBack)
                            {
                                State.MovingBack = false;
                                _onMovedBack?.Invoke(_index);
                            }
                        })
                        .IsEnabled(State.MovingBack)
                ])
                .ZIndex(_position)
                .TranslationY(State.MovingBack ? -230 : 0)
                .Rotation(State.Rotation)
                .WithAnimation()
                .Background(_cardBackgrounds[_index])
                .WidthRequest(300)
                .HeightRequest(200)
                .StrokeCornerRadius(5)
                .VEnd()
                .HCenter()
                .Margin(0, 40)
                .OnTapped(() =>
                {
                    SetState(s =>
                    {
                        s.MovingBack = true;
                        s.Rotation += 360 * 2;
                    });
                })
            ;
    }
}