From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Apr 2020 12:46:25 +0000
Subject: [PATCHv2 0/4] led-backlight cleanups & fixes
Message-Id: <20200421124629.20977-1-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Changes in v2:

- Drop "backlight: led_bl: rewrite led_bl_parse_levels()". The patch
  changed the behavior, and the new behavior may not be wanted. So lets
  drop this for now.

- "backlight: led_bl: fix led -> backlight brightness mapping" will now
  use max brightness if LED's brightness is higher than highest
  backlight brightness level.

- Added reviewed-bys.

 Tomi

Tomi Valkeinen (4):
  backlight: led_bl: fix cosmetic issues
  backlight: led_bl: drop useless NULL initialization
  backlight: led_bl: add led_access locking
  backlight: led_bl: fix led -> backlight brightness mapping

 drivers/video/backlight/led_bl.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
