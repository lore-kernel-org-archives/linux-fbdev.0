From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 07 Jan 2019 09:11:04 +0000
Subject: Re: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line, option
Message-Id: <CAMuHMdXMidVgtz-T8PZDUrKAwJmz9B4g1hNgw6FwrCpU-m5Gew@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
 <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
 <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
 <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
 <662db203-ae18-4a11-7b10-3d7d480f6f37@axentia.se>
In-Reply-To: <662db203-ae18-4a11-7b10-3d7d480f6f37@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Rosin <peda@axentia.se>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Peter,

On Mon, Jan 7, 2019 at 10:03 AM Peter Rosin <peda@axentia.se> wrote:
> On 2019-01-07 09:59, Peter Rosin wrote:
> > On 2019-01-07 09:40, Geert Uytterhoeven wrote:
> >> On Mon, Jan 7, 2019 at 9:26 AM Peter Rosin <peda@axentia.se> wrote:
> >>> On 2019-01-06 10:33, Geert Uytterhoeven wrote:
> >>>> On Mon, Nov 26, 2018 at 10:59 PM Peter Rosin <peda@axentia.se> wrote:
> >>>>> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
> >>>>> extra logos are not considered when centering the first logo vertic=
ally.
> >>>>>
> >>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>>
> >>>>> --- a/drivers/video/logo/Kconfig
> >>>>> +++ b/drivers/video/logo/Kconfig
> >>>>> @@ -10,6 +10,15 @@ menuconfig LOGO
> >>>>>
> >>>>>  if LOGO
> >>>>>
> >>>>> +config FB_LOGO_CENTER
> >>>>> +       bool "Center the logo"
> >>>>> +       depends on FB=3Dy
> >>>>> +       help
> >>>>> +         When this option is selected, the bootup logo is centered=
 both
> >>>>> +         horizontally and vertically. If more than one logo is dis=
played
> >>>>> +         due to multiple CPUs, the collected line of logos is cent=
ered
> >>>>> +         as a whole.
> >>>>> +
> >>>>
> >>>> Isn't a kernel command line option more suitable to configure the po=
sition
> >>>> of the logo?
> >>>
> >>> That didn't occur to me previously, but it does make sense now that y=
ou
> >>> mention it. This is on top of v5.0-rc1, and if applied before v5.0 we
> >>> can avoid possible regressions for folks who might start to rely on
> >>> CONFIG_FB_LOGO_CENTER if v5.0 is released w/o this.
> >>>
> >>> Cheers,
> >>> Peter
> >>>
> >>> From de7353ab519ba9b5c9ea3f62d607bb8e94b687cc Mon Sep 17 00:00:00 2001
> >>> From: Peter Rosin <peda@axentia.se>
> >>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> Cc: Jonathan Corbet <corbet@lwn.net>
> >>> Cc: Peter Rosin <peda@axentia.se>
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Cc: linux-fbdev@vger.kernel.org
> >>> Cc: linux-doc@vger.kernel.org
> >>> To: linux-kernel@vger.kernel.org
> >>> Date: Mon, 7 Jan 2019 08:35:26 +0100
> >>> Subject: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a c=
md line
> >>>  option
> >>>
> >>> A command line option is much more flexible than a config option and
> >>> the supporting code is small. Gets rid of #ifdefs in the code too...
> >>>
> >>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>
> >> Thanks for your patch!
> >>
> >>> --- a/Documentation/fb/fbcon.txt
> >>> +++ b/Documentation/fb/fbcon.txt
> >>> @@ -163,6 +163,12 @@ C. Boot options
> >>>         be preserved until there actually is some text is output to t=
he console.
> >>>         This option causes fbcon to bind immediately to the fbdev dev=
ice.
> >>>
> >>> +7. fbcon=CEnter-logo
> >>> +
> >>> +       When this option is selected, the bootup logo is centered both
> >>> +       horizontally and vertically. If more than one logo is display=
ed due to
> >>> +       multiple CPUs, the collected line of logos is centered as a w=
hole.
> >>> +
> >>
> >> What about making this more generic, than an option specific for cente=
ring?
> >> Else people want fbcon=3Dleft-logo or fbcon=3Dright-logo soon?
> >>
> >>     fbcon=3Dlogo-pos:<pos>
> >>
> >> With <pos> being "center", "left", "top", "right", "bottom", and combi=
nations
> >> like "top,center"? Or is that complicating stuff too much?
> >
> > I'm not too keen on implementing all that when I have zero use for it. =
I can
> > however rename the trigger for the existing fb_center_logo bool to
> >
> >       fbcon=3Dlogo-pos:center
> >
> > and add a check for "top,left" to reset the bool to false. Then the oth=
er
> > variants can be added later by whomever and when needed.
> >
> > Is that good enough?
>
> Ouch, I just realized that using a comma is a no-go, as that is already
> separating fbcon suboptions, so I suggest top-left instead.

Sure, sounds fine to me.  I just want to avoid having a parameter system
that complicates future extension.
I think you can drop the check for top-left, as the bool defaults to false.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
