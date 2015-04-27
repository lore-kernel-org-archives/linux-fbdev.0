From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Mon, 27 Apr 2015 23:55:52 +0000
Subject: [PATCH v2 15/17] ARM: pxa: poodle: don't preallocate IRQ space for locomo
Message-Id: <1430178954-11138-16-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org

As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
space for it on poodle.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/include/mach/poodle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index dd4afae..1fdde6b 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -93,7 +93,7 @@
 #define POODLE_GPIO_232VCC_ON	(POODLE_LOCOMO_GPIO_BASE + 12)
 #define POODLE_GPIO_JK_B	(POODLE_LOCOMO_GPIO_BASE + 13)
 
-#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+#define POODLE_NR_IRQS		IRQ_BOARD_START
 
 extern struct platform_device poodle_locomo_device;
 
-- 
2.1.4

