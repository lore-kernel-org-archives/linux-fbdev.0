From: Tomi Valkeinen <tomba@iki.fi>
Date: Wed, 13 Mar 2013 08:57:53 +0000
Subject: How to manage OMAP display drivers in the future
Message-Id: <51403F91.7070401@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@linux.ie>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

Hi Dave,

I'm writing this mail to get some ideas how we should manage OMAP's
display drivers in the future.

As a short intro, we have the following players around:

omapdss - omapdss handles the DSS (display subsystem) hardware. omapdss
doesn't do any buffer management or expose any userspace API (except a
few sysfs files), so it doesn't do anything by itself.
(drivers/video/omap2/dss/)

panel drivers - Drivers for various panel models. The panel drivers use
omapdss API to manage the video bus. (drivers/video/omap2/displays/)

omapfb - Framebuffer driver, uses omapdss to handle the HW.
(drivers/video/omap2/omapfb/)

omap_vout - V4L2 driver for showing video, uses omapdss to handle the
HW. (drivers/media/platform/omap/)

omapdrm - DRM driver, uses omapdss to handle the HW.
(drivers/gpu/drm/omapdrm/)

omapdss and the panel drivers form the lowest level layer. omapfb and
omap_vout can be used at the same time, but omapdrm must be used alone,
without omapfb or omap_vout.

omapfb and omap_vout are not much developed anymore, even though they
are still commonly used. Most of the development happens in omapdss,
panel drivers and omapdrm.

So that's what we have now. In the distant future I see omapfb and
omap_vout disappear totally, the panel drivers would be made generic
using Common Display Framework, and omapdss and omapdrm would more or
less be merged together. However, all that is still far away, and we
need some plan to go forward for now.

Most pressing question is how to get OMAP display patches merged. It
seems that there's not really an fbdev maintainer for the time being,
and fbdev tree has been the route for omapdss, panels and omapfb in the
past. Now that omapdrm is the new main driver for omap display, fbdev
would be somewhat wrong in any case.

Dave, how would you feel about merging changes to all the above
components through DRM tree? Merging all the above together would be the
easiest way, as the changes may have dependencies to each other.

As I said, most of the development should be in omapdss, panels and
omapdrm. There would be an occasional fix for omapfb and omap_vout, or
small changes when omapdss changes require changes elsewhere.

 Tomi
