From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdv/fbcon pending problems
Date: Thu, 26 Feb 2004 00:20:20 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402260014130.24952-100000@phoenix.infradead.org>
References: <1077752759.22397.62.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw9PS-0001Ea-1J
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 16:29:50 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aw932-0005Lb-2P
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 16:06:40 -0800
In-Reply-To: <1077752759.22397.62.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> >    I think this is a bad idea. This has been tried before. In the 
> > opensource community there is no such a thing as a standard library. 
> 
> On the other hand, things like dbus are low-level and slowly getting
> used by everyone... we also have the libc :)

Well now that we have one input api that can happen. Of course with 
graphics its much more diverse with what you can do. That is one of the 
reasons for so many graphics libraries. It would be really hard to write
a one size fits all library when it comes to graphics.

> >     The kernel really needs to be the only state machine for the hardware. 
> > Library developers will usually use the kernel standard interfaces. 
> 
> I don't fully agree. The kernel will do the actual HW banging, but
> we want things like EDID overrides per monitor models, persistent
> configuration saved to storage etc... all of that beeing pretty
> nasty to do in the kernel.

By state machine I mean the physical hardware state. If it's hardware 
access then it should be in the kernel. Note I'm refering to mode setting 
not acceleration. Now EDID overrides per monitor model and saving the 
state to disk is different. That should be userland. 

> I have mixed feeling on that. Keith Packard seem to prefer the library
> approach. I don't know for sure what Linus prefers here. Currently, I
> feel we are trying to do too much in the kernel, and that will become
> increasingly painful to manage as we get multiple head & geometry stuff
> getting in the picture.

I think we are fine for whats in the kernel. As for multiple head and 
geometry stuff its not that hard if done right. I have been using 
multi-head systems for years. I have multip desktop systems for years!!!





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
