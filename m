From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
Date: Fri, 13 Dec 2002 17:49:37 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212131745130.1882-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.44.0212131611490.6750-100000@home.transmeta.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120] helo=albatross.prod.itd.earthlink.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18N0cU-0004ob-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Dec 2002 16:57:30 -0800
In-Reply-To: <Pine.LNX.4.44.0212131611490.6750-100000@home.transmeta.com>
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
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> This is UP, and not preemptible. And the backtrace may be corrupt, because
> when the page fault happens, it will actually page fault _again_ as part
> of trying to print out the oops, so the whole thing scrolls largely off
> the screen..

Thats right. If the low level console driver is broken it will call
printk which could be using the broken driver :-(

> I only see this on one of my laptops, and even there it seems to be
> timing-dependent or something (I think it only happens when I press a key,
> and because the backtrace isn't trustworthy ..)

If it happens only when you press a key which is always true:

1) Its the same place on the screen or a different place every time?

2) Always the last line of the screen?

3) Always the last column?


If you don't mind me asking what is model of your laptop to see if someone
else is having the same exact problem.



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
