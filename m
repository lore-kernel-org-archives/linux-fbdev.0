From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Jan 2013 06:42:05 +0000
Subject: [patch 1/2] video/kyro: delete some dead code
Message-Id: <20130125064205.GC4882@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

_OLDCODE is never defined.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/kyro/STG4000OverlayDevice.c b/drivers/video/kyro/STG4000OverlayDevice.c
index 0aeeaa1..84b6ea8 100644
--- a/drivers/video/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/kyro/STG4000OverlayDevice.c
@@ -430,10 +430,7 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 	 */
 	ulSrc = srcDest.ulSrcX2 - srcDest.ulSrcX1;
 	ulDest = srcDest.lDstX2 - srcDest.lDstX1;
-#ifdef _OLDCODE
-	ulLeft = srcDest.ulDstX1;
-	ulRight = srcDest.ulDstX2;
-#else
+
 	if (srcDest.ulDstX1 > 2) {
 		ulLeft = srcDest.ulDstX1 + 2;
 		ulRight = srcDest.ulDstX2 + 1;
@@ -441,7 +438,7 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		ulLeft = srcDest.ulDstX1;
 		ulRight = srcDest.ulDstX2 + 1;
 	}
-#endif
+
 	/* first work out the position we are to display as offset from the source of the buffer */
 	bResult = 1;
 
