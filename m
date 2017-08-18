From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Aug 2017 18:21:57 +0000
Subject: Re: [PATCH v3] fbcon: add fbcon=margin:<color> command line option
Message-Id: <CAMuHMdUx9ECvAiszXxtJ5hE5SjtRsOs5HYhG+OqFGaZwwwndww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501605357-30815-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501605357-30815-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi David,

On Tue, Aug 1, 2017 at 6:35 PM, David Lechner <david@lechnology.com> wrote:
> This adds a new command line option to select the fbcon margin color.
>
> The motivation for this is screens where black does not blend into the
> physical surroundings of the screen. For example, using an LCD (not the
> backlit kind), white text on a black background is hard to read, so
> inverting the colors is preferred. However, when you do this, most of the
> screen is filled with white but the margins are still filled with black.
> This makes a big, black, backwards 'L' on the screen. By setting
> fbcon=margin:7, the margins will be filled with white and the LCD looks as
> expected.
>
> Signed-off-by: David Lechner <david@lechnology.com>

> --- a/Documentation/fb/fbcon.txt
> +++ b/Documentation/fb/fbcon.txt
> @@ -148,6 +148,13 @@ C. Boot options
>         Actually, the underlying fb driver is totally ignorant of console
>         rotation.
>
> +5. fbcon=margin:<color>
> +
> +       This option specifies the color of the margins. The margins are the
> +       leftover area at the right and the bottom of the screen that are not
> +       used by text. By default, this area will be black. The 'color' value
> +       is 0 to 7 where 0 is black and 7 is white.
> +

Given the standard console palette contains 16 colors, why limit this to
the first 8 colors, and not 0 to 15?

> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -137,6 +137,7 @@ static int info_idx = -1;
>  /* console rotation */
>  static int initial_rotation;
>  static int fbcon_has_sysfs;
> +static int margin_color;
>
>  static const struct consw fb_con;
>
> @@ -491,6 +492,15 @@ static int __init fb_console_setup(char *this_opt)
>                                 initial_rotation = 0;
>                         continue;
>                 }
> +
> +               if (!strncmp(options, "margin:", 7)) {
> +                       options += 7;
> +                       if (*options)
> +                               margin_color = simple_strtoul(options, &options, 0);
> +                       if (margin_color > 7)
> +                               margin_color = 0;
> +                       continue;
> +               }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
