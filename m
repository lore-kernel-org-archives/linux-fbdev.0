From: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [FBDEV BK] Updates and fixes.
Date: Mon, 14 Apr 2003 12:15:35 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304141209420.19302-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from neon-gw-l3.transmeta.com ([63.209.4.196] helo=neon-gw.transmeta.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1959Qm-0003d5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Apr 2003 12:15:52 -0700
In-Reply-To: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


On Mon, 14 Apr 2003, James Simmons wrote:
> 
> Linus, please do a
> 
> 	bk pull http://fbdev.bkbits.net/fbdev-2.5

This seems to cause

	arch/i386/boot/setup.o(.text+0x9a4): In function `video':
	: undefined reference to `store_edid'

which is apparently because I don't configure VIDEO_SELECT.

I did this to make it compile, but you should check what the real issue 
is.

		Linus
----
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1034  -> 1.1035 
#	arch/i386/boot/video.S	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/14	torvalds@home.transmeta.com	1.1035
# Store EDID only when CONFIG_VIDEO_SELECT is set and edid
# function actually exists.
# --------------------------------------------
#
diff -Nru a/arch/i386/boot/video.S b/arch/i386/boot/video.S
--- a/arch/i386/boot/video.S	Mon Apr 14 12:14:46 2003
+++ b/arch/i386/boot/video.S	Mon Apr 14 12:14:46 2003
@@ -133,9 +133,9 @@
 #ifdef CONFIG_VIDEO_RETAIN
 	call	restore_screen			# Restore screen contents
 #endif /* CONFIG_VIDEO_RETAIN */
+	call	store_edid
 #endif /* CONFIG_VIDEO_SELECT */
 	call	mode_params			# Store mode parameters
-	call	store_edid
 	popw	%ds				# Restore original DS
 	ret
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
