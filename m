From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Wed, 28 May 2014 23:20:10 +0000
Subject: [PATCHv2 07/15] PWM: atmel: allow building for AVR32
Message-Id: <1401319218-16772-8-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Atmel PWM IP can be found on avr32 chips. This allows selecting and building
the driver on avr32.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4ad7b89a4cb4..331dfca415c7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -43,7 +43,7 @@ config PWM_AB8500
 
 config PWM_ATMEL
 	tristate "Atmel PWM support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || AVR32
 	help
 	  Generic PWM framework driver for Atmel SoC.
 
-- 
1.9.1

