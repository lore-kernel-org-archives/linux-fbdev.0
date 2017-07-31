From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 31 Jul 2017 16:38:19 +0000
Subject: Re: [PATCH RESEND] fbdev: omapfb: remove unused variable
Message-Id: <2971705.ICzXV4uNZt@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170726135825epcas4p3c5326b3893927c4be0db0fde076d0799@epcas4p3.samsung.com>
 <20170726135816.2216688-1-arnd@arndb.de> <10646277.hB6jvi1uWb@amdc3058>
In-Reply-To: <10646277.hB6jvi1uWb@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org

On Wednesday, July 26, 2017 04:27:30 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, July 26, 2017 03:57:55 PM Arnd Bergmann wrote:
> > Removing the default display name left a harmless warning:
> > 
> > fbdev/omap2/omapfb/dss/core.c: In function 'omap_dss_probe':
> > fbdev/omap2/omapfb/dss/core.c:196:30: error: unused variable 'pdata' [-Werror=unused-variable]
> > 
> > This removes the now-unused variable as well.
> > 
> > Fixes: 278cba7eaf54 ("drm: omapdrm: Remove unused default display name support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Originally submitted on June 9, no reply other than the Reviewed-by tag.
> > The patch is still needed
> 
> It is not lost and will be queued for 4.13 fbdev fixes pull request.
> 
> [ The guilty commit went through DRM tree and pulling it into fbdev
>   tree just to fix the warning was not feasible.. ]

Patch queued for 4.13, thanks. 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

