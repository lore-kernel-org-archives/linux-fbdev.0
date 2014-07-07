From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Mon, 07 Jul 2014 20:56:19 +0000
Subject: [PATCH v2] video: fbdev: sis: init.c:  Cleaning up redundant condition is always true
Message-Id: <1404766579-25501-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404764628-25192-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404764628-25192-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mauro Carvalho Chehab <m.chehab@samsung.com>, "Chen, Gong" <gong.chen@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Find a redundant condition that is always true, that after
some discussions prove to be that wrong variable that was checked.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/sis/init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index bd40f5e..dc9613a 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -355,12 +355,12 @@ SiS_GetModeID(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDisplay,
 		}
 		break;
 	case 400:
-		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDwidth >= 600))) {
+		if ((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDheight >= 600))) {
 			if(VDisplay = 300) ModeIndex = ModeIndex_400x300[Depth];
 		}
 		break;
 	case 512:
-		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 1024) && (LCDwidth >= 768))) {
+		if ((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 1024) && (LCDheight >= 768))) {
 			if(VDisplay = 384) ModeIndex = ModeIndex_512x384[Depth];
 		}
 		break;
-- 
1.7.10.4

