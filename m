From: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
Date: Fri, 13 Dec 2002 16:14:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212131611490.6750-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212132355040.19622-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212132355040.19622-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



On Sat, 14 Dec 2002, James Simmons wrote:
>
> Calling scrup is out of place. It is only called by lf() and csi_M() in
> the vt.c. lf() is used in vt_console_print but it is called before
> set_cursor(). Also vgacon_cursor doesn't call vgacon_scroll. It can call
> vgacon_scrolldelta. Now scrup does call vgacon_scroll. It looks like The
> code jumped from the middle of vt_console_print to scrup. Do you get the
> same error all the time? Also do you have Preemptible Kernel turned on?

This is UP, and not preemptible. And the backtrace may be corrupt, because
when the page fault happens, it will actually page fault _again_ as part
of trying to print out the oops, so the whole thing scrolls largely off
the screen..

I only see this on one of my laptops, and even there it seems to be
timing-dependent or something (I think it only happens when I press a key,
and because the backtrace isn't trustworthy ..)

		Linus
