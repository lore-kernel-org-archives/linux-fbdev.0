From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 25 Jul 2016 15:24:39 +0000
Subject: [PATCH 2/3] mdacon: make mda_vram_base u16 *
Message-Id: <20160725152440.6734-2-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160725152440.6734-1-jslaby@suse.cz>
In-Reply-To: <20160725152440.6734-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

Given every user of mda_vram_base expects a pointer, let
mda_vram_base be a pointer to u16.

The offset calculation in mda_detect had to be adjusted by / 2 (due to
different pointer arithmetic now).

We introduce a cast to a value returned from VGA_MAP_MEM. But I will
change VGA_MAP_MEM to return a pointer later too. But vgacon needs a
similar change first.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/video/console/mdacon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 64c2c5e8d00b..814606bd26d1 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -48,7 +48,7 @@ static DEFINE_SPINLOCK(mda_lock);
 
 /* description of the hardware layout */
 
-static unsigned long	mda_vram_base;		/* Base of video memory */
+static u16		*mda_vram_base;		/* Base of video memory */
 static unsigned long	mda_vram_len;		/* Size of video memory */
 static unsigned int	mda_num_columns;	/* Number of text columns */
 static unsigned int	mda_num_lines;		/* Number of text lines */
@@ -205,8 +205,8 @@ static int mda_detect(void)
 
 	/* do a memory check */
 
-	p = (u16 *) mda_vram_base;
-	q = (u16 *) (mda_vram_base + 0x01000);
+	p = mda_vram_base;
+	q = mda_vram_base + 0x01000 / 2;
 
 	p_save = scr_readw(p);
 	q_save = scr_readw(q);
@@ -323,7 +323,7 @@ static const char *mdacon_startup(void)
 	mda_num_lines   = 25;
 
 	mda_vram_len  = 0x01000;
-	mda_vram_base = VGA_MAP_MEM(0xb0000, mda_vram_len);
+	mda_vram_base = (u16 *)VGA_MAP_MEM(0xb0000, mda_vram_len);
 
 	mda_index_port  = 0x3b4;
 	mda_value_port  = 0x3b5;
@@ -420,7 +420,7 @@ static void mdacon_invert_region(struct vc_data *c, u16 *p, int count)
 	}
 }
 
-#define MDA_ADDR(x,y)  ((u16 *) mda_vram_base + (y)*mda_num_columns + (x))
+#define MDA_ADDR(x, y)  (mda_vram_base + (y)*mda_num_columns + (x))
 
 static void mdacon_putc(struct vc_data *c, int ch, int y, int x)
 {
@@ -463,7 +463,7 @@ static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
 {
 	if (mda_type = TYPE_MDA) {
 		if (blank) 
-			scr_memsetw((void *)mda_vram_base, 
+			scr_memsetw(mda_vram_base,
 				mda_convert_attr(c->vc_video_erase_char),
 				c->vc_screenbuf_size);
 		/* Tell console.c that it has to restore the screen itself */
-- 
2.9.2

