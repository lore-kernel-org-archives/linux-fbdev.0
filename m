From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.28 2/3] mach-pxa: gpio add batch set/get
Date: Sun, 25 Jan 2009 17:54:48 +0800
Message-ID: <12328772954069-git-send-email-jayakumar.lkml@gmail.com>
References: <123287728936-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756010AbZAYJzo@vger.kernel.org>
In-Reply-To: <123287728936-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.miao@marvell.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org, Jaya Kumar <jayakumar.lkml@gmail.com>

This patch adds support for pxa specific batch set/get of gpio. This
is exported to gpiolib via the gpio_chip interface. The API used
conforms with the gpiolib batch set/get API described in
Documentation/gpio.txt.

Cc: David Brownell <david-b@pacbell.net>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Cc: linux-embedded@vger.kernel.org
Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/Kconfig             |    1 +
 arch/arm/mach-pxa/gpio.c              |   63 +++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/include/mach/gpio.h |   51 ++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f844425..1b3e631 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -41,6 +41,7 @@ config GUMSTIX_AM200EPD
 	bool "Enable AM200EPD board support"
 
 config GUMSTIX_AM300EPD
+	select GPIOLIB_BATCH
 	bool "Enable AM300EPD board support"
 
 endchoice
diff --git a/arch/arm/mach-pxa/gpio.c b/arch/arm/mach-pxa/gpio.c
index 5fec1e4..0e466e2 100644
--- a/arch/arm/mach-pxa/gpio.c
+++ b/arch/arm/mach-pxa/gpio.c
@@ -162,6 +162,67 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		__raw_writel(mask, pxa->regbase + GPCR_OFFSET);
 }
 
+#ifdef CONFIG_GPIOLIB_BATCH
+/*
+ * Set output GPIO level in batches
+ */
+static int pxa_gpio_set_batch(struct gpio_chip *chip, unsigned startpin,
+				u32 mask, int width, u32 values)
+{
+	struct pxa_gpio_chip *pxa;
+
+	/* we're guaranteed by the caller that startpin + mask remains
+	 * in this chip.
+	 */
+	pxa = container_of(chip, struct pxa_gpio_chip, chip);
+
+	/* mask is used twice in shifted form */
+	mask <<= startpin;
+
+	values = (values << startpin) & mask;
+	if (values)
+		__raw_writel(values, pxa->regbase + GPSR_OFFSET);
+
+	values = ~values & mask;
+	if (values)
+		__raw_writel(values, pxa->regbase + GPCR_OFFSET);
+
+	return 0;
+}
+
+/*
+ * Get output GPIO level in batches
+ */
+static int pxa_gpio_get_batch(struct gpio_chip *chip, unsigned startpin,
+				u32 mask, int width, u32 *result)
+{
+	u32 values;
+	struct pxa_gpio_chip *pxa;
+
+	/* we're guaranteed by the caller that startpin + mask remains
+	 * in this chip.
+	 */
+	pxa = container_of(chip, struct pxa_gpio_chip, chip);
+
+	values = __raw_readl(pxa->regbase + GPLR_OFFSET);
+
+	/* shift the result back into original position */
+	*result = (values >> startpin) & mask;
+	return 0;
+}
+#endif
+
+/* this is done this way so that we can insert an ifdef-able value
+ * into the following GPIO_CHIP macro
+ */
+#ifdef CONFIG_GPIOLIB_BATCH
+#define SET_BATCH_MACRO	.set_batch 	  = pxa_gpio_set_batch,
+#define GET_BATCH_MACRO	.get_batch	  = pxa_gpio_get_batch,
+#else
+#define SET_BATCH_MACRO
+#define GET_BATCH_MACRO
+#endif
+
 #define GPIO_CHIP(_n)							\
 	[_n] = {							\
 		.regbase = GPIO##_n##_BASE,				\
@@ -173,6 +234,8 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			.set		  = pxa_gpio_set,		\
 			.base		  = (_n) * 32,			\
 			.ngpio		  = 32,				\
+			SET_BATCH_MACRO					\
+			GET_BATCH_MACRO					\
 		},							\
 	}
 
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 2c538d8..7fa84fe 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -24,6 +24,7 @@
 #ifndef __ASM_ARCH_PXA_GPIO_H
 #define __ASM_ARCH_PXA_GPIO_H
 
+#include <linux/bitops.h>
 #include <mach/pxa-regs.h>
 #include <asm/irq.h>
 #include <mach/hardware.h>
@@ -56,6 +57,56 @@ static inline void gpio_set_value(unsigned gpio, int value)
 	}
 }
 
+#ifdef CONFIG_GPIOLIB_BATCH
+static inline int gpio_set_batch(unsigned startpin, u32 mask, u32 values)
+{
+	int err = 0;
+	int width = fls(mask);
+
+	if (__builtin_constant_p(startpin) &&
+		(startpin + width < NR_BUILTIN_GPIO) &&
+		((startpin + width) <= roundup(startpin + 1, 32))) {
+		int shift;
+
+		shift = startpin % 32;
+		mask <<= shift;
+
+		values = (values << shift) & mask;
+		if (values)
+			GPSR(startpin) = values;
+
+		values = ~values & mask;
+		if (values)
+			GPCR(startpin) = values;
+	} else {
+		err = __gpio_set_batch(startpin, mask, width, values);
+	}
+	return err;
+}
+
+static inline int gpio_get_batch(unsigned startpin, u32 mask, u32 *result)
+{
+	int ret = 0;
+	int width = fls(mask);
+
+	if (__builtin_constant_p(startpin) &&
+		(startpin + width < NR_BUILTIN_GPIO) &&
+		((startpin + width) <= roundup(startpin+1, 32))) {
+		int shift;
+		u32 values;
+
+		shift = startpin % 32;
+
+		values = GPLR(startpin);
+
+		*result = (values >> shift) & mask;
+	} else {
+		ret = __gpio_get_batch(startpin, mask, width, result);
+	}
+	return ret;
+}
+#endif
+
 #define gpio_cansleep __gpio_cansleep
 
 #define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
-- 
1.5.2.3
