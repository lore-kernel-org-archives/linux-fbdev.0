From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: RFC: disallow modular framebuffers
Date: Tue, 1 Mar 2005 08:59:59 -0800
Message-ID: <200503010859.59487.jbarnes@engr.sgi.com>
References: <20050301024118.GF4021@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050301024118.GF4021@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Monday, February 28, 2005 6:41 pm, Adrian Bunk wrote:
> Hi,
>
> while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
>
> Do modular framebuffers really make sense?
>
> OK, distributions like to make everything modular, but all the
> framebuffer drivers I've looked at parse driver specific options in
> their *_setup function only in the non-modular case.

That sounds like it should be fixed.

> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?

I'd like to see them stay modular if it's not too much trouble.  It makes 
things easier to debug and test, for one thing.  I also think setups with 
multiple framebuffers but w/o consoles on any of them are somewhat common, 
meaning the fb drivers can be easily loaded and unloaded if the fb devices 
aren't in use.

Jesse
