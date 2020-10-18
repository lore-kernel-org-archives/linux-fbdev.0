From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Sun, 18 Oct 2020 20:18:11 +0000
Subject: Re: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
Message-Id: <20201018201811.GA697615@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
 <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
 <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
In-Reply-To: <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sven Schneider <s.schneider@arkona-technologies.de>, Pengutronix Kernel Team <kernel@pengutronix.de>

On Sun, Oct 18, 2020 at 10:09:06PM +0200, Daniel Vetter wrote:
> Adding dri-devel too, not sure anyone is still listening on linux-fbdev.

I see, thanks!

> On Sun, Oct 18, 2020 at 8:13 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> >
> > Recently, in commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macr=
os
> > for built-in fonts"), we wrapped each of our built-in data buffers in a
> > `font_data` structure, in order to use the following macros on them, see
> > include/linux/font.h:
> >
> >         #define REFCOUNT(fd)    (((int *)(fd))[-1])
> >         #define FNTSIZE(fd)     (((int *)(fd))[-2])
> >         #define FNTCHARCNT(fd)  (((int *)(fd))[-3])
> >         #define FNTSUM(fd)      (((int *)(fd))[-4])
> >
> >         #define FONT_EXTRA_WORDS 4
> >
> > Do the same thing to our new 6x8 font. For built-in fonts, currently we
> > only use FNTSIZE(). Since this is only a temporary solution for an
> > out-of-bounds issue in the framebuffer layer (see commit 5af08640795b
> > ("fbcon: Fix global-out-of-bounds read in fbcon_get_font()")), all the
> > three other fields are intentionally set to zero in order to discourage
> > using these negative-indexing macros.
> >
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
>=20
> Patch looks good to me, but it says 1/2 and I can't find 2/2 anywhere,
> not even on lore. Did that get lost?

2/2 is just updating the fb documentation:

[PATCH 2/2] docs: fb: Add font_6x8 to available built-in fonts
https://lore.kernel.org/lkml/717bb41dda8e2ed615f3faadfbc3e215de726d38.16030=
37079.git.yepeilin.cs@gmail.com/

I did `git format-patch -2 --thread=DEep`, did I do something wrong when
sending it?

Thank you,
Peilin Ye
