From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev and power management
Date: 09 Jul 2003 19:49:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1057772998.15932.55.camel@gaston>
References: <Pine.LNX.4.44.0307091844220.19058-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19aJ5y-0007HS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Jul 2003 10:51:10 -0700
In-Reply-To: <Pine.LNX.4.44.0307091844220.19058-100000@phoenix.infradead.org>
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
Cc: Russell King <rmk@arm.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-07-09 at 19:45, James Simmons wrote:
> > My concern is that there has been:
> > - 4 months of non-exposure of this work
> > - 4 months of making the current system work
> > - and putting it in will require a fair number of drivers to be 
> >   re-worked.
> > 
> > Apart from driver re-work and that the core interfaces are supposed to
> > be stable, what are the technical arguments against merging it, say,
> > today?
> 
> This is the reason I have waited. 

Those changes will only affect drivers, there is still need for
some mecanism to deal with fbcon. I'll send you a patch before the
end of the week hopefully. There may be a better way of doing it
than my patch by having fbcon be someway a child of the HW driver
in the device-tree, but it's a bit nasty right now, and my patch
adds a more generic way to notify "clients" of fbdev's (like fbcon)
of events at the low level that could be used for hotplug monitor
change notification or whatever...

Ben




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
