From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Linux-fbdev-devel] fbdev and power management
Date: Wed, 9 Jul 2003 15:10:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030709151032.A22612@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org> <1057750557.514.22.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1057750557.514.22.camel@gaston>; from benh@kernel.crashing.org on Wed, Jul 09, 2003 at 01:35:58PM +0200
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Jul 09, 2003 at 01:35:58PM +0200, Benjamin Herrenschmidt wrote:
> Note: The Power Management isn't well implemented in 2.5 yet. The
> infrastructure is mostly there, but the driver side semantics are
> still wrong. Patrick Mochel has a new implementation that is much
> better, but he didn't merge it upstream yet. I expect this will
> happen around Kernel Summit / OLS.

I'm slightly concerned by this.  There are a growing amount of drivers
in 2.5 which are being made to work with the existing power management
system.  This "new" system seems to have been hanging around for about
4 months now with no visible further work, presumably so that a paper
can be presented before its release.

My concern is that there has been:
- 4 months of non-exposure of this work
- 4 months of making the current system work
- and putting it in will require a fair number of drivers to be 
  re-worked.

Apart from driver re-work and that the core interfaces are supposed to
be stable, what are the technical arguments against merging it, say,
today?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
