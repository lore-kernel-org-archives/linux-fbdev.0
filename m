From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: w100fb: fix regression with uninitalized fb_info->mm_lock mutex
Date: Tue, 7 Jul 2009 19:24:54 +0200
Message-ID: <20090707192454.df7462a4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756803AbZGGRPY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, rjw@sisk.pl, stable@kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant call to the w100fb_set_par() before w100 frambuffer is registered.

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduced 
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 8a141c2..2376f68 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -748,8 +748,6 @@ int __init w100fb_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	w100fb_set_par(info);
-
 	if (register_framebuffer(info) < 0) {
 		err = -EINVAL;
 		goto out;

----------------------------------------------------------------------
Promocja ubezpieczen komunikacyjnych Ergo Hestia. Sprawdz!
http://link.interia.pl/f222f
