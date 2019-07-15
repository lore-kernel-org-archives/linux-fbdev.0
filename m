From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Mon, 15 Jul 2019 14:30:02 +0000
Subject: [PATCH] Staging: fbtft: Fix wrong check in fbtft_write_wmem16_bus8()
Message-Id: <20190715143003.12819-1-nsaenzjulienne@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: preid@electromag.com.au, nishadkamdar@gmail.com, bhanusreemahesh@gmail.com, leobras.c@gmail.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

We actually want to set the gpio pin if it's avilable, not the other way
around.

Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interface")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/fbtft/fbtft-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 2ea814d0dca5..63c65dd67b17 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -135,7 +135,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
-	if (!par->gpio.dc)
+	if (par->gpio.dc)
 		gpiod_set_value(par->gpio.dc, 1);
 
 	/* non buffered write */
-- 
2.22.0
