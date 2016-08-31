From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 31 Aug 2016 08:18:12 +0000
Subject: [PATCH 1/6] backlight: pwm_bl: Handle gpio that can sleep
Message-Id: <20160831081817.5191-2-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
In-Reply-To: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, Alexander Kaplan <alex@nextthing.co>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Some backlight GPIOs might be connected to some i2c based expanders whose
access might sleep.

Since it's not in any critical path, use the cansleep variant of the GPIO
API.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/backlight/pwm_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b2b366bb0f97..12614006211e 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -55,7 +55,7 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
 	if (pb->enable_gpio)
-		gpiod_set_value(pb->enable_gpio, 1);
+		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
 	pwm_enable(pb->pwm);
 	pb->enabled = true;
@@ -70,7 +70,7 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	pwm_disable(pb->pwm);
 
 	if (pb->enable_gpio)
-		gpiod_set_value(pb->enable_gpio, 0);
+		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
-- 
2.9.2

