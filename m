From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Fri, 20 May 2016 13:34:51 +0000
Subject: [PATCH 0/3] drm/imx: convey the pixelclk-active and de-active flags to the ipu-di driver
Message-Id: <1463751294-24769-1-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Philipp Zabel <p.zabel@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>

The 'de-active' and 'pixelclk-active' DT properties are evaluated
by of_parse_display_timing() called from  of_get_drm_display_mode(),
but later lost in the conversion from videomode.flags to
drm_display_mode.flags.
Use an open coded version of of_get_drm_display_mode() to get access
to these flags and make sure they are passed on to the ipu-di driver.
This patch also makes sure, that the 'bus_flags' specified in the
simple-panel driver will be passed on from the ipu-di driver.

The first patch in this series makes sure, the imx-ldb driver honors
the 'native-mode' property in DT (like the parallel-display driver
does already).

The third patch removes some dead code in the parallel-display driver,
hat depends on a variable which is never assigned a non-zero value and
thus can never be reached.
