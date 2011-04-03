From: Tormod Volden <lists.tormod@gmail.com>
Date: Sun, 03 Apr 2011 12:54:04 +0000
Subject: [PATCH 1/2] savagefb: Replace magic register address with define
Message-Id: <1301835246-6520-1-git-send-email-lists.tormod@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Tormod Volden <debian.tormod@gmail.com>

MM_SERIAL1 was already defined, but not used.

Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
---

Hi,

There was this unused define, and the one single use of the constant, so
I think somebody just forgot to use it.

Regards,
Tormod

 drivers/video/savage/savagefb-i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index b16e613..58c8a3c 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -191,7 +191,7 @@ void savagefb_create_i2c_busses(struct fb_info *info)
 		par->chan.algo.getscl = prosavage_gpio_getscl;
 		break;
 	case FB_ACCEL_SAVAGE2000:
-		par->chan.reg         = 0xff20;
+		par->chan.reg         = MM_SERIAL1;
 		par->chan.ioaddr      = par->mmio.vbase;
 		par->chan.algo.setsda = savage4_gpio_setsda;
 		par->chan.algo.setscl = savage4_gpio_setscl;
-- 
1.7.0.4

