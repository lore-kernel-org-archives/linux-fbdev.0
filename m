From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 07 Mar 2014 11:18:53 +0000
Subject: [patch -resend] sisfb: fix 1280x720 resolution support
Message-Id: <20140307111853.GB2351@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

It uses the wrong mode index because there is no break statement.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index 4f26bc28e60b..bd40f5ecd901 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -651,6 +651,7 @@ SiS_GetModeID_LCD(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDispla
 	     switch(VDisplay) {
 	     case 720:
 		ModeIndex = ModeIndex_1280x720[Depth];
+		break;
 	     case 768:
 		if(VGAEngine = SIS_300_VGA) {
 		   ModeIndex = ModeIndex_300_1280x768[Depth];
