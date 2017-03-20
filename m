From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 20 Mar 2017 18:42:56 +0000
Subject: Re: [PATCH] video: fbdev: i810: remove incorrect __exit markups
Message-Id: <20170320184256.GB23083@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170302013109epcas3p3ae90f60d7aa8f14bb09eb5ec342cfaeb@epcas3p3.samsung.com>
 <20170302013101.GA2047@dtor-ws>
 <1880466.B5ZPIScV32@amdc3058>
In-Reply-To: <1880466.B5ZPIScV32@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Mon, Mar 20, 2017 at 06:19:17PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, March 01, 2017 05:31:01 PM Dmitry Torokhov wrote:
> > Even if bus is not hot-pluggable, devices can be unbound from the
> > driver via sysfs, so we should not be using __exit annotations on
> > remove() methods. The only exception is drivers registered with
> > platform_driver_probe() which specifically disables sysfs bind/unbind
> > attributes.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Patch queued for 4.12, thanks.
> 
> It seems that there are still some fbdev drivers with this issue:

I do not think so:

> 
> $ git grep __exit_p drivers/video/fbdev/
> drivers/video/fbdev/amifb.c:    .remove = __exit_p(amifb_remove),

Registered as module_platform_driver_probe(), which ends up suppressing
sysfs bind/unbind attributes.

> drivers/video/fbdev/atmel_lcdfb.c:      .remove         = __exit_p(atmel_lcdfb_remove),

Registered as module_platform_driver_probe(), which ends up suppressing
sysfs bind/unbind attributes.

> drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c:        .remove = __exit_p(tvc_remove),
> drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c:      .remove = __exit_p(dvic_remove),
> drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c:     .remove = __exit_p(hdmic_remove),
> drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c:     .remove = __exit_p(opa362_remove),
> drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c:     .remove = __exit_p(tfp410_remove),
> drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c:  .remove = __exit_p(tpd_remove),
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:  .remove = __exit_p(panel_dpi_remove),
> drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c:       .remove = __exit_p(dsicm_remove),
> drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:    .remove = __exit_p(sharp_ls_remove),

As far as I can see all omapfb/displays/ drivers explicitly disable
bind/unbind attributes by setting:

		.suppress_bind_attrs = true,


> drivers/video/fbdev/omap2/omapfb/vrfb.c:        .remove         = __exit_p(vrfb_remove),

Registered as module_platform_driver_probe(), which ends up suppressing
sysfs bind/unbind attributes.

Thanks.

-- 
Dmitry
