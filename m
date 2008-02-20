From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
 endianness
Date: Wed, 20 Feb 2008 11:56:35 +1100
Message-ID: <18363.31427.989835.105966@cargo.ozlabs.ibm.com>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
	<47BA162C.5000807@anagramm.de>
	<1203381353.6740.59.camel@pasglop>
	<47BABD3A.7010102@anagramm.de>
	<20080219040530.7b1d115d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760886AbYBTA5r@vger.kernel.org>
In-Reply-To: <20080219040530.7b1d115d.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Clemens Koller <clemens.koller@anagramm.de>, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, Anton Vorontsov <avorontsov@ru.mvista.com>

Andrew Morton writes:

> Bizarrely, the original author of the patch (Anton) has fallen off the cc. 
> Could whoever did that please thwap himself?
> 
> Anyway, my head is now officially spinning.  Did anyone actually have a
> reason why we shouldn't proceed with Anton's patch?

I was wondering if it would be sufficient to provide alternative
versions of fb_readl, fb_writel etc. that do byte-swapping.  That
would mean that all framebuffers would have to have the same
endianness, but that would suffice for embedded systems such as
Anton's and would end up a lot simpler IMHO.

Paul.
