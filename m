From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Jan 2013 06:42:59 +0000
Subject: [patch 2/2] video/kyro: some potential divide by zero bugs
Message-Id: <20130125064259.GD4882@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

These values come from the user in kyrofb_ioctl().  There are a couple
potential divide by zero problems and I have added tests for them.
There were a couple tests to prevent divide by zero bugs already in the
code that I moved next to the assignments.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/kyro/STG4000OverlayDevice.c b/drivers/video/kyro/STG4000OverlayDevice.c
index 84b6ea8..d03a1e4 100644
--- a/drivers/video/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/kyro/STG4000OverlayDevice.c
@@ -365,15 +365,18 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 	ulSrcBottom = srcDest.ulSrcY2;
 
 	ulSrc = ulSrcBottom - ulSrcTop;
-	ulDest = srcDest.lDstY2 - srcDest.lDstY1;	/* on-screen overlay */
-
 	if (ulSrc <= 1)
 		return -EINVAL;
+	ulDest = srcDest.lDstY2 - srcDest.lDstY1;	/* on-screen overlay */
+	if (ulDest = -1)
+		return -EINVAL;
 
 	/* First work out the position we are to display as offset from the
 	 * source of the buffer
 	 */
 	ulFxScale = (ulDest << 11) / ulSrc;	/* fixed point scale factor */
+	if (ulFxScale = 0)
+		return -EINVAL;
 	ulFxOffset = (srcDest.lDstY2 - srcDest.ulDstY2) << 11;
 
 	ulSrcBottom = ulSrcBottom - (ulFxOffset / ulFxScale);
@@ -430,6 +433,8 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 	 */
 	ulSrc = srcDest.ulSrcX2 - srcDest.ulSrcX1;
 	ulDest = srcDest.lDstX2 - srcDest.lDstX1;
+	if (ulDest = 0)
+		return -EINVAL;
 
 	if (srcDest.ulDstX1 > 2) {
 		ulLeft = srcDest.ulDstX1 + 2;
@@ -438,14 +443,14 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		ulLeft = srcDest.ulDstX1;
 		ulRight = srcDest.ulDstX2 + 1;
 	}
+	if (ulRight - ulLeft + 2 = 0)
+		return -EINVAL;
+
 
 	/* first work out the position we are to display as offset from the source of the buffer */
 	bResult = 1;
 
 	do {
-		if (ulDest = 0)
-			return -EINVAL;
-
 		/* source pixels per dest pixel <<11 */
 		ulFxScale = ((ulSrc - 1) << 11) / (ulDest);
 
