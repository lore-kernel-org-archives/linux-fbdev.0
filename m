From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: i810fb: fix regression with uninitalized fb_info->mm_lock mutex
Date: Tue, 7 Jul 2009 19:07:57 +0200
Message-ID: <20090707190757.5c9bed6e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756400AbZGGQ61@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, daniel@caiaq.de, a.p.zijlstra@chello.nl, rjw@sisk.pl, stable@kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant call to the encode_fix() before i810 frambuffer is registered.

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduced 
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 7196067..5743ea2 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -2060,8 +2060,7 @@ static int __devinit i810fb_init_pci (struct pci_dev *dev,
 
 	fb_var_to_videomode(&mode, &info->var);
 	fb_add_videomode(&mode, &info->modelist);
-	encode_fix(&info->fix, info); 
-	 	    
+
 	i810fb_init_ringbuffer(info);
 	err = register_framebuffer(info);
 


----------------------------------------------------------------------
Najlepsze OC i AC tylko w Ergo Hestia
http://link.interia.pl/f222
