From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 19 Feb 2018 09:10:43 +0000
Subject: Re: [PATCH] drm/fb-helper: Scale back depth to supported maximum
Message-Id: <20180219091043.GE22199@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180201130446.6165-1-linus.walleij@linaro.org>
 <20180201131907.GO5453@intel.com>
 <CACRpkdaFyKYxnVB-QuUiT+G9QcrpyPkzd2KXUm1sWNSgzyF9AA@mail.gmail.com>
 <20180202140343.GX5453@intel.com>
In-Reply-To: <20180202140343.GX5453@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 02, 2018 at 04:03:43PM +0200, Ville Syrj=E4l=E4 wrote:
> On Fri, Feb 02, 2018 at 02:56:30PM +0100, Linus Walleij wrote:
> > On Thu, Feb 1, 2018 at 2:19 PM, Ville Syrj=E4l=E4
> > <ville.syrjala@linux.intel.com> wrote:
> > > [Me]
> > >> +     /*
> > >> +      * If we run into a situation where, for example, the primary =
plane
> > >> +      * supports RGBA5551 (16 bpp, depth 15) but not RGB565 (16 bpp=
, depth
> > >> +      * 16) we need to scale down the depth of the sizes we request.
> > >> +      */
> > >> +     drm_for_each_plane(plane, fb_helper->dev) {
> > >> +             /* Only check the primary plane */
> > >> +             if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
> > >> +                     continue;
> > >
> > > I think this should look at crtc->primary for each of the crtcs manag=
ed
> > > by the fb_helper.
> > >
> > > Also this probably shouldn't look at YUV formats at all?
> >=20
> > I guess I can look into doing it this way, sorry for not knowing how to
> > properly inspect DRM objects, I'm lost sometimes...
> >=20
> > > I do wonder if instead we should just have the driver specify the
> > > pixel format explicitly instead of trying to guess based on bpp?
> >=20
> > That makes a lot more sense to me actually. It would
> > give a better sense of control so the driver feel it knows
> > what is actually going on.
> >=20
> > So I would just update
> > drm_fb_cma_fbdev_init() and drm_fb_helper_initial_config()
> > to pass a reasonable pixel format instead and refactor all the
> > way down?
>=20
> Yeah, something along those lines would seem like the better approach
> to me. But it's been a while since I've looked at this code so I might
> be totally wrong :)

Yeah, that would definitely fit better with the new world - fbdev
emulation hasnt ever been updated to the pixel format approach.

But fbdev emulation also predates the list of acceptable formats for each
plane, so I'd go one step further and try to out-guess something if the
driver passes a pixel format of 0. Your above loop almost does that
already. That way only drivers which want something non-standard would
need to set that parameter. For everyone else we could go through all
rgb/bgr formats, from most pixels to least (well, all those that fbdev
supports), with C8 as the ultimate fallback.

But just going to pixel formats would be a good step already for sure.
-Daniel

>=20
> >=20
> > It does hit a lot of code on the way, but if everyone thinks this
> > is a good idea I can very well take a stab at it.
> >=20
> > Yours,
> > Linus Walleij
>=20
> --=20
> Ville Syrj=E4l=E4
> Intel OTC
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
