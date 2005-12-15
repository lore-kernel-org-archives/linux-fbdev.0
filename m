From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: i810fb_blank
Date: Thu, 15 Dec 2005 16:14:44 -0200
Message-ID: <200512151614.44766.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UKboDWRdIznQ4I5"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Emxja-00068M-BL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 10:21:42 -0800
Received: from mail.lsi.usp.br ([143.107.161.163])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EmxjW-0005Rb-Jq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 10:21:42 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

--Boundary-00=_UKboDWRdIznQ4I5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

While looking at i810fb_blank() on 2.4 and 2.6, I've seen that there's a 
difference on how pwr mask is handled: 2.4 unsets the pwr bit on 
FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND commands, 
while 2.6 turns that bit on. Was that modification expected, or was it a 
typo? The attached patch shows the code in question.

Thanks!

-- 
Lucas
powered by /dev/dsp

--Boundary-00=_UKboDWRdIznQ4I5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.14.3-i810-suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.14.3-i810-suspend.patch"

Signed-off-by: Lucas Correia Villa Real <lucasvr@gobolinux.org>

--- linux-2.6.14.3/drivers/video/i810/i810_main.c.orig	2005-12-03 16:44:06.000000000 -0200
+++ linux-2.6.14.3/drivers/video/i810/i810_main.c	2005-12-03 16:45:55.000000000 -0200
@@ -1359,12 +1359,12 @@ static int i810fb_blank (int blank_mode,
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		mode = STANDBY;
-		pwr |= 1;
+		pwr &= ~1;
 		scr_off = OFF;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		mode = SUSPEND;
-		pwr |= 1;
+		pwr &= ~1;
 		scr_off = OFF;
 		break;
 	case FB_BLANK_POWERDOWN:

--Boundary-00=_UKboDWRdIznQ4I5--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
