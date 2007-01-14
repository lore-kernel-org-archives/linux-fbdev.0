From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Linux-fbdev-devel] How to mmap a shadow framebuffer in virtual
 memory
Date: Sun, 14 Jan 2007 12:13:20 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701141211030.18479@pademelon.sonytel.be>
References: <45A97832.2040206@develer.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751238AbXANLNY@vger.kernel.org>
In-Reply-To: <45A97832.2040206@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernardo Innocenti <bernie@develer.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: lkml <linux-kernel@vger.kernel.org>, aleph <aleph@develer.com>

On Sun, 14 Jan 2007, Bernardo Innocenti wrote:
> This is driving me crazy.  I wrote this custom fb driver for an
> organic LED display for an embedded ARM system.
> 
> The display is connected trough an I2C bus, therefore the display
> buffer is not memory mapped.
> 
> Anyway, I want to support mmap() and my driver allocates shadow
> buffer with __get_free_pages() which gets periodically copied
> to the display by a thread. This is unlike most fb drivers which
> just point smem_start to the phisical address of their framebuffer.
> 
> >From user space, opening /dev/fb0 and writing to it works just
> fine.  mmap()'ing the file and writing to it does not have any
> effect.
> 
> Writing the phisical address in smem_start and letting the
> fbgen code do the rest didn't seem to work, so I reimplemented
> the fb_mmap hook.
> 
> I don't feel confident with the Linux VM, so I tried several
> strategies to allocate the shadow buffer, including vmalloc()
> and kmalloc().
> 
> The virtual framebuffer (vfb) also uses vmalloc() but crashes
> calling processes because it confuses physical and virtual
> addresses, or so it seems.
> 
> Maybe it's just my kernel or my platform... does anybody use
> a similar technique?  Can anybody point me to known-good code
> that approximates my needs?

It's known to work for the PS3 frame buffer device driver, which copies the
virtual frame buffer to the GPU on every vsync. Check out ps3fb_mmap() in
http://www.kernel.org/git/?p=linux/kernel/git/geoff/ps3-linux.git;a=blob_plain;f=drivers/video/ps3fb.c;hb=HEAD

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
