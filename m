From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3: FBDEV: VGA State Save/Restore
	module
Date: 06 Dec 2002 05:47:06 +0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039135574.1032.17.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0212051729230.31967-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212051729230.31967-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2002-12-05 at 22:31, James Simmons wrote:
> 
> > Limitations:
> > 1.  Restoring the VGA state from high-resolution graphics mode may
> > result in a corrupt display which can be corrected by switching
> > consoles.  May need a screen redraw at this point.  Restoring from VGA
> > graphics mode to text mode and vice versa is okay.
> > 
> > 2. Assumes some things about the hardware which is not universally
> > correct:  VGA memory base is at 0xA0000, memory size is 64KB, the
> > hardware palette is readable, etc. 
> > 
> > Any comments welcome.
> 
> One thing I like to suggest. I like to move the vga code in fb.h to vga.h. 
> Alot of fbdev devices don't have a VGA core. 
> 
> 

Only the structure definition of fb_vgastate is in fb.h.  For drivers
without a vga core, they'll just won't link to it and it won't be
compiled.  Plus, vga.h is not a common header (not located in
include/asm or include/linux) and it contains a lot of declarations and
definitions which are irrelevant to most drivers or are already
duplicated.  This will be messier, I think.  

Maybe we can just enclose it in a macro, something like:

#ifdef FBDEV_HAS_VGACORE
...
#endif

Tony
