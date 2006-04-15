From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] pm2fb section mismatches
Date: Fri, 14 Apr 2006 21:49:05 -0700
Message-ID: <20060414214905.375a308a.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUcgB-00049h-2A
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 21:46:39 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FUcgB-0001x5-2d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 21:46:39 -0700
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Apr 2006 21:46:38 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, jim.hague@acm.org

From: Randy Dunlap <rdunlap@xenotime.net>

modpost warns:

WARNING: drivers/video/pm2fb.o - Section mismatch: reference to .init.data: from .text.pm2fb_set_par after 'pm2fb_set_par' (at offset 0x7d4)
WARNING: drivers/video/pm2fb.o - Section mismatch: reference to .init.data: from .text.pm2fb_set_par after 'pm2fb_set_par' (at offset 0x7f9)

These are due to pm2fb_set_par() referencing <lowhsync> and
<lowvsync>, which are __devinitdata.  Question is:  can
pm2fb_set_par() [or any fb_set_par method] be called after
driver initializtion?  I.e., do all of those calls in
console/fbcon.c to fbops->fb_set_par() happen only during
driver init, or can they happen later?  If they can happen
later, then this patch is needed.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/video/pm2fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2617-rc1g8.orig/drivers/video/pm2fb.c
+++ linux-2617-rc1g8/drivers/video/pm2fb.c
@@ -73,8 +73,8 @@ static char *mode __devinitdata = NULL;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync __devinitdata = 0;
-static int lowvsync __devinitdata = 0;
+static int lowhsync;
+static int lowvsync;
 
 /*
  * The hardware state of the graphics card that isn't part of the


---


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
