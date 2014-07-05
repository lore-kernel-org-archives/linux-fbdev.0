From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:42:29 +0000
Subject: [PATCH] video: fbdev: omap2: dss: rfbi.c:  Cleaning up variable that is never used
Message-Id: <1404564149-21193-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/omap2/dss/rfbi.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/rfbi.c b/drivers/video/fbdev/omap2/dss/rfbi.c
index c8a81a2..6f03bbb 100644
--- a/drivers/video/fbdev/omap2/dss/rfbi.c
+++ b/drivers/video/fbdev/omap2/dss/rfbi.c
@@ -574,7 +574,6 @@ static int rfbi_setup_te(enum omap_rfbi_te_mode mode,
 {
 	int hs, vs;
 	int min;
-	u32 l;
 
 	hs = ps_to_rfbi_ticks(hs_pulse_time, 1);
 	vs = ps_to_rfbi_ticks(vs_pulse_time, 1);
@@ -595,15 +594,7 @@ static int rfbi_setup_te(enum omap_rfbi_te_mode mode,
 	rfbi_write_reg(RFBI_HSYNC_WIDTH, hs);
 	rfbi_write_reg(RFBI_VSYNC_WIDTH, vs);
 
-	l = rfbi_read_reg(RFBI_CONFIG(0));
-	if (hs_pol_inv)
-		l &= ~(1 << 21);
-	else
-		l |= 1 << 21;
-	if (vs_pol_inv)
-		l &= ~(1 << 20);
-	else
-		l |= 1 << 20;
+	rfbi_read_reg(RFBI_CONFIG(0));
 
 	return 0;
 }
-- 
1.7.10.4

