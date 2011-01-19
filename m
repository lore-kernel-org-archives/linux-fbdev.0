From: Amerigo Wang <amwang@redhat.com>
Date: Wed, 19 Jan 2011 06:24:02 +0000
Subject: [Patch V2] video: fix some comments in drivers/video/console/vgacon.c
Message-Id: <1295418242-19859-1-git-send-email-amwang@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lethal@linux-sh.org, WANG Cong <amwang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Yannick Heneault <yheneaul@matrox.com>, Matthew Garrett <mjg@redhat.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

Now vgacon_scrollback_startup() uses slab, not bootmem,
the comment above it is obsolete, so does __init_refok.

Signed-off-by: WANG Cong <amwang@redhat.com>

---

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index c97491b..915fd74 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -202,11 +202,7 @@ static void vgacon_scrollback_init(int pitch)
 	}
 }
 
-/*
- * Called only duing init so call of alloc_bootmen is ok.
- * Marked __init_refok to silence modpost.
- */
-static void __init_refok vgacon_scrollback_startup(void)
+static void vgacon_scrollback_startup(void)
 {
 	vgacon_scrollback = kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, GFP_NOWAIT);
 	vgacon_scrollback_init(vga_video_num_columns * 2);
