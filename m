From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/10] nvidiafb: Use CVT to get mode for digital displays
Date: Fri, 02 Sep 2005 05:36:27 +0800
Message-ID: <4317745B.5090407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2U-0004kw-RY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:06 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2U-0003s0-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:07 -0700
Received: by wproxy.gmail.com with SMTP id i22so260992wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:00 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    If no EDID block is probed, if the display is digital and if no mode option
    is specified by the user, get the timings by CVT instead of using the
    global mode database.
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 nvidia.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1328,7 +1328,7 @@ static int __devinit nvidia_set_fbinfo(s
 		char buf[16];
 
 		memset(buf, 0, 16);
-		snprintf(buf, 15, "%dx%d", par->fpWidth, par->fpHeight);
+		snprintf(buf, 15, "%dx%dMR", par->fpWidth, par->fpHeight);
 		fb_find_mode(&nvidiafb_default_var, info, buf, specs->modedb,
 			     specs->modedb_len, &modedb, 8);
 	}




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
