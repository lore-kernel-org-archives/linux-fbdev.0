From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Date: 04 Mar 2003 05:32:33 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1046727094.1279.27.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
	<20030220150201.GD13507@codemonkey.org.uk>
	<20030220182941.GK14445@vana.vc.cvut.cz>
	<1045787031.2051.9.camel@localhost.localdomain> 
	<20030303203500.GA2916@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030303203500.GA2916@vana.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-04 at 04:35, Petr Vandrovec wrote:

>   My main concern now is 12x22 font... Accelerator setup
> is so costly for each separate painted character that for 8bpp 
> accelerated version is even slower than unaccelerated one :-(
> (and almost twice as slow when compared with 2.4.x).

I submitted a patch to James, which he already applied to his tree, that
addresses this problem.  It conglomerates the series of bitmaps into 1,
so only one fb_imageblit is necessary.  It should give faster painting
than the original 2.5.x code, hopefully faster than 2.4.x code, but
slower than 8x16 painting because of the additional packing.

> 
>   And one (or two...) generic questions: why is not pseudo_palette
> u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?

Yes, all drivers should treat the pseudo_palette as u32* anyway, so why
not change pseudo-palette from void* to u32*?

> And why we do not fill this pseudo_palette with
> i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> pseudocolor? This allowed me to remove couple of switches and tests
> from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> but I did not changed these two in my benchmarks below).

I also agree for a different reason.  Cards with unconventional formats
(such as monochrome at 8 bpp - 0 for black , 0xff for white) will not
work with the current code.

Tony  
