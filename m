From: Antonino Daplas <adaplas@pol.net>
Subject: problem with gen_update_var
Date: 11 Jun 2002 00:41:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1023690850.568.1.camel@daplas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-n2UfbWpC+95LBg2bGJmN"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17HSCQ-000061-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Jun 2002 09:39:22 -0700
Received: from [205.136.61.104] (cwc104.compass.com.ph [205.136.61.104])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id AAA22695
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Jun 2002 00:39:16 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-n2UfbWpC+95LBg2bGJmN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

gen_update_var will break panning/wrapping since it passes info->var to
fb_pan_display.  However, fbcon updates display->var.

Tony

 





--=-n2UfbWpC+95LBg2bGJmN
Content-Disposition: attachment; filename=fbgen.c.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

--- fbgen.c.orig	Mon Jun 10 06:30:29 2002
+++ fbgen.c	Mon Jun 10 06:26:44 2002
@@ -514,6 +514,9 @@
    =20
 	if (con =3D=3D info->currcon) {
 		if (info->fbops->fb_pan_display) {
+			info->var.xoffset =3D fb_display[con].var.xoffset;
+			info->var.yoffset =3D fb_display[con].var.yoffset;
+			info->var.vmode =3D fb_display[con].var.vmode;
 			if ((err =3D info->fbops->fb_pan_display(&info->var, con, info)))
 				return err;
 		}

--=-n2UfbWpC+95LBg2bGJmN--


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
