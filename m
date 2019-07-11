From: Phil Reid <preid@electromag.com.au>
Date: Thu, 11 Jul 2019 08:31:53 +0000
Subject: [PATCH 2/2] Staging: fbtft: Fix reset assertion when using gpio descriptor
Message-Id: <1562833913-10510-3-git-send-email-preid@electromag.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1562833913-10510-1-git-send-email-preid@electromag.com.au>
In-Reply-To: <1562833913-10510-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, bhanusreemahesh@gmail.com, leobras.c@gmail.com, nishadkamdar@gmail.com, preid@electromag.com.au, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, nsaenzjulienne@suse.de

Typically gpiod_set_value calls would assert the reset line and
then release it using the symantics of:
	gpiod_set_value(par->gpio.reset, 0);
	... delay
	gpiod_set_value(par->gpio.reset, 1);
And the gpio binding would specify the polarity.

Prior to conversion to gpiod calls the polarity in the DT
was ignored and assumed to be active low. Fix it so that
DT polarity is respected.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 44b8074..bc75025 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -231,9 +231,9 @@ static void fbtft_reset(struct fbtft_par *par)
 	if (!par->gpio.reset)
 		return;
 	fbtft_par_dbg(DEBUG_RESET, par, "%s()\n", __func__);
-	gpiod_set_value_cansleep(par->gpio.reset, 0);
-	usleep_range(20, 40);
 	gpiod_set_value_cansleep(par->gpio.reset, 1);
+	usleep_range(20, 40);
+	gpiod_set_value_cansleep(par->gpio.reset, 0);
 	msleep(120);
 }
 
-- 
1.8.3.1
