From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: fix fillrect for 24bpp modes
Date: Fri, 17 Apr 2009 11:50:48 -0700
Message-ID: <20090417115048.0c5ca35d.akpm@linux-foundation.org>
References: <20090413170954.GA8403@tria>
	<20090417183617.ed7553cd.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761616AbZDQSyi@vger.kernel.org>
In-Reply-To: <20090417183617.ed7553cd.krzysztof.h1@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 17 Apr 2009 18:36:17 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> On Mon, 13 Apr 2009 19:09:54 +0200
> Michal Januszewski <spock@gentoo.org> wrote:
> 
> ...
>
> The r is simply dst_idx / bits. Most compilers will optimize it away into 
> a simple shift because the bits has only one bit set (it is number of bits in a long variable, ie. 32 or 64).
> 
> > +		pat = pat << ((left*r) % bpp) | pat >> ((right*r) % bpp);
> >  
> 
> If the r = (dst_idx / bits) it is number of long words. The shift by ((left*r) % bpp) does
> not make much sense (try left = 3 and r = 24 words - it is always zero but should be 3). 
> It is even worse if a line is padded so line's length modulo bpp is not 
> zero it does not work. A colorful pattern is produced  after the "mtest" text.
> 
> A dst_idx offset is not taken into account (it could be non-zero only for depths < 8 bits).
> 

OK, thanks for checking.

Michael, I'll await a version 2 on this patch.  It looks like something
we want in 2.6.30.
