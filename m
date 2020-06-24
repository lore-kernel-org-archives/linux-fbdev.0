From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 24 Jun 2020 14:57:17 +0000
Subject: [PATCH 4/8] backlight: ili922x: Remove invalid use of kerneldoc syntax
Message-Id: <20200624145721.2590327-5-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Software Engineering <sbabic@denx.de>

Kerneldoc is for documenting function arguments and return values.

Prevents warnings like:

 drivers/video/backlight/ili922x.c:127: warning: cannot understand function prototype: 'int ili922x_id = 1; '
 drivers/video/backlight/ili922x.c:136: warning: cannot understand function prototype: 'struct ili922x '

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Software Engineering <sbabic@denx.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/ili922x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index 8cb4b9d3c3bba..cd41433b87aeb 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -123,7 +123,7 @@
 
 #define set_tx_byte(b)		(tx_invert ? ~(b) : b)
 
-/**
+/*
  * ili922x_id - id as set by manufacturer
  */
 static int ili922x_id = 1;
@@ -132,7 +132,7 @@ module_param(ili922x_id, int, 0);
 static int tx_invert;
 module_param(tx_invert, int, 0);
 
-/**
+/*
  * driver's private structure
  */
 struct ili922x {
-- 
2.25.1
