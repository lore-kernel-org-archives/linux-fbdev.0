From: John Zielinski <grim@undead.cc>
Subject: patch to radeonfb accel functions
Date: Fri, 23 Apr 2004 03:04:52 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4088C014.7030505@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050909090006060005030303"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGukA-0003cE-38
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 00:05:02 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BGuk9-0004R5-N2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 00:05:01 -0700
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

This is a multi-part message in MIME format.
--------------050909090006060005030303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I haven't seen anything about this on the list so I'm posting it.  The 
first change adds the pseudo_palette lookup to the fillrect function 
which cleans up the ugliness when running make menuconfig among other 
things.  The second change I'm not 100% sure if it's right but I'm quite 
sure what was originally there isn't right.  DP_SRC_RECT has the same 
value as GMC_DST_8BPP and is listed in the DP_MIX section and not the 
GMC section .  I'm assuming it should have been GMC_DP_SRC_RECT .  Can 
someone else confirm this?

John


--------------050909090006060005030303
Content-Type: text/plain;
 name="radeon_accel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_accel.patch"

diff -urNX dontdiff linux-2.6.5/drivers/video/aty/radeon_accel.c linux/drivers/video/aty/radeon_accel.c
--- linux-2.6.5/drivers/video/aty/radeon_accel.c	2004-04-03 22:37:36.000000000 -0500
+++ linux/drivers/video/aty/radeon_accel.c	2004-04-23 02:36:54.000000000 -0400
@@ -47,6 +47,10 @@
 	if(modded.dx + modded.width  > vxres) modded.width  = vxres - modded.dx;
 	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
 
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR )
+		modded.color = ((u32 *) (info->pseudo_palette))[modded.color];
+		
 	radeonfb_prim_fillrect(rinfo, &modded);
 }
 
@@ -58,7 +62,7 @@
 		rinfo->dp_gui_master_cntl /* i.e. GMC_DST_32BPP */
 		| GMC_SRC_DSTCOLOR
 		| ROP3_S 
-		| DP_SRC_RECT );
+		| GMC_DP_SRC_RECT );
 	OUTREG(DP_WRITE_MSK, 0xffffffff);
 	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
 

--------------050909090006060005030303--



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
