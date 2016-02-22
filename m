From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:55:34 +0000
Subject: [PATCH 7/7] video: fbdev: bt431: Correct cursor format control macro
Message-Id: <alpine.LFD.2.20.1602220141110.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The Bt431 cursor generator supports simultaneous generation of a 64 x 64
and a cross hair cursor in which the cursor format control bit (bit D4)
of the command register "specifies whether the contents of the cursor
RAM are to be logically exclusive-ORed (logical zero) or ORed (logical
one) with the cross hair cursor".  Rename the relevant macro accordingly.

References:

[1] "Bt431 Monolithic CMOS 64 x 64 Pixel Cursor Generator", Brooktree
    Corporation, Document Number: L431001, Rev. J

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-bt431-cmd-xor.diff
Index: linux-20160211-4maxp64/drivers/video/fbdev/bt431.h
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/bt431.h
+++ linux-20160211-4maxp64/drivers/video/fbdev/bt431.h
@@ -63,7 +63,7 @@ static inline u8 bt431_get_value(u16 val
 #define BT431_CMD_CURS_ENABLE	0x40
 #define BT431_CMD_XHAIR_ENABLE	0x20
 #define BT431_CMD_OR_CURSORS	0x10
-#define BT431_CMD_AND_CURSORS	0x00
+#define BT431_CMD_XOR_CURSORS	0x00
 #define BT431_CMD_1_1_MUX	0x00
 #define BT431_CMD_4_1_MUX	0x04
 #define BT431_CMD_5_1_MUX	0x08
