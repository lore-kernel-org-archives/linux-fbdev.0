From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/9] atyfb: Remove code that sets sync polarity unconditionally
Date: Sat, 20 Aug 2005 00:49:55 +0800
Message-ID: <43060DB3.3070806@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HHq-0002QN-Qy
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:38 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HHq-0000wH-K0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:38 -0700
Received: by wproxy.gmail.com with SMTP id i3so655817wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:32:32 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alexander Kern <alex.kern@gmx.de>

    Currently, atyfb has code that sets the hsync and vsync polarity based on
    the current video mode, without letting the user override the settings.

    Remove this particular code.  The sync polarities are set by the PROM,
    the user or by the videomode.

    From: Alexander Kern <alex.kern@gmx.de>
    Signed-off-by: Alexander Kern <alex.kern@gmx.de>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 atyfb_base.c |   14 --------------
 1 files changed, 14 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -911,20 +911,6 @@ static int aty_var_to_crtc(const struct 
 		vdisplay  = par->lcd_height;
 #endif
 
-	if(vdisplay < 400) {
-		h_sync_pol = 1;
-		v_sync_pol = 0;
-	} else if(vdisplay < 480) {
-		h_sync_pol = 0;
-		v_sync_pol = 1;
-	} else if(vdisplay < 768) {
-		h_sync_pol = 0;
-		v_sync_pol = 0;
-	} else {
-		h_sync_pol = 1;
-		v_sync_pol = 1;
-	}
-
 	v_disp--;
 	v_sync_strt--;
 	v_sync_end--;



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
