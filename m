From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: matroxfb: fix regression with uninitalized fb_info->mm_lock mutex
Date: Tue, 7 Jul 2009 22:06:48 +0200
Message-ID: <20090707220648.4b2ee3d8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758140AbZGGT5S@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, rjw@sisk.pl, stable@kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant call to the matroxfb_update_fix() before matrox frambuffer
is registered.

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduced 
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This one I have been able to test. It fixed regression with the mm_lock mutex.

It may not fix regression for a second head. I will investigate this issue.

diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 76bc51b..721a87d 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -1876,7 +1876,6 @@ static int initMatrox2(WPMINFO struct board* b){
 	}
 	matroxfb_init_fix(PMINFO2);
 	ACCESS_FBINFO(fbcon.screen_base) = vaddr_va(ACCESS_FBINFO(video.vbase));
-	matroxfb_update_fix(PMINFO2);
 	/* Normalize values (namely yres_virtual) */
 	matroxfb_check_var(&vesafb_defined, &ACCESS_FBINFO(fbcon));
 	/* And put it into "current" var. Do NOT program hardware yet, or we'll not take over

----------------------------------------------------------------------
Promocja ubezpieczen komunikacyjnych Ergo Hestia. Sprawdz!
http://link.interia.pl/f222f
