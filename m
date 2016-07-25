From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 25 Jul 2016 15:24:38 +0000
Subject: [PATCH 1/3] mdacon: align code in mda_detect properly
Message-Id: <20160725152440.6734-1-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

This is just a whitespace cleanup. The code was a mess having multiple
commands on one line like:
scr_writew(0xAA55, p); if (scr_readw(p) = 0xAA55) count++;

Indent that properly and make it nicer for reading.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/video/console/mdacon.c | 60 ++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index bacbb044d77c..64c2c5e8d00b 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -208,10 +208,17 @@ static int mda_detect(void)
 	p = (u16 *) mda_vram_base;
 	q = (u16 *) (mda_vram_base + 0x01000);
 
-	p_save = scr_readw(p); q_save = scr_readw(q);
+	p_save = scr_readw(p);
+	q_save = scr_readw(q);
+
+	scr_writew(0xAA55, p);
+	if (scr_readw(p) = 0xAA55)
+		count++;
+
+	scr_writew(0x55AA, p);
+	if (scr_readw(p) = 0x55AA)
+		count++;
 
-	scr_writew(0xAA55, p); if (scr_readw(p) = 0xAA55) count++;
-	scr_writew(0x55AA, p); if (scr_readw(p) = 0x55AA) count++;
 	scr_writew(p_save, p);
 
 	if (count != 2) {
@@ -220,13 +227,18 @@ static int mda_detect(void)
 
 	/* check if we have 4K or 8K */
 
-	scr_writew(0xA55A, q); scr_writew(0x0000, p);
-	if (scr_readw(q) = 0xA55A) count++;
+	scr_writew(0xA55A, q);
+	scr_writew(0x0000, p);
+	if (scr_readw(q) = 0xA55A)
+		count++;
 	
-	scr_writew(0x5AA5, q); scr_writew(0x0000, p);
-	if (scr_readw(q) = 0x5AA5) count++;
+	scr_writew(0x5AA5, q);
+	scr_writew(0x0000, p);
+	if (scr_readw(q) = 0x5AA5)
+		count++;
 
-	scr_writew(p_save, p); scr_writew(q_save, q);
+	scr_writew(p_save, p);
+	scr_writew(q_save, q);
 	
 	if (count = 4) {
 		mda_vram_len = 0x02000;
@@ -240,14 +252,12 @@ static int mda_detect(void)
 	/* Edward: These two mess `tests' mess up my cursor on bootup */
 
 	/* cursor low register */
-	if (! test_mda_b(0x66, 0x0f)) {
+	if (!test_mda_b(0x66, 0x0f))
 		return 0;
-	}
 
 	/* cursor low register */
-	if (! test_mda_b(0x99, 0x0f)) {
+	if (!test_mda_b(0x99, 0x0f))
 		return 0;
-	}
 #endif
 
 	/* See if the card is a Hercules, by checking whether the vsync
@@ -257,25 +267,25 @@ static int mda_detect(void)
 	
 	p_save = q_save = inb_p(mda_status_port) & MDA_STATUS_VSYNC;
 
-	for (count=0; count < 50000 && p_save = q_save; count++) {
+	for (count = 0; count < 50000 && p_save = q_save; count++) {
 		q_save = inb(mda_status_port) & MDA_STATUS_VSYNC;
 		udelay(2);
 	}
 
 	if (p_save != q_save) {
 		switch (inb_p(mda_status_port) & 0x70) {
-			case 0x10:
-				mda_type = TYPE_HERCPLUS;
-				mda_type_name = "HerculesPlus";
-				break;
-			case 0x50:
-				mda_type = TYPE_HERCCOLOR;
-				mda_type_name = "HerculesColor";
-				break;
-			default:
-				mda_type = TYPE_HERC;
-				mda_type_name = "Hercules";
-				break;
+		case 0x10:
+			mda_type = TYPE_HERCPLUS;
+			mda_type_name = "HerculesPlus";
+			break;
+		case 0x50:
+			mda_type = TYPE_HERCCOLOR;
+			mda_type_name = "HerculesColor";
+			break;
+		default:
+			mda_type = TYPE_HERC;
+			mda_type_name = "Hercules";
+			break;
 		}
 	}
 
-- 
2.9.2

