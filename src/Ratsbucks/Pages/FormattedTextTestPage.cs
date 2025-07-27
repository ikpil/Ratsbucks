namespace Ratsbucks.Pages;

class FormattedTextTestPage : Component
{
    public override VisualNode Render()
        => ContentPage("Formatted Text",
            VStack(
                    Label(
                        FormattedString(
                            Span("style 1, "),
                            Span("Red bold, ", Colors.Red, FontAttributes.Bold),
                            Span("default, ",
                                TapGestureRecognizer(async () => await ContainerPage!.DisplayAlert("Tapped", "This is a tapped Span.", "OK"))
                            ),
                            Span("italic small.", FontAttributes.Italic, 14)
                        )
                    ),
                    Label()
                        .FormattedText(() =>
                        {
                            //of course FomattedText here, being static, can be created as a static variable and passed to Label().FormattedText(myStaticFormattedText)
                            MauiControls.FormattedString formattedString = new();
                            formattedString.Spans.Add(new MauiControls.Span { Text = "style 2, " });
                            formattedString.Spans.Add(new MauiControls.Span { Text = "Red bold, ", TextColor = Colors.Red, FontAttributes = FontAttributes.Bold });

                            MauiControls.Span span = new() { Text = "default, " };
                            span.GestureRecognizers.Add(new MauiControls.TapGestureRecognizer { Command = new Command(async () => await ContainerPage!.DisplayAlert("Tapped", "This is a tapped Span.", "OK")) });
                            formattedString.Spans.Add(span);
                            formattedString.Spans.Add(new MauiControls.Span { Text = "italic small.", FontAttributes = FontAttributes.Italic, FontSize = 14 });

                            return formattedString;
                        })
                )
                .Spacing(10)
                .Center()
        );
}