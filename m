From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:32:07 +0000
Subject: [PATCH] video: fbdev: gbefb.c:  Cleaning up variable that is never used
Message-Id: <1404671528-18203-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404562932-19522-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404562932-19522-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, Masanari Iida <standby24x7@gmail.com>, "H. Peter Anvin" <hpa@linux.intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/gbefb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 4aa56ba..4227570 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -205,7 +205,7 @@ static void gbe_reset(void)
 static void gbe_turn_off(void)
 {
 	int i;
-	unsigned int val, x, y, vpixen_off;
+	unsigned int val, y, vpixen_off;
 
 	gbe_turned_on = 0;
 
@@ -256,7 +256,7 @@ static void gbe_turn_off(void)
 
 	for (i = 0; i < 100000; i++) {
 		val = gbe->vt_xy;
-		x = GET_GBE_FIELD(VT_XY, X, val);
+		GET_GBE_FIELD(VT_XY, X, val);
 		y = GET_GBE_FIELD(VT_XY, Y, val);
 		if (y < vpixen_off)
 			break;
@@ -267,7 +267,7 @@ static void gbe_turn_off(void)
 		       "gbefb: wait for vpixen_off timed out\n");
 	for (i = 0; i < 10000; i++) {
 		val = gbe->vt_xy;
-		x = GET_GBE_FIELD(VT_XY, X, val);
+		GET_GBE_FIELD(VT_XY, X, val);
 		y = GET_GBE_FIELD(VT_XY, Y, val);
 		if (y > vpixen_off)
 			break;
-- 
1.7.10.4

