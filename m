From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Mar 2019 10:58:34 +0000
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
Message-Id: <CAKMK7uHndG4FHMQhgEZ9EHW+dtAKvtYiu7Nn1p1Kaxoa4FznvA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326145320.GJ2665@phenom.ffwll.local>
 <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
 <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>
 <6c6f22ff-b643-ee02-aacc-6c86f20fe0ea@daenzer.net>
In-Reply-To: <6c6f22ff-b643-ee02-aacc-6c86f20fe0ea@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Dave Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Thomas Zimmermann <tzimmermann@suse.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Mar 27, 2019 at 10:55 AM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
>
> On 2019-03-27 10:41 a.m., Daniel Vetter wrote:
> > On Wed, Mar 27, 2019 at 10:10 AM Thomas Zimmermann <tzimmermann@suse.de=
> wrote:
> >> Am 26.03.19 um 15:53 schrieb Daniel Vetter:
> >>>
> >>> Looks surprisingly clean, at least from a quick read. Only big thing I
> >>> noticed on the implementation side is that you probably want to use t=
he
> >>> simple display helpers. At least that's a much better fit for simple
> >>> display hw supported by these fbdev drivers.
> >>
> >> I thought about using the simple-DRM helpers, but found that a full DRM
> >> driver would be more helpful for porting over fbdev drivers. Unless
> >> simple DRM is a hard requirement, I'd prefer to leave it this way.
> >>
> >> For those devices that only support a single pipeline, the conversion =
to
> >> simple DRM should then be mandatory during the porting process.
> >
> > fbdev only supports a single output, all multi-head extensions are
> > driver specific ioctl hacks. Given that all you can do is switch it on
> > or off (with a given mode), simple pipe helpers are the perfect fit
> > for fbdev.
> >
> > Some drivers might support more (like multiple heads, or at least
> > different outputs), and those we should convert over. But at least for
> > step 1 in converting fbdev drivers over, simple pipe is the right
> > starting point I think.
>
> Converting an fbdev driver to a KMS one loses some features:
>
> 1) Dynamically switching modes / colour formats via fbdev.

Possible to add that to drm_fb_helper.c, it's just after 10+ years
still no one cares, so it didn't happen. We have added a bunch of
fbdev emulation features for stuff people wanted, so patches are
welcome. And will be merged, if they exist.

Ofc will be rather limited since fbdev only has one output. But should
be possible to at least faithfully map for the simple case of only 1
connected output. Ofc we still can't reallocate the fbdev bo, because
fbdev really doesn't like when the aperture moves around. Fixing that
is possible, if you fix the fbdev vs. fbcon locking, which is probably
a few man-years of engineering (I looked at it recently for reasons,
it's totally broken and full of ABBA issues, solved by simply not
taking the other lock).

> 2) fbcon acceleration (or maybe this can be preserved?).

gma500 has fbcon accel. i915 had patches, but wasn't worth it. It's
possible, but demand for this seems approximately nil. We do support
fbdev page flipping, through the overallocate parameter.

> In turn, it allows exposing additional functionality:
>
> 3) Multiple outputs via KMS.
4) multi-master and multi-client (at least if we properly manage the
vram with ttm for discrete, socs should use the cma helpers). I think
that's the big one, and why compositors might want to have kms even
for dumb display hw.
5) on socs: prime buffer sharing, that seems to be the main reason we
gained a few fbdev conversion in kms recently

> Is there any benefit in converting a driver without adding 3)? If not,
> is simple pipe still a good starting point?

simple pipe still allows multiple outputs if they're entirely
separate. Only thing it limits is:
1) only 1 fixed plane per crtc
2) fixed crtc->output routing (but with the option to plug in
drm_bridge transcoders into that fixed pipeline for code sharing).

I still think simple_pipe is a good starting point for most fbdev
drivers left. All the fancy ones that support multiple outputs and
output switching do have at least a basic kms driver already. Since
atomic helpers are fairly modular (and simple pipe builds on top of
atomic helpers) it should be easy to extend from simple pipe to full
atomic once necessary.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
