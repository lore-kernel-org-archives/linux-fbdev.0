From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 26 Jul 2017 14:50:52 +0000
Subject: Re: [PATCH RESEND] fbdev: omapfb: remove unused variable
Message-Id: <20170726145052.qpuxx37dible2vie@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170726135825epcas4p3c5326b3893927c4be0db0fde076d0799@epcas4p3.samsung.com>
 <20170726135816.2216688-1-arnd@arndb.de>
 <10646277.hB6jvi1uWb@amdc3058>
 <CAK8P3a3CrnkRW61eX03tWnd4gt6uA+fq2Oe+VHf=00W5AHyNXA@mail.gmail.com>
In-Reply-To: <CAK8P3a3CrnkRW61eX03tWnd4gt6uA+fq2Oe+VHf=00W5AHyNXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org

On Wed, Jul 26, 2017 at 04:31:38PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 26, 2017 at 4:27 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Wednesday, July 26, 2017 03:57:55 PM Arnd Bergmann wrote:
> >> Removing the default display name left a harmless warning:
> >>
> >> fbdev/omap2/omapfb/dss/core.c: In function 'omap_dss_probe':
> >> fbdev/omap2/omapfb/dss/core.c:196:30: error: unused variable 'pdata' [-Werror=unused-variable]
> >>
> >> This removes the now-unused variable as well.
> >>
> >> Fixes: 278cba7eaf54 ("drm: omapdrm: Remove unused default display name support")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> ---
> >> Originally submitted on June 9, no reply other than the Reviewed-by tag.
> >> The patch is still needed
> >
> > It is not lost and will be queued for 4.13 fbdev fixes pull request.
> 
> Ok, thanks a lot!
> 
> > [ The guilty commit went through DRM tree and pulling it into fbdev
> >   tree just to fix the warning was not feasible.. ]
> 
> Yes, I was originally hoping the fix could be merged along with the
> patch that introduced the bug. I may have messed up the Cc list for that
> though.

Should we add dri-devel as an mailing list entry to the fbdev system in
MAINTAINERS? Iirc there's almost no traffic for fbdev itself, and this
would avoid such a fumble in the future.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
