From: James Simmons <jsimmons@infradead.org>
Subject: Re: Using VESA BIOS in Framebuffer driver
Date: Wed, 14 May 2003 23:40:00 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305142334490.14201-100000@phoenix.infradead.org>
References: <20030514042029.24447.qmail@india.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19G4vQ-00089x-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 May 2003 15:40:40 -0700
In-Reply-To: <20030514042029.24447.qmail@india.com>
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
To: seetaram Tekkalakot <seetaram_nt@india.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I am developing a framebuffer driver for my PLC 69030 video card.
> I have gone through the Source code of the Sample framebuffer driver and 
> i have some clarifications needed. Please clarify my doubts.
> 
> 1.How does the Frame buffer driver Switches graphics modes, i mean how does
> it initializes the graphics system say in 640*480*256 mode and switch 
> to say 800*600*24 mode.

Well that is very hardware dependent. Which kernel are you working with?

> Does it depend on VESA BIOS calls to do this ?

NO!!! There does exist vesafb.c for this but this only works on a system 
with a BIOS. If you have a system with no BIOS you are out of luck.

> 2.How does the framebuffer driver achieve paging ?
> Say my display memoy is 4mb and i want divide it into 4 pages then how 
> will i do this ?

4 pages? 




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
