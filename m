From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3: FBDEV: VGA State Save/Restore
 module
Date: Thu, 5 Dec 2002 17:31:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212051729230.31967-100000@phoenix.infradead.org>
References: <1039017469.1013.30.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1039017469.1013.30.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Limitations:
> 1.  Restoring the VGA state from high-resolution graphics mode may
> result in a corrupt display which can be corrected by switching
> consoles.  May need a screen redraw at this point.  Restoring from VGA
> graphics mode to text mode and vice versa is okay.
> 
> 2. Assumes some things about the hardware which is not universally
> correct:  VGA memory base is at 0xA0000, memory size is 64KB, the
> hardware palette is readable, etc. 
> 
> Any comments welcome.

One thing I like to suggest. I like to move the vga code in fb.h to vga.h. 
Alot of fbdev devices don't have a VGA core. 
