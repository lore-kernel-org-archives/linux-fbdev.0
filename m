From: Greg KH <greg@kroah.com>
Subject: Re: fb_console_init fix.
Date: Fri, 20 Feb 2004 15:54:12 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040220235410.GB17771@kroah.com>
References: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org> <1077317816.9623.20.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuKcA-0001aW-2r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 16:03:26 -0800
Received: from mail.kroah.org ([65.200.24.183] helo=perch.kroah.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuKW3-00028g-0n
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 15:57:07 -0800
Content-Disposition: inline
In-Reply-To: <1077317816.9623.20.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Feb 21, 2004 at 09:56:56AM +1100, Benjamin Herrenschmidt wrote:
> 
> If we want the fb stuff to be initialized before other drivers, we
> probably want to create an init step before devices and after PCI
> probe, but is that really necessary ?
> 
> The core fbdev should just need a subsys initcall. fbcon could use
> that too and register a notifier. Then we could use the notifier
> mecanism to notify fbcon when fbdev's are added (from
> register_framebuffer) and get rid of all of the init crap

What's wrong with the current range of init call sections?  Can't that
work for fb devices today?

thanks,

greg k-h


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
