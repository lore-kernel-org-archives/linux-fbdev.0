From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/6] i810fb: Fix default monitor sync timings
Date: Sat, 16 Apr 2005 13:22:38 +0800
Message-ID: <200504161322.38603.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMfrN-0002BC-Qf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:49 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMfrL-0008C3-Bp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:49 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 278B315321E9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 05:28:33 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Denis Vlasenko <vda@ilport.com.ua>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  - Increase error message verbosity with respect
    to monitor timings.

  - Fix default sync timings

From: Denis Vlasenko <vda@ilport.com.ua>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 i810_main.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2005-04-14 12:06:02 +08:00
+++ b/drivers/video/i810/i810_main.c	2005-03-28 23:04:58 +08:00
@@ -999,8 +999,14 @@
 	info->monspecs.dclkmin = 15000000;
 
 	if (fb_validate_mode(var, info)) {
-		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info))
+		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info)) {
+			int default_sync = (hsync1-HFMIN)|(hsync2-HFMAX)
+					    |(vsync1-VFMIN)|(vsync2-VFMAX);
+			printk("i810fb: invalid video mode%s\n",
+			    default_sync ? "" :
+			    ". Specifying vsyncN/hsyncN parameters may help");
 			return -EINVAL;
+		}
 	}
 	
 	var->xres = xres;
@@ -2023,10 +2029,10 @@
 		 " (default = 480)");
 module_param(hsync1, int, 0);
 MODULE_PARM_DESC(hsync1, "Minimum horizontal frequency of monitor in KHz"
-		 " (default = 31)");
+		 " (default = 29)");
 module_param(hsync2, int, 0);
 MODULE_PARM_DESC(hsync2, "Maximum horizontal frequency of monitor in KHz"
-		 " (default = 31)");
+		 " (default = 30)");
 module_param(vsync1, int, 0);
 MODULE_PARM_DESC(vsync1, "Minimum vertical frequency of monitor in Hz"
 		 " (default = 50)");




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
