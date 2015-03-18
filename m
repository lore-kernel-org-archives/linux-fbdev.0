From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 18 Mar 2015 19:04:52 +0000
Subject: [PATCH RESEND v2 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <1426705493-26615-1-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch takes into account that cursor->vstart, crtc->vScreen and
share->pvMem are pointers to memory-mapped I/O and thus we should use memset_io
to make this explicit. In addition, some architectures require special treatment
of memory-mapped I/O so the previous code could actually break without this
change.

This fixes the following sparse warnings:-

drivers/staging/sm750fb/sm750.c:489:17: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/sm750fb/sm750.c:490:17: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/sm750fb/sm750.c:501:17: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/sm750fb/sm750.c:502:17: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/sm750fb/sm750.c:833:5: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/sm750fb/sm750.c:1154:9: warning: incorrect type in argument 1 (different address spaces)

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
v2: Whitespace fixups, updated commit message

 drivers/staging/sm750fb/sm750.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index aa0888c..3e36b6a 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -486,8 +486,8 @@ static int lynxfb_resume(struct pci_dev* pdev)
 		par = info->par;
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
-		memset(cursor->vstart, 0x0, cursor->size);
-		memset(crtc->vScreen,0x0,crtc->vidmem_size);
+		memset_io(cursor->vstart, 0x0, cursor->size);
+		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -498,8 +498,8 @@ static int lynxfb_resume(struct pci_dev* pdev)
 		par = info->par;
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
-		memset(cursor->vstart, 0x0, cursor->size);
-		memset(crtc->vScreen,0x0,crtc->vidmem_size);
+		memset_io(cursor->vstart, 0x0, cursor->size);
+		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -830,7 +830,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)


     crtc->cursor.share = share;
-    memset(crtc->cursor.vstart, 0, crtc->cursor.size);
+	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
     if(!g_hwcursor){
         lynxfb_ops.fb_cursor = NULL;
         crtc->cursor.disable(&crtc->cursor);
@@ -1151,7 +1151,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	}
 #endif

-	memset(share->pvMem,0,share->vidmem_size);
+	memset_io(share->pvMem, 0, share->vidmem_size);

 	pr_info("sm%3x mmio address = %p\n",share->devid,share->pvReg);

--
2.3.2
