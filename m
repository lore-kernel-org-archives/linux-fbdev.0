From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Mon, 8 Nov 2004 14:25:04 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
 <200411090608.02759.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261281AbUKHW0K@vger.kernel.org>
In-Reply-To: <200411090608.02759.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Guido Guenther <agx@sigxcpu.org>



On Tue, 9 Nov 2004, Antonino A. Daplas wrote:
> 
> In big endian machines, the read*/write* accessors do a byteswap for an
> inherently little endian PCI bus.  However, rivafb puts the hardwire in big
> endian register access, thus the byteswap is not needed. So for 16- and
> 32-bit access, instead of read*/write*, use __raw_read*/__raw_write* for all
> archs.

Ok, applied with some further simplifications (use "void __iomem *" and 
suddenly those /2 and /4 just go away - also use __raw_xxxx for the 
single-byte versions to be consistent).

		Linus
