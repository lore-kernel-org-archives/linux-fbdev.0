From: James Simmons <jsimmons@infradead.org>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Tue, 13 May 2003 23:32:39 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305132326190.12672-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0305080731520.12135-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19FiKk-0001Gz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 15:33:18 -0700
In-Reply-To: <Pine.GSO.4.21.0305080731520.12135-100000@vervain.sonytel.be>
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


> > I have put alot of though and even tested some raw code for this. The 
> > issue with just replacing the FB_WRITE and FB_READ stuff is more than one 
> > card could be present and each would require a different FB_WRITE. This 
> > would conflict. So what do we do? Ah the answer is use struct pixmap to 
> 
> It would not conflict with multiple cards, since if you set some defines and
> #include the cfb* sources, you would get routines with slightly different
> names, cfr. Christopher's approach.

  I have some code but I realized it is more of a challege than I thought. 
I don't see how one can nearly use the same code as in cfb*.c files for 16 
bit access since the whole idea behind the cfb*.c files is to write 32/64 
bit data at a time to the framebuffer. It would require a very different 
logic. There is just to many BITS_PER_LONG and stuff in the code. 
  At present I moved the code over to using the struct pixmap fields. In 
theory just changing the scan_align value should work. It doesn't tho :-(
Chris coudl you send me what you have tho. Just merge in your version of 
the cfb* functions into your driver for now. 
  Currently I'm trying to push a bunch to Linus. So I like to push your 
driver.
 



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
