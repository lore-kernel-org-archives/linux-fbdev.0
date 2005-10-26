From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/4] fbdev: Rearrange mode database entries
Date: Wed, 26 Oct 2005 19:53:46 +0800
Message-ID: <435F6E4A.3080301@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUk2V-0001qw-Q5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:05:55 -0700
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EUk2R-0003pn-VM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:05:55 -0700
Received: by zproxy.gmail.com with SMTP id i28so145604nzi
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Oct 2005 05:05:51 -0700 (PDT)
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

Rearrange mode database entries such that preferred timings are entered
first, and less preferred timings are entered last. (Detailed, VESA,
established/standard).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbmon.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)


diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 442a52d..fc7965b 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -538,25 +538,12 @@ static struct fb_videomode *fb_create_mo
 
 	*dbsize = 0;
 
-	DPRINTK("   Supported VESA Modes\n");
-	block = edid + ESTABLISHED_TIMING_1;
-	num += get_est_timing(block, &mode[num]);
-
-	DPRINTK("   Standard Timings\n");
-	block = edid + STD_TIMING_DESCRIPTIONS_START;
-	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE) 
-		num += get_std_timing(block, &mode[num]);
-
 	DPRINTK("   Detailed Timings\n");
 	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
 	        int first = 1;
 
-		if (block[0] == 0x00 && block[1] == 0x00) {
-			if (block[3] == 0xfa) {
-				num += get_dst_timing(block + 5, &mode[num]);
-			}
-		} else  {
+		if (!(block[0] == 0x00 && block[1] == 0x00)) {
 			get_detailed_timing(block, &mode[num]);
 			if (first) {
 			        mode[num].flag |= FB_MODE_IS_FIRST;
@@ -565,6 +552,21 @@ static struct fb_videomode *fb_create_mo
 			num++;
 		}
 	}
+
+	DPRINTK("   Supported VESA Modes\n");
+	block = edid + ESTABLISHED_TIMING_1;
+	num += get_est_timing(block, &mode[num]);
+
+	DPRINTK("   Standard Timings\n");
+	block = edid + STD_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE)
+		num += get_std_timing(block, &mode[num]);
+
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
+		if (block[0] == 0x00 && block[1] == 0x00 && block[3] == 0xfa)
+			num += get_dst_timing(block + 5, &mode[num]);
+	}
 	
 	/* Yikes, EDID data is totally useless */
 	if (!num) {



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
