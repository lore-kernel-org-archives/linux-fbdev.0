From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Jun 2018 16:06:06 +0000
Subject: Re: [PATCH] fb_omap: add gpiolib dependency
Message-Id: <2141120.Yc9aKbDC23@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180530214948epcas1p43ed1ac72bc8959b7bf0f21220c48e96d@epcas1p4.samsung.com>
 <20180530214938.1073749-1-arnd@arndb.de>
In-Reply-To: <20180530214938.1073749-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 11:49:22 PM Arnd Bergmann wrote:
> Building the omap sub-drivers when CONFIG_GPIOLIB is disabled causes
> lots of build failures, either from using gpiolib interfaces, or from
> including the wrong headers:
> 
> drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c: In function 'opa362_enable':
> drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c:101:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_enable':
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:86:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_pdata':
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:189:23: error: implicit declaration of function 'gpio_to_desc'; did you mean 'irq_to_desc'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_of':
> drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:210:9: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c: In function 'sharp_ls_enable':
> drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:120:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c: In function 'lb035q02_enable':
> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:170:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c:584:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:554:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
> 
> Rather than fixing up each one individually, this just marks all of it
> as depending on GPIOLIB.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.18 (w/ fb_omap->fb_omap2 fixed in the patch title), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

