From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Fri, 16 Feb 2018 17:40:34 +0000
Subject: [RESEND PATCH v5 5/5] ARM: dts: rockchip: set PWM delay backlight settings for Minnie
Message-Id: <20180216174034.15936-5-enric.balletbo@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
In-Reply-To: <20180216174034.15936-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, kernel@collabora.com

The minnie devices comes with an AUO B101EAN01 panel which is different
from default veyron devices, thus the power on/off timing sequence is
slightly different. The datasheet specifies a pwm delay of 200 ms, so
update the PMW delay proprieties accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
Changes since v4:
 - Rebase on top of mainline.
Changes since v3:
 - Use new -ms names for proprieties.
 - Fix the delay, should be 200ms instead of 20ms (Pavel)
Changes since v2:
 - Use new names for proprieties.
Changes since v1:
 - Add this new patch as minnie has differents timings

 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 544de6027aaa..4c5307e62001 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -123,6 +123,8 @@
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 	power-supply = <&backlight_regulator>;
+	post-pwm-on-delay-ms = <200>;
+	pwm-off-delay-ms = <200>;
 };
 
 &emmc {
-- 
2.15.1

