From: John Zielinski <grim@undead.cc>
Subject: Restoring Screen when coming back from KD_GRAPHICS
Date: Wed, 26 Nov 2003 03:11:40 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC4603C.2000702@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOum9-0000BU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Nov 2003 00:11:53 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AOum9-0000bu-7m
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Nov 2003 00:11:53 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

I was playing with the fbtest program and noticed some minor glitches.  
You could see corruption in the graphics where the console was still 
trying to output text from the program.  After exiting the program's 
output would mix in with the saved screen.

So I modified the fbtest program to do ioctl to KD_GRAPHICS at startup 
and KD_TEXT on exit and the graphics corruption went away.  I also 
didn't save/restore the framebuffer if we started in KD_TEXT on entry.  
This made things worse as now the graphics output was still plus the old 
text and the programs output would now appear after scrolling one line.

I checked the kernel to see why the screen wasn't being refreshed when 
switching back to KD_TEXT.   I found that if the fbdev driver has a 
blanking routine the fbcon driver doesn't do a update_screen call.  And 
the fbdev if it's using vesa blanking doesn't restore the screen nor 
does it return 1 to tell the vt driver to redraw the screen.

So here's a small patch that makes fbcon always restore the screen after 
the screen is unblanked:

diff -urNX dontdiff fbdev/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- fbdev/drivers/video/console/fbcon.c	2003-11-26 01:11:00.000000000 -0500
+++ linux/drivers/video/console/fbcon.c	2003-11-26 01:07:20.000000000 -0500
@@ -1688,11 +1688,13 @@
 				accel_clear(vc, info, real_y(p, 0),
 					    0, height, vc->vc_cols);
 			vc->vc_video_erase_char = oldc;
-		} else
-			update_screen(vc->vc_num);
-		return 0;
+		} 
 	} else
-		return fb_blank(info, blank);
+		fb_blank(info, blank);
+		
+	if (!blank)
+		update_screen(vc->vc_num);
+	return 0;
 }
 
 static void fbcon_free_font(struct display *p)



I think that this is the simplest way of doing it as the other two 
options would require to either change the vt driver to send a leaving 
KD_TEXT call or to change the fbcon driver to remember if each console 
was in graphics mode or not.

John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
