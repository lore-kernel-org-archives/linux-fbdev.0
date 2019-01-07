From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 07 Jan 2019 08:40:46 +0000
Subject: Re: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line, option
Message-Id: <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
 <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
In-Reply-To: <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Rosin <peda@axentia.se>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Peter,

On Mon, Jan 7, 2019 at 9:26 AM Peter Rosin <peda@axentia.se> wrote:
> On 2019-01-06 10:33, Geert Uytterhoeven wrote:
> > On Mon, Nov 26, 2018 at 10:59 PM Peter Rosin <peda@axentia.se> wrote:
> >> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
> >> extra logos are not considered when centering the first logo verticall=
y.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >
> >> --- a/drivers/video/logo/Kconfig
> >> +++ b/drivers/video/logo/Kconfig
> >> @@ -10,6 +10,15 @@ menuconfig LOGO
> >>
> >>  if LOGO
> >>
> >> +config FB_LOGO_CENTER
> >> +       bool "Center the logo"
> >> +       depends on FB=3Dy
> >> +       help
> >> +         When this option is selected, the bootup logo is centered bo=
th
> >> +         horizontally and vertically. If more than one logo is displa=
yed
> >> +         due to multiple CPUs, the collected line of logos is centered
> >> +         as a whole.
> >> +
> >
> > Isn't a kernel command line option more suitable to configure the posit=
ion
> > of the logo?
>
> That didn't occur to me previously, but it does make sense now that you
> mention it. This is on top of v5.0-rc1, and if applied before v5.0 we
> can avoid possible regressions for folks who might start to rely on
> CONFIG_FB_LOGO_CENTER if v5.0 is released w/o this.
>
> Cheers,
> Peter
>
> From de7353ab519ba9b5c9ea3f62d607bb8e94b687cc Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Date: Mon, 7 Jan 2019 08:35:26 +0100
> Subject: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd l=
ine
>  option
>
> A command line option is much more flexible than a config option and
> the supporting code is small. Gets rid of #ifdefs in the code too...
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks for your patch!

> --- a/Documentation/fb/fbcon.txt
> +++ b/Documentation/fb/fbcon.txt
> @@ -163,6 +163,12 @@ C. Boot options
>         be preserved until there actually is some text is output to the c=
onsole.
>         This option causes fbcon to bind immediately to the fbdev device.
>
> +7. fbcon=CEnter-logo
> +
> +       When this option is selected, the bootup logo is centered both
> +       horizontally and vertically. If more than one logo is displayed d=
ue to
> +       multiple CPUs, the collected line of logos is centered as a whole.
> +

What about making this more generic, than an option specific for centering?
Else people want fbcon=3Dleft-logo or fbcon=3Dright-logo soon?

    fbcon=3Dlogo-pos:<pos>

With <pos> being "center", "left", "top", "right", "bottom", and combinatio=
ns
like "top,center"? Or is that complicating stuff too much?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
