From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fb_console_init fix.
Date: Sat, 21 Feb 2004 11:16:47 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077322606.10864.1.camel@gaston>
References: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
	 <1077317816.9623.20.camel@gaston>  <20040220235410.GB17771@kroah.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuL0l-0007Za-1P
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 16:28:51 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AuKub-0006Pt-Uv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 16:22:30 -0800
In-Reply-To: <20040220235410.GB17771@kroah.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Greg KH <greg@kroah.com>
Cc: James Simmons <jsimmons@infradead.org>, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2004-02-21 at 10:54, Greg KH wrote:

> What's wrong with the current range of init call sections?  Can't that
> work for fb devices today?

We can probably work with those. I just don't fell like changing that
part of fbdev right now. More important fixes to get in first (and
there's a shitload of crap related to calling the setup functions in
fbdev's that need fixing too if/when we change that init stuff).

My idea about adding an initcall level was for pure convenience, but
may be wrong. It's handy to have the console inited before the rest
that's all ;) We can leave that out for now, maybe just linking
drivers/video before the rest is enough to get that anyway.

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
