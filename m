From: John Zielinski <grim@undead.cc>
Subject: Re: Changing modes with fbset
Date: Sat, 13 Dec 2003 20:14:39 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FDBB97F.4070207@undead.cc>
References: <3FD6C52C.7090906@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVKqV-0001uR-2F
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Dec 2003 17:14:55 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AVKqU-00014O-Iv
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Dec 2003 17:14:54 -0800
In-Reply-To: <3FD6C52C.7090906@undead.cc>
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
To: linux-fbdev-devel@lists.sourceforge.net

Found it.  It's a bug in fbcon.c where the rows and cols were mixed up 
so fbcon_resize tries to set the mode again with xres and yres 
reversed.  Didn't happen during boot as fbcon_state_manager is 
registered after the console is taken over.


diff -urNX dontdiff linux.old/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux.old/drivers/video/console/fbcon.c	2003-12-13 19:32:14.000000000 -0500
+++ linux/drivers/video/console/fbcon.c	2003-12-13 19:34:48.000000000 -0500
@@ -2261,8 +2261,8 @@
 			// Switch resolution size
 			int rows, cols;
 			
-			rows = info->var.xres / vc->vc_font.height;
-			cols = info->var.yres / vc->vc_font.width;
+			rows = info->var.yres / vc->vc_font.height;
+			cols = info->var.xres / vc->vc_font.width;
         		fbcon_resize(vc, cols, rows);
 			info->state |= flag;
 			}



John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
