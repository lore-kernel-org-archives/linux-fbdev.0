From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev and power management
Date: 09 Jul 2003 13:35:58 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1057750557.514.22.camel@gaston>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19aDFV-0004bx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Jul 2003 04:36:37 -0700
In-Reply-To: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> No patches at this time. I need to learn the new power management code. 
> Where are the docs for them ? 

The PM code in radeonfb is probably only useful for Mac laptops where
we have to manually put the chip in D2 state. I don't think x86 laptops
use D2...

Note that I have a patch adding some basic PM support to fbdev in 2.5
that I need to send you for review. The PM is always initiated by the
low level driver which gets notified of PM events by its parent bus,
what I added is a way for the driver to "broadcast" that to clients
like fbcon so fbcon can stop touching the framebuffer while the chip
is potentially off, and can restore the display on wakeup.

I'll send that to you asap. 

Note: The Power Management isn't well implemented in 2.5 yet. The
infrastructure is mostly there, but the driver side semantics are
still wrong. Patrick Mochel has a new implementation that is much
better, but he didn't merge it upstream yet. I expect this will
happen around Kernel Summit / OLS.

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
