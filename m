From: jsimmons@pentafluge.infradead.org
Subject: New fbdev patch.
Date: Wed, 23 Jun 2004 19:04:53 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406231859390.27210@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdC7F-0008SO-Q8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:04:57 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdC7E-0002Fc-VI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:04:57 -0700
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.33 #1 (Red Hat Linux))
	id 1BdC7B-00079X-5N
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 19:04:53 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Sorry it has been awhile. I have anew patch against 2.6.7 for peoepl to 
try out. Its big because it has alot of driver updates. It has a newer
Mach64 driver. Note it has atyfb_base.c.new file. These changes I wanted 
to test but my old laptop died. No more Mach64 card to test with :-( 
It has the cirrusfb driver update. Also the Epson1355 driver has been 
updated as well. Kryo, SGI Visual Workstation, 3Dfx, and VGA16fb driver 
has ben port to use framebuffer_alloc/release. I have updates to the 
rivafb driver to support more cards. I merged in more changes from Tony. 
Thanks Tony. The neomagic also has some more acceleration fixes.

The patch against 2.6.7 is at 

http://www.infradead.org/~jsimmons/changes.diff






-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
