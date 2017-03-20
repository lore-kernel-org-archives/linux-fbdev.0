From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Mar 2017 17:19:17 +0000
Subject: Re: [PATCH] video: fbdev: i810: remove incorrect __exit markups
Message-Id: <1880466.B5ZPIScV32@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170302013109epcas3p3ae90f60d7aa8f14bb09eb5ec342cfaeb@epcas3p3.samsung.com>
 <20170302013101.GA2047@dtor-ws>
In-Reply-To: <20170302013101.GA2047@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, March 01, 2017 05:31:01 PM Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch queued for 4.12, thanks.

It seems that there are still some fbdev drivers with this issue:

$ git grep __exit_p drivers/video/fbdev/
drivers/video/fbdev/amifb.c:    .remove = __exit_p(amifb_remove),
drivers/video/fbdev/atmel_lcdfb.c:      .remove         = __exit_p(atmel_lcdfb_remove),
drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c:        .remove = __exit_p(tvc_remove),
drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c:      .remove = __exit_p(dvic_remove),
drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c:     .remove = __exit_p(hdmic_remove),
drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c:     .remove = __exit_p(opa362_remove),
drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c:     .remove = __exit_p(tfp410_remove),
drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c:  .remove = __exit_p(tpd_remove),
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:  .remove = __exit_p(panel_dpi_remove),
drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c:       .remove = __exit_p(dsicm_remove),
drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:    .remove = __exit_p(sharp_ls_remove),
drivers/video/fbdev/omap2/omapfb/vrfb.c:        .remove         = __exit_p(vrfb_remove),

(these drivers don't disable sysfs bind/unbind attributes)

Could you please also take care of fixing them?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

