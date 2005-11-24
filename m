From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console rotation problems
Date: Thu, 24 Nov 2005 14:29:14 +0800
Message-ID: <43855DBA.1050302@gmail.com>
References: <1132793150.26560.357.camel@gaston>	 <1132793556.26560.361.camel@gaston>  <1132796831.26560.392.camel@gaston> <1132801542.26560.402.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161018AbVKXGaT@vger.kernel.org>
In-Reply-To: <1132801542.26560.402.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

Benjamin Herrenschmidt wrote:
> Remove bogus usage of test/set_bit() from fbcon rotation code and just
> manipulate the bits directly. This fixes an oops on powerpc among others
> and should be faster. Seems to work fine on the G5 here.

Thanks, I reached a point when my head became muddled with bit 
manipulations, so I used arch-specific bitops but complete forgot
that they were atomic :-)

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Antonino Daplas <adaplas@pol.net>

> ---
> 
> And here is the fix. Tony, did I miss something ?

Works in little-endian too, so thank you very much. cfbimageblit may
also suffer from this same mistake (mine).  So can you test with
12x22 fonts at rotate 1 or 3 with acceleration off?

This particular line in cfbimgblit.c:slow_imageblit() is definitely
questionable.

- color = (*s & 1 << (BIT_NR(l))) ? fgcolor : bgcolor;
+ color = (*s & (1 << l)) ? fgcolor : bgcolor;


Tony
