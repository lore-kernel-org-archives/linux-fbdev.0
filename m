From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
Date: Thu, 9 Jan 2003 21:25:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301092124350.5660-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301092153150.8130-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0301092153150.8130-100000@vervain.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>, davidm@redhat.com


> > This I have no problem with. I'm willing to accept this. As long as data 
> > from the console layer is not touched. As for loadtiles one thing I like 
> > to address is memory allocation. It probable is good idea to do things 
> > like place the tile data in buffers allocated by pci_alloc_consistent.
> > The other fear is it will only support so many tiles. 
> 
> I think it's best to let the driver allocate it. That way the driver can put it
> where it's best suited. pci_alloc_consistent() is meant for PCI only.

Sorry about the confusiing. I was meaning things like pci_alloc_consistent 
of course would be handled for each driver that needed it.
