From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH][RIVAFB] rivafb: fb accel capabilities
Date: Thu, 17 Jun 2004 14:24:47 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617182446.GA6355@havoc.gtf.org>
References: <200406160406.07060.adaplas@hotpop.com> <Pine.LNX.4.56.0406161743100.14901@pentafluge.infradead.org> <20040616132318.1435b0c7.akpm@osdl.org> <200406170629.27427.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb1ZL-0008Na-8B
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 11:24:59 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb1ZK-0000P8-UF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 11:24:59 -0700
Content-Disposition: inline
In-Reply-To: <200406170629.27427.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org, linux-fbdev-devel@lists.sourceforge.net

Dear Andrew,

Here's the fb accel capabilities patch for rivafb.

-dte


diff -ru linux-2.6.7-rc3-mm2-wrivafb/drivers/video/riva/fbdev.c linux-2.6.7-rc3-mm2-wrivafb2/drivers/video/riva/fbdev.c
--- linux-2.6.7-rc3-mm2-wrivafb/drivers/video/riva/fbdev.c	2004-06-17 14:08:29.000000000 -0400
+++ linux-2.6.7-rc3-mm2-wrivafb2/drivers/video/riva/fbdev.c	2004-06-16 12:39:11.000000000 -0400
@@ -1665,7 +1665,12 @@
 {
 	unsigned int cmap_len;
 
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT
+		    | FBINFO_HWACCEL_XPAN
+		    | FBINFO_HWACCEL_YPAN
+		    | FBINFO_HWACCEL_COPYAREA
+		    | FBINFO_HWACCEL_FILLRECT
+		    | FBINFO_HWACCEL_IMAGEBLIT;
 	info->var = rivafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
