From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Date: 03 Dec 2002 17:22:35 +0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1038917280.1228.7.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2002-12-03 at 01:31, James Simmons wrote:
> 
> > Attached is a patch against 2.5.49 + James Simmons' latest fbdev.diff.
> > 
> > Added support for logo drawing.
> > Fixed vga16fb_imageblit() limitation of 8-pixel wide bitmap blitting
> > only.
> 
> Applied and tested :-=) The only weird thing is it drew the logo twice 
> when I don't have a SMP laptop. It works other than that. 
> 
Should be expected if the fbcon_show_logo() patch did not take.  I'm
resubmitting another patch in one of my replies.

> P.S
>   Things I like to get done for the vga16fb driver. 
> 
>   1) Its own read and write functions to fake a linear framebuffer.
Should be doable with fb_write and fb_read, but with mmap, the app still
needs to know the VGA format.

>   2) The ability to go back to vga text mode on close of /dev/fb. 
>      Yes fbdev/fbcon supports that now. 

I'll take a stab at writing VGA save/restore routines which hopefully is
generic enough to be used by various hardware.  No promises though, VGA
programming gives me a headache :(

Tony
