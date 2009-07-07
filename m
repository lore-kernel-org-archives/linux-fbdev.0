From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: matroxfb: fix regression with uninitalized fb_info->mm_lock mutex
 (second head)
Date: Tue, 7 Jul 2009 22:34:13 +0200
Message-ID: <20090707223413.d56c6a7f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758641AbZGGUYl@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, rjw@sisk.pl, stable@kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant locking by the mm_lock mutex before a second head of matrox 
framebuffer is registered.

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduced 
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
index 909e10a..6caa369 100644
--- a/drivers/video/matrox/matroxfb_crtc2.c
+++ b/drivers/video/matrox/matroxfb_crtc2.c
@@ -289,16 +289,18 @@ static int matroxfb_dh_release(struct fb_info* info, int user) {
 #undef m2info
 }
 
+/*
+ * This function is called before the register_framebuffer so
+ * no locking is needed.
+ */
 static void matroxfb_dh_init_fix(struct matroxfb_dh_fb_info *m2info)
 {
 	struct fb_fix_screeninfo *fix = &m2info->fbcon.fix;
 
 	strcpy(fix->id, "MATROX DH");
 
-	mutex_lock(&m2info->fbcon.mm_lock);
 	fix->smem_start = m2info->video.base;
 	fix->smem_len = m2info->video.len_usable;
-	mutex_unlock(&m2info->fbcon.mm_lock);
 	fix->ypanstep = 1;
 	fix->ywrapstep = 0;
 	fix->xpanstep = 8;	/* TBD */

----------------------------------------------------------------------
Sprawdz promocje ubezpieczen komunikacyjnych w Ergo  Hestia
http://link.interia.pl/f222c
