From: Richard Henderson <rth@twiddle.net>
Subject: Re: [Linux-fbdev-devel] [FB PATCH] cfbimgblt isn't 64-bit clean
Date: Tue, 31 Dec 2002 01:33:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021231013317.A14112@twiddle.net>
References: <Pine.LNX.4.44.0212290027590.14098-100000@phoenix.infradead.org> <1041173861.1013.9.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1041173861.1013.9.camel@localhost.localdomain>; from adaplas@pol.net on Sun, Dec 29, 2002 at 10:58:43PM +0800
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Dec 29, 2002 at 10:58:43PM +0800, Antonino Daplas wrote:
> Only fast_imageblit() should be affected.  color_imageblit() and
> slow_imageblit() will not be affected.  

Indeed.

> Or we can change fast_imageblit() to always access the framebuffer
> memory 32-bits at a time. The attached patch should fix this.

This is probably better than the wholesale conversion to
32-bits that I did.

For the most part I don't care anymore; I've implemented a
hardware accelerated version for depth==1 in tgafb.c now.  ;-)


r~
