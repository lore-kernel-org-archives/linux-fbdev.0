From: Andrew Morton <akpm@osdl.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Wed, 15 Oct 2003 16:20:56 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031015162056.018737f1.akpm@osdl.org>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9uwf-0004iy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 16:20:45 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9uwe-00066l-Ei
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 16:20:44 -0700
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> wrote:
>
> Here is the latest fbdev patches.

This one comes up again and again.  What should we do with it?


--- 25/drivers/video/radeonfb.c~radeonfb-line_length-fix	2003-10-05 09:17:58.000000000 -0700
+++ 25-akpm/drivers/video/radeonfb.c	2003-10-05 09:17:58.000000000 -0700
@@ -2090,7 +2090,7 @@ static int radeonfb_set_par (struct fb_i
 	
 	}
 	/* Update fix */
-        info->fix.line_length = rinfo->pitch*64;
+        info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
         info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 #ifdef CONFIG_BOOTX_TEXT

_



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
