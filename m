From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 11 Apr 2013 09:49:28 +0000
Subject: Re: How to manage OMAP display drivers in the future
Message-Id: <12886065.a3bE0bBX2i@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1873136.QCsC9hHaEa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51403F91.7070401@iki.fi> <5165382F.8050401@ti.com>
In-Reply-To: <5165382F.8050401@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>


--nextPart1873136.QCsC9hHaEa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Wednesday 10 April 2013 13:00:15 Tomi Valkeinen wrote:
> On 2013-03-13 10:57, Tomi Valkeinen wrote:
> > Hi Dave,
> > 
> > I'm writing this mail to get some ideas how we should manage OMAP's
> > display drivers in the future.
> > 
> > As a short intro, we have the following players around:
> > 
> > omapdss - omapdss handles the DSS (display subsystem) hardware. omapdss
> > doesn't do any buffer management or expose any userspace API (except a
> > few sysfs files), so it doesn't do anything by itself.
> > (drivers/video/omap2/dss/)
> > 
> > panel drivers - Drivers for various panel models. The panel drivers use
> > omapdss API to manage the video bus. (drivers/video/omap2/displays/)
> > 
> > omapfb - Framebuffer driver, uses omapdss to handle the HW.
> > (drivers/video/omap2/omapfb/)
> > 
> > omap_vout - V4L2 driver for showing video, uses omapdss to handle the
> > HW. (drivers/media/platform/omap/)
> > 
> > omapdrm - DRM driver, uses omapdss to handle the HW.
> > (drivers/gpu/drm/omapdrm/)
> > 
> > omapdss and the panel drivers form the lowest level layer. omapfb and
> > omap_vout can be used at the same time, but omapdrm must be used alone,
> > without omapfb or omap_vout.
> > 
> > omapfb and omap_vout are not much developed anymore, even though they
> > are still commonly used. Most of the development happens in omapdss,
> > panel drivers and omapdrm.
> > 
> > So that's what we have now. In the distant future I see omapfb and
> > omap_vout disappear totally,

I'm all for that, but we need a migration plan. I plan to port my omap3-isp-
live application to omapdrm, I'll report any issue with my use cases.

> > the panel drivers would be made generic using Common Display Framework,
> > and omapdss and omapdrm would more or less be merged together. However,
> > all that is still far away, and we need some plan to go forward for now.
> >
> > Most pressing question is how to get OMAP display patches merged. It
> > seems that there's not really an fbdev maintainer for the time being,
> > and fbdev tree has been the route for omapdss, panels and omapfb in the
> > past. Now that omapdrm is the new main driver for omap display, fbdev
> > would be somewhat wrong in any case.
> > 
> > Dave, how would you feel about merging changes to all the above
> > components through DRM tree? Merging all the above together would be the
> > easiest way, as the changes may have dependencies to each other.
> > 
> > As I said, most of the development should be in omapdss, panels and
> > omapdrm. There would be an occasional fix for omapfb and omap_vout, or
> > small changes when omapdss changes require changes elsewhere.
> 
> Ping. Do you have any thoughts of the above?
> 
> We have a few patches for omapdrm for 3.10 that depend on omapdss
> patches. I'm currently acting as a fbdev maintainer (well, more like
> somebody who collects the fbdev patches that are quite surely ok), so I
> can take the problematic omapdrm patches via fbdev tree with the omapdss
> patches, if that's ok for you. And send the other omapdrm patches to be
> merged via drm tree.
> 
> Or, I could take all the omapdrm patches via fbdev tree, if that's
> better. There aren't too many of them for 3.10.

-- 
Regards,

Laurent Pinchart

--nextPart1873136.QCsC9hHaEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJRZocuAAoJEIkPb2GL7hl1hmYH/0JvOY+BKHC7F6VhT9vmlYQG
feoryLKpwj9lvfecvJUv0oCZnzr07iLdyLoV1NUAZwy83k/T/4qgL+3K3fF5vG2I
WIAe5lY5bPl3wEoRfWCQhU+vZRv+QiXTaqHyCjzvez28r7nBxqegLy+g6KGv27oi
Bs3J79lrg/uT9L8Nuz07cUsDE1hUmTFojolJcjnftoxUH3DIEnxg5PWnkpf0NjMI
J9B/2fgVV74lNvP9NA2cS2gMH8MI0MD9u/FFXANFzRE4TbvZeAiO19ptmC49KuJR
TJCKl3EeLywyyvwWocvUXuNDdLxPFKrqgRw+s9txXPlAOYkApfyhToDSKLIiUbY=
=1i8X
-----END PGP SIGNATURE-----

--nextPart1873136.QCsC9hHaEa--

