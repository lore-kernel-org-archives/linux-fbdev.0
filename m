From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Mon, 8 Nov 2004 12:13:01 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <200411081706.55261.adaplas@hotpop.com> <Pine.LNX.4.58.0411080719460.24286@ppc970.osdl.org>
 <200411090402.22696.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261212AbUKHUNd@vger.kernel.org>
In-Reply-To: <200411090402.22696.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>



On Tue, 9 Nov 2004, Antonino A. Daplas wrote:
> 
> In big endian machines, the read*/write* accessors do a byteswap for an
> inherently little endian PCI bus.  However, rivafb puts the hardwire in big
> endian register access, thus the byteswap is not needed. So, instead of
> read*/write*, use __raw_read*/__raw_write*.

This fix should make the #ifdef CONFIG_PCC entirely superfluous afaik. 

The thing is, once riva does its HW accesses right, the special cases just 
go away. There's a reason we have abstractions.. 

Does anybody have the hardware to test with?

		Linus
