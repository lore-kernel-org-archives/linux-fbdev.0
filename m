From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:38:29 +0000
Subject: [PATCH 04/26] Staging: fbtft: flexfb: Switch to the gpio descriptor interface
Message-Id: <0bc27a5c4f06e50f9cc2d568c6ce5f983dc84925.1543142440.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the flexfb.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/flexfb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index 2af474469e7d..c5fa59105a43 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -521,7 +521,7 @@ static int flexfb_verify_gpios_dc(struct fbtft_par *par)
 {
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
-	if (par->gpio.dc < 0) {
+	if (!par->gpio.dc) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -537,22 +537,22 @@ static int flexfb_verify_gpios_db(struct fbtft_par *par)
 
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
-	if (par->gpio.dc < 0) {
+	if (!par->gpio.dc) {
 		dev_err(par->info->device, "Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (par->gpio.wr < 0) {
+	if (!par->gpio.wr) {
 		dev_err(par->info->device, "Missing info about 'wr' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (latched && (par->gpio.latch < 0)) {
+	if (latched && !par->gpio.latch) {
 		dev_err(par->info->device, "Missing info about 'latch' gpio. Aborting.\n");
 		return -EINVAL;
 	}
 	if (latched)
 		num_db = buswidth / 2;
 	for (i = 0; i < num_db; i++) {
-		if (par->gpio.db[i] < 0) {
+		if (!par->gpio.db[i]) {
 			dev_err(par->info->device,
 				"Missing info about 'db%02d' gpio. Aborting.\n",
 				i);
-- 
2.17.1
