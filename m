From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Date: 03 Dec 2002 15:47:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1038930464.11426.1.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org> 
	<1038917280.1228.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1038917280.1228.7.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2002-12-03 at 12:22, Antonino Daplas wrote:
> >   Things I like to get done for the vga16fb driver. 
> > 
> >   1) Its own read and write functions to fake a linear framebuffer.
> Should be doable with fb_write and fb_read, but with mmap, the app still
> needs to know the VGA format.

I question whether thats something that belongs anywhere near the
kernel. Ben Pfaff wrote a fine library for vga16 hackery (BOGL) and it
combines very nicely with the fb driver.

> >   2) The ability to go back to vga text mode on close of /dev/fb. 
> >      Yes fbdev/fbcon supports that now. 
> 
> I'll take a stab at writing VGA save/restore routines which hopefully is
> generic enough to be used by various hardware.  No promises though, VGA
> programming gives me a headache :(

You can pull the code out of the old svgalib library. Since its not
doing any card specific stuff the generic vga->text restore ought to do
the right thing.
