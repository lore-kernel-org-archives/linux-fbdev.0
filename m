From: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
Date: Fri, 13 Dec 2002 13:50:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212131347240.10159-100000@home.transmeta.com>
References: <Pine.LNX.4.33.0212091651540.2360-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212091651540.2360-100000@maxwell.earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


James,
 the fbcon update seems to have broken the plain VGA console. I get a page
fault at vgacon_scroll+0x144, the call sequence seems to be:

	vt_console_print+0x203
	set_cursor+0x78
	vgacon_cursor+x0xb5
	scrup+0x122
	vgacon_scroll+0x144

I don't know what triggers it, since it seems to happen pretty randomly.

		Linus
