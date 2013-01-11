From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 11 Jan 2013 06:52:02 +0000
Subject: [patch] sisfb: fix 1280x720 resolution support
Message-Id: <20130111065201.GC13207@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

It uses the wrong mode index because there is no break statement.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker fix.  Untested.

diff --git a/drivers/video/sis/init.c b/drivers/video/sis/init.c
index f082ae5..0b71c53 100644
--- a/drivers/video/sis/init.c
+++ b/drivers/video/sis/init.c
@@ -651,6 +651,7 @@ SiS_GetModeID_LCD(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDispla
 	     switch(VDisplay) {
 	     case 720:
 		ModeIndex = ModeIndex_1280x720[Depth];
+		break;
 	     case 768:
 		if(VGAEngine = SIS_300_VGA) {
 		   ModeIndex = ModeIndex_300_1280x768[Depth];
