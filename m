From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 27 Apr 2018 18:25:37 +0000
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Message-Id: <20180427182536.skryxiih5lekqoze@darkstar.musicnaut.iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
 <2238944.jilJcacc6d@amdc3058>
In-Reply-To: <2238944.jilJcacc6d@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 27, 2018 at 05:09:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> omapfb equivalent of drm's commit aa61321d4c08 ("drm/omap: remove rfbi"):
> 
> The RFBI driver has not worked nor compiled for many years. There are

What is the build failure you are seeing?

When removing the "BROKEN", it seems to compile fine, only some sparse
warnings:

  CHECK   /home/aaro/git/devel/linux/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
/home/aaro/git/devel/linux/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c:519:21: warning: expression using sizeof(void)
/home/aaro/git/devel/linux/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c:519:21: warning: expression using sizeof(void)
/home/aaro/git/devel/linux/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c:520:25: warning: expression using sizeof(void)
/home/aaro/git/devel/linux/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c:520:25: warning: expression using sizeof(void)
/home/aaro/git/devel/linux/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c:1018:16: error: return expression in void function
  CC [M]  drivers/video/fbdev/omap2/omapfb/dss/rfbi.o
  CC [M]  drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.o

A.
