From: Ben Dooks <ben-linux@fluff.org>
Subject: SM501: Align PANEL fb to PAGE_SIZE
Date: Thu, 17 Jul 2008 11:43:47 +0100
Message-ID: <20080717104346.869293986@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJQy4-0000ro-NN for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 Jul 2008 03:44:12 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KJQy0-0004Bm-T9
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 Jul 2008 03:44:11 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-sm501-pagealign.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>

Some programs, such as anything linked with directfb get
the drawing wrong if given an screen start which is not
aligned to PAGE_SIZE. Change the allocator to always return
an properly aligned address when asked for PANEL memory.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-quilt1/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.26-quilt1.orig/drivers/video/sm501fb.c	2008-07-16 15:02:59.000000000 +0100
+++ linux-2.6.26-quilt1/drivers/video/sm501fb.c	2008-07-16 15:06:12.000000000 +0100
@@ -162,6 +162,13 @@ static int sm501_alloc_mem(struct sm501f
 		ptr = inf->fbmem_len - size;
 		fbi = inf->fb[HEAD_CRT];
 
+		/* round down, some programs such as directfb do not draw
+		 * 0,0 correctly unless the start is aligned to a page start.
+		*/
+
+		if (ptr > 0)
+			ptr &= ~(PAGE_SIZE - 1);
+
 		if (fbi && ptr < fbi->fix.smem_len)
 			return -ENOMEM;
 

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
