From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 06 May 2020 18:19:02 +0000
Subject: [PATCH V2] video: fbdev: w100fb: Fix a potential double free.
Message-Id: <20200506181902.193290-1-christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rpurdie@rpsys.net, adaplas@pol.net, b.zolnierkie@samsung.com, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, dri-devel@lists.freedesktop.org

Some memory is vmalloc'ed in the 'w100fb_save_vidmem' function and freed in
the 'w100fb_restore_vidmem' function. (these functions are called
respectively from the 'suspend' and the 'resume' functions)

However, it is also freed in the 'remove' function.

In order to avoid a potential double free, set the corresponding pointer
to NULL once freed in the 'w100fb_restore_vidmem' function.

Fixes: aac51f09d96a ("[PATCH] w100fb: Rewrite for platform independence")
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: <stable@vger.kernel.org> # v2.6.14+
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: - Add Cc: tags
    - Reword the commit message to give the names of the functions that
      allocate and free the memory. These functions are called from the
      suspend and resume function.
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
