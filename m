From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 27 Apr 2020 09:19:45 +0000
Subject: [PATCH] video: fbdev: w100fb: Fix a potential double free.
Message-Id: <20200427091945.57534-1-christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de, arnd@arndb.de, jani.nikula@intel.com, akpm@osdl.org, adaplas@pol.net, rpurdie@rpsys.net
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Some memory is vmalloc'ed in the 'suspend' function and freed in the
'resume' function.
However, it is also freed in the remove function.

In order to avoid a potential double free, set the corresponding pointer
to NULL once freed in the 'resume' function.

Fixes: aac51f09d96a ("[PATCH] w100fb: Rewrite for platform independence")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/w100fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 2d6e2738b792..d96ab28f8ce4 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -588,6 +588,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
 		memsize=par->mach->mem->size;
 		memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);
 		vfree(par->saved_extmem);
+		par->saved_extmem = NULL;
 	}
 	if (par->saved_intmem) {
 		memsize=MEM_INT_SIZE;
@@ -596,6 +597,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
 		else
 			memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_intmem, memsize);
 		vfree(par->saved_intmem);
+		par->saved_intmem = NULL;
 	}
 }
 
-- 
2.25.1
