From: James Simmons <jsimmons@infradead.org>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Wed, 7 May 2003 22:57:57 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305072107440.6566-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0305071050400.29816-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DWvq-0004sY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 14:58:34 -0700
In-Reply-To: <Pine.GSO.4.21.0305071050400.29816-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christopher Hoover <ch@murgatroid.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Personally, I think it wouldn't harm to be make the cfb* routines generic, so
> you can set some defines and #include them to tailer them to your card's
> needs.
> 
> Even on some 64-bit platforms, you may not want to use 64-bit accesses, e.g.
> because your graphic's card bus is still only 32-bit.
> 
> I can even think of some more sofistication: on older Amigas, the graphics RAM
> is 16-bit wide and quite slow, while the CPU is 32-bit. So it may make sense to
> always use 32-bit accesses (like is currently done), except for the first and
> last unaligned accesses if they are less or equal than 16-bit.

I have put alot of though and even tested some raw code for this. The 
issue with just replacing the FB_WRITE and FB_READ stuff is more than one 
card could be present and each would require a different FB_WRITE. This 
would conflict. So what do we do? Ah the answer is use struct pixmap to 
handle it. I just reworked cfbimgblt.c to use struct pixmap and I am in 
the process of of working on the other cfb_* functions. Would you be 
willing to test this out? In theory one would only have to place in there 
own FB_WRITE[READ] function. 






-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
