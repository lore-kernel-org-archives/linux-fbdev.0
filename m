From: James Simmons <jsimmons@infradead.org>
Subject: Re: Using UML to work on framebuffers
Date: Wed, 15 Jan 2003 00:35:29 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301150035100.23774-100000@phoenix.infradead.org>
References: <20030115003127.97146.qmail@web14907.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YbXI-0004s9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 16:36:04 -0800
In-Reply-To: <20030115003127.97146.qmail@web14907.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


Yes very much so. It woudl make my life easier.

> I have a patch for 2.5 that allows some framebuffers
> drivers (non-dma ones) to run unmodified on UML. I'm
> still working on DMA and IRQ support.
> 
> UML - user mode linux. UML runs the Linux kernel as a
> process. For example my PC is booted on 2.4 and the
> UML runs 2.5.
> 
> The advantage to this is that you can use gdb/ddd to
> debug the fb driver code. It's actually kind of neat.
> I use one gdb inside of UML to control the fbtest app
> and another gdb to step the code inside of the fb
> driver. 
> 
> Is anyone interested in trying this out? 
> 
> You need two video cards in your machine one for X and
> one for the target framebuffer.  I am using AGP for X
> and targeting a PCI Rage128.
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: Take your first step towards giving 
> your online business a competitive advantage. Test-drive a Thawte SSL 
> certificate - our easy online guide will show you how. Click here to get 
> started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
