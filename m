From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 23 Apr 2010 21:28:09 +0000
Subject: [PATCH 09/13] via: Rationalize vt1636 detection
Message-Id: <1272058093-20914-10-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272058093-20914-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272058093-20914-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

The code was ugly and didn't check whether i2c operations were succeeding;
make it a little better.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/vt1636.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/video/via/vt1636.c b/drivers/video/via/vt1636.c
index e9f3661..e5f8024 100644
--- a/drivers/video/via/vt1636.c
+++ b/drivers/video/via/vt1636.c
@@ -167,26 +167,20 @@ bool viafb_lvds_identify_vt1636(u8 i2c_adapter)
 
 	/* Sense VT1636 LVDS Transmiter */
 	viaparinfo->chip_info->lvds_chip_info.lvds_chip_slave_addr -	VT1636_LVDS_I2C_ADDR;
+		VT1636_LVDS_I2C_ADDR;
 
 	/* Check vendor ID first: */
-	viafb_i2c_readbyte(i2c_adapter,
-			   (u8) viaparinfo->chip_info->lvds_chip_info.lvds_chip_slave_addr,
-			   0x00, &Buffer[0]);
-	viafb_i2c_readbyte(i2c_adapter,
-			   (u8) viaparinfo->chip_info->lvds_chip_info.lvds_chip_slave_addr,
-			   0x01, &Buffer[1]);
+	if (viafb_i2c_readbyte(i2c_adapter, VT1636_LVDS_I2C_ADDR,
+					0x00, &Buffer[0]))
+		return false;
+	viafb_i2c_readbyte(i2c_adapter, VT1636_LVDS_I2C_ADDR, 0x01, &Buffer[1]);
 
 	if (!((Buffer[0] = 0x06) && (Buffer[1] = 0x11)))
 		return false;
 
 	/* Check Chip ID: */
-	viafb_i2c_readbyte(i2c_adapter,
-			   (u8) viaparinfo->chip_info->lvds_chip_info.lvds_chip_slave_addr,
-			   0x02, &Buffer[0]);
-	viafb_i2c_readbyte(i2c_adapter,
-			   (u8) viaparinfo->chip_info->lvds_chip_info.lvds_chip_slave_addr,
-			   0x03, &Buffer[1]);
+	viafb_i2c_readbyte(i2c_adapter, VT1636_LVDS_I2C_ADDR, 0x02, &Buffer[0]);
+	viafb_i2c_readbyte(i2c_adapter, VT1636_LVDS_I2C_ADDR, 0x03, &Buffer[1]);
 	if ((Buffer[0] = 0x45) && (Buffer[1] = 0x33)) {
 		viaparinfo->chip_info->lvds_chip_info.lvds_chip_name  			VT1636_LVDS;
-- 
1.7.0.1

