From: Andrew Morton <akpm@osdl.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Wed, 15 Oct 2003 16:17:05 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031015161705.221a579b.akpm@osdl.org>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9usw-0004Un-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 16:16:54 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9usv-00059g-OH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 16:16:53 -0700
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
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chris Heath <chris@heathens.co.nz>

James Simmons <jsimmons@infradead.org> wrote:
>
> Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> Several fixes. The patch is against 2.6.0-test7
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Cool.  I've had the below fix floating about for a while.  Is it still
relevant?



From: Chris Heath <chris@heathens.co.nz>

I am still seeing a lot of cursors being left behind.  It is not a race
condition or anything -- in the TTY line editor, it happens about 50% of
the time when you press backspace.

What appears to be happening is the cursor is flashing twice as slowly
as the driver thinks it is, so of course it's wrong half the time when
it comes to erase the cursor.

The patch below fixes it for me.



 drivers/video/softcursor.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN drivers/video/softcursor.c~cursor-flashing-fix drivers/video/softcursor.c
--- 25/drivers/video/softcursor.c~cursor-flashing-fix	2003-08-16 14:01:15.000000000 -0700
+++ 25-akpm/drivers/video/softcursor.c	2003-08-16 14:01:15.000000000 -0700
@@ -74,6 +74,12 @@ int soft_cursor(struct fb_info *info, st
 
 	if (info->cursor.image.data)
 		info->fbops->fb_imageblit(info, &info->cursor.image);
+
+	if (!info->cursor.enable) {
+		for (i = 0; i < size; i++)
+			dst[i] ^= info->cursor.mask[i];
+	}
+
 	return 0;
 }
 

_



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
