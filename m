From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 24 Jun 2020 14:57:16 +0000
Subject: [PATCH 3/8] backlight: ili922x: Add missing kerneldoc descriptions for CHECK_FREQ_REG() args
Message-Id: <20200624145721.2590327-4-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Software Engineering <sbabic@denx.de>

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 's' not described in 'CHECK_FREQ_REG'
 drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 'x' not described in 'CHECK_FREQ_REG'

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Software Engineering <sbabic@denx.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/ili922x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index 9c5aa3fbb2842..8cb4b9d3c3bba 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -107,6 +107,8 @@
  *	lower frequency when the registers are read/written.
  *	The macro sets the frequency in the spi_transfer structure if
  *	the frequency exceeds the maximum value.
+ * @s: pointer to controller side proxy for an SPI slave device
+ * @x: pointer to the read/write buffer pair
  */
 #define CHECK_FREQ_REG(s, x)	\
 	do {			\
-- 
2.25.1
