From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Date: Mon, 22 Nov 2004 00:21:36 +0000
Message-ID: <20041122002136.A30668@flint.arm.linux.org.uk>
References: <20041121153614.GR2829@stusta.de> <20041121204752.A23300@flint.arm.linux.org.uk> <20041121205613.GA12634@infradead.org> <20041122000413.A27572@flint.arm.linux.org.uk> <20041122001051.GA3007@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261869AbUKVAXh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041122001051.GA3007@stusta.de>; from bunk@stusta.de on Mon, Nov 22, 2004 at 01:10:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Mon, Nov 22, 2004 at 01:10:51AM +0100, Adrian Bunk wrote:
> Where is this video capture code, and why can't it be included in the 
> kernel?

A version of it was in the Netwinder.Org CVS tree, but since the
machine which used to provide that domain has been impounded by
the provider (because of problems with a third party providing the
hosting for it), that source vanished.

That leaves me as the sole provider of the source code, and the
code has always been in the "experimental but useful" stage.  The
capture code is something which doesn't meet my standards for
mainline kernel inclusion.

However, since the capture is part of the PCI VGA device, the VGA
driver needs to export some hooks so that the capture driver can
safely talk to the VGA chip.  That is what these are for, and, since
they have to be part of the VGA driver itself, I see no reason why
I can't include them as part of the driver that _I_ maintain.

Of course, if it is preferred to put crap code into the kernel, then
that I shall do.  That's contary to what I believe should be merged,
and I'm sure then Christoph will whinge about crap code being included.
So I suspect I can't win either way.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
