From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdv/fbcon pending problems
Date: Thu, 26 Feb 2004 10:46:00 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077752759.22397.62.camel@gaston>
References: <Pine.LNX.4.44.0402252109030.24952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw8zI-00036C-EE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 16:02:48 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Aw8cu-0001uF-7G
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 15:39:40 -0800
In-Reply-To: <Pine.LNX.4.44.0402252109030.24952-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


>    I think this is a bad idea. This has been tried before. In the 
> opensource community there is no such a thing as a standard library. 

On the other hand, things like dbus are low-level and slowly getting
used by everyone... we also have the libc :)

>  ..../....

>     The kernel really needs to be the only state machine for the hardware. 
> Library developers will usually use the kernel standard interfaces. 

I don't fully agree. The kernel will do the actual HW banging, but
we want things like EDID overrides per monitor models, persistent
configuration saved to storage etc... all of that beeing pretty
nasty to do in the kernel.

> > Probably moving 
> > some of the higher level mode management out of the kernel driver
> > down to this userland library.
> 
> Bad idea.

I have mixed feeling on that. Keith Packard seem to prefer the library
approach. I don't know for sure what Linus prefers here. Currently, I
feel we are trying to do too much in the kernel, and that will become
increasingly painful to manage as we get multiple head & geometry stuff
getting in the picture.

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
