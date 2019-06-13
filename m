From: Matthias Kaehlcke <mka@chromium.org>
Date: Thu, 13 Jun 2019 19:43:23 +0000
Subject: [PATCH 1/4] MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
Message-Id: <20190613194326.180889-2-mka@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190613194326.180889-1-mka@chromium.org>
In-Reply-To: <20190613194326.180889-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

Add an entry for the stable backlight sysfs ABI to the MAINTAINERS
file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..d51e74340870 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2857,6 +2857,7 @@ F:	drivers/video/backlight/
 F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
 F:	Documentation/devicetree/bindings/leds/backlight
+F:	Documentation/ABI/stable/sysfs-class-backlight
 
 BATMAN ADVANCED
 M:	Marek Lindner <mareklindner@neomailbox.ch>
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
