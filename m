From: Rob Clark <robdclark@gmail.com>
Date: Mon, 18 Mar 2013 20:46:24 +0000
Subject: Re: How to manage OMAP display drivers in the future
Message-Id: <CAF6AEGs_6kLU=OR-mX9kvr=_t9-z4+StobksaW+MfcnhEu2XvA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51403F91.7070401@iki.fi>
In-Reply-To: <51403F91.7070401@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomba@iki.fi>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On Wed, Mar 13, 2013 at 4:57 AM, Tomi Valkeinen <tomba@iki.fi> wrote:
> Hi Dave,
>
> I'm writing this mail to get some ideas how we should manage OMAP's
> display drivers in the future.
>
> As a short intro, we have the following players around:
>
> omapdss - omapdss handles the DSS (display subsystem) hardware. omapdss
> doesn't do any buffer management or expose any userspace API (except a
> few sysfs files), so it doesn't do anything by itself.
> (drivers/video/omap2/dss/)
>
> panel drivers - Drivers for various panel models. The panel drivers use
> omapdss API to manage the video bus. (drivers/video/omap2/displays/)
>
> omapfb - Framebuffer driver, uses omapdss to handle the HW.
> (drivers/video/omap2/omapfb/)
>
> omap_vout - V4L2 driver for showing video, uses omapdss to handle the
> HW. (drivers/media/platform/omap/)
>
> omapdrm - DRM driver, uses omapdss to handle the HW.
> (drivers/gpu/drm/omapdrm/)
>
> omapdss and the panel drivers form the lowest level layer. omapfb and
> omap_vout can be used at the same time, but omapdrm must be used alone,
> without omapfb or omap_vout.
>
> omapfb and omap_vout are not much developed anymore, even though they
> are still commonly used. Most of the development happens in omapdss,
> panel drivers and omapdrm.

I'd guess if changes in omapfb or omap_vout are mainly just updates
resulting from omapdss changes, maybe merging it all via drm tree
would make most sense..

Although I tend to think life would be easier w/ some copy/paste.. Ie.
just move a copy of omapdss into omapdrm directory and start
refactoring.. Offhand I think at least in the hdmi code, I think we
could jettison the big timings table, and avi-infoframe stuff and use
drm helpers.  Probably other places where we could get rid of code
that duplicates stuff that drm does (or could) provide helpers for..

BR,
-R

> So that's what we have now. In the distant future I see omapfb and
> omap_vout disappear totally, the panel drivers would be made generic
> using Common Display Framework, and omapdss and omapdrm would more or
> less be merged together. However, all that is still far away, and we
> need some plan to go forward for now.
>
> Most pressing question is how to get OMAP display patches merged. It
> seems that there's not really an fbdev maintainer for the time being,
> and fbdev tree has been the route for omapdss, panels and omapfb in the
> past. Now that omapdrm is the new main driver for omap display, fbdev
> would be somewhat wrong in any case.
>
> Dave, how would you feel about merging changes to all the above
> components through DRM tree? Merging all the above together would be the
> easiest way, as the changes may have dependencies to each other.
>
> As I said, most of the development should be in omapdss, panels and
> omapdrm. There would be an occasional fix for omapfb and omap_vout, or
> small changes when omapdss changes require changes elsewhere.
>
>  Tomi
