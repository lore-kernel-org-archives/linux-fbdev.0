From: Daniel Drake <dsd@laptop.org>
Date: Sat, 25 Sep 2010 19:52:42 +0000
Subject: [PATCH] viafb: don't setup TMDS if it doesn't exist
Message-Id: <20100925195242.871699D401B@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The OLPC XO-1.5 does not have this particular output interface.
However, init_tmds_chip_info() always assumes it to be present,
ignoring failure codes from viafb_tmds_trasmitter_identify().

This fixes lack of output on the XO-1.5 laptop display.
Thanks to Jon Nettleton for helping identify the problematic code.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/via/hw.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 7dcb4d5..a24d03f 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2125,7 +2125,8 @@ static void init_gfx_chip_info(int chip_type)
 
 static void init_tmds_chip_info(void)
 {
-	viafb_tmds_trasmitter_identify();
+	if (viafb_tmds_trasmitter_identify() != OK)
+		return;
 
 	if (INTERFACE_NONE = viaparinfo->chip_info->tmds_chip_info.
 		output_interface) {
-- 
1.7.2.2

