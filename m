From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:58 +0000
Subject: [PATCH 13/13] drivers/video: fsl-diu-fb: remove unusued MEM_ALLOC_THRESHOLD
Message-Id: <1316123098-30967-14-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If there was ever any code that used MEM_ALLOC_THRESHOLD, it was removed a
long time ago.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 include/linux/fsl-diu-fb.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index 35ac0c5..df23f59 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -20,11 +20,6 @@
 #ifndef __FSL_DIU_FB_H__
 #define __FSL_DIU_FB_H__
 
-/* Arbitrary threshold to determine the allocation method
- * See mpc8610fb_set_par(), map_video_memory(), and unmap_video_memory()
- */
-#define MEM_ALLOC_THRESHOLD (1024*768*4+32)
-
 #include <linux/types.h>
 
 struct mfb_chroma_key {
-- 
1.7.3.4


