From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] radeonfb: mode switch work around
Date: Sat, 3 Jul 2004 20:05:18 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040704000518.GA14801@havoc.gtf.org>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston> <cc3d6r$d5v$1@sea.gmane.org> <200407022337.20156.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BguVc-0000j9-54
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:05:28 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BguVb-0006ls-S2
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:05:28 -0700
Content-Disposition: inline
In-Reply-To: <200407022337.20156.adaplas@hotpop.com>
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
Cc: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Here's the fix for radeonfb for use with your patch.

-dte

diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-06-28 02:28:36 +02:00
+++ b/drivers/video/aty/radeon_base.c	2004-07-04 01:50:23 +02:00
@@ -1793,7 +1793,8 @@
 		    | FBINFO_HWACCEL_COPYAREA
 		    | FBINFO_HWACCEL_FILLRECT
 		    | FBINFO_HWACCEL_XPAN
-		    | FBINFO_HWACCEL_YPAN;
+		    | FBINFO_HWACCEL_YPAN
+		    | FBINFO_MISC_MODESWITCHLATE;
 	info->fbops = &radeonfb_ops;
 	info->screen_base = (char *)rinfo->fb_base;
 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
