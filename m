From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Tue, 09 Nov 2004 08:52:01 +1100
Message-ID: <1099950722.10262.166.camel@gaston>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261255AbUKHVz3@vger.kernel.org>
In-Reply-To: <200411081706.55261.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

On Mon, 2004-11-08 at 17:06 +0800, Antonino A. Daplas wrote:

> 
> How about this patch?  This is almost the original macro in riva_hw.h,
> with the __force annotation.

I don't like it neither. It lacks barriers. the rivafb driver
notoriously lacks barriers, except in a few places where it was so bad
that it actually broke all the time, where we added some. This
originates from the X "nv" driver written by Mark Vojkovich who didn't
want to hear about barriers for perfs reasons I think.

Ben.
