From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Tue, 23 Dec 2003 23:45:21 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE919E1.7050609@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>	 <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc>	 <1072230310.739.25.camel@gaston>  <3FE90001.3080207@undead.cc> <1072236683.739.32.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010001000405020002040202"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ0tu-0004k6-8Z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 20:45:38 -0800
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZ0tt-00063t-Rn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 20:45:37 -0800
In-Reply-To: <1072236683.739.32.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010001000405020002040202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>Well, the interesting thing is does X using "fbdev" has proper colors
>(or X using "ati" driver with UseFBDev option). If yes, then that code
>is right. It's the console/blit code that is wrong.
>  
>
Confirmed using fbtest.  With that section commented out fbtest's colors 
are messed up.

Hmmm....  Just found something.  Here's an updated patch.  Notice the 6 
changing to a 5 in the 16 bit case.  This makes the console and fbtest 
look right.... except for the penguins.  Their colors are messed up 
depending on the test order.

John


--------------010001000405020002040202
Content-Type: text/plain;
 name="patch.16bppfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.16bppfix"

diff -urNX dontdiff linux.old/drivers/video/aty/radeon_base.c linux/drivers/video/aty/radeon_base.c
--- linux.old/drivers/video/aty/radeon_base.c	2003-12-21 17:54:33.000000000 -0500
+++ linux/drivers/video/aty/radeon_base.c	2003-12-23 23:23:03.000000000 -0500
@@ -1197,12 +1197,12 @@
  	if (regno < 16) {
         	switch (rinfo->depth) {
 		case 15:
-			((u16 *) (info->pseudo_palette))[regno] =
+			((u32 *) (info->pseudo_palette))[regno] =
 			    (regno << 10) | (regno << 5) | regno;
 			break;
 		case 16:
-			((u16 *) (info->pseudo_palette))[regno] =
-			    (regno << 11) | (regno << 6) | regno;
+			((u32 *) (info->pseudo_palette))[regno] =
+			    (regno << 11) | (regno << 5) | regno;
 			break;
 		case 24:
 			((u32 *) (info->pseudo_palette))[regno] =

--------------010001000405020002040202--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
