From: Amerigo Wang <amwang@redhat.com>
Date: Wed, 19 Jan 2011 06:00:02 +0000
Subject: [Patch] video: remove pointless comments in drivers/video/console/vgacon.c
Message-Id: <1295416803-17651-1-git-send-email-amwang@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: WANG Cong <amwang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Yannick Heneault <yheneaul@matrox.com>, Matthew Garrett <mjg@redhat.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

Now vgacon_scrollback_startup() uses slab, not bootmem,
so that comment is obsolete, the rest are useless.

Signed-off-by: WANG Cong <amwang@redhat.com>

---
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index c97491b..b030aca 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -202,10 +202,6 @@ static void vgacon_scrollback_init(int pitch)
 	}
 }
 
-/*
- * Called only duing init so call of alloc_bootmen is ok.
- * Marked __init_refok to silence modpost.
- */
 static void __init_refok vgacon_scrollback_startup(void)
 {
 	vgacon_scrollback = kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, GFP_NOWAIT);
