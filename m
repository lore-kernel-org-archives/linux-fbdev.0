From: David Eger <eger@havoc.gtf.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 19:40:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040910234044.GA30180@havoc.gtf.org>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com> <20040910175202.GA11054@havoc.gtf.org> <200409110527.05516.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268029AbUIJXkr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200409110527.05516.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sat, Sep 11, 2004 at 05:27:05AM +0800, Antonino A. Daplas wrote:
> On Saturday 11 September 2004 01:52, David Eger wrote:
> > On Fri, Sep 10, 2004 at 01:28:57PM +0800, Antonino A. Daplas wrote:
> > > On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> > > > Recent changes upstream are breaking fbdev on pmacs.
> > > >
> > > > From what I see, it seems that offb is kicking in by default, reserves
> > > > the mmio regions, and then whatever chip driver loads can't access
> > > > them.
> > > >
> > > > offb is supposed to be a "fallback" driver in case no fbdev is taking
> > > > over, it should also be "forced" in with video=ofonly kernel command
> > > > line. This logic has been broken.
> >
> > I *hope* this is what I'm seeing with recent kernels, though I
> > have my doubts....  What I *do* know is that with recent bk snapshots
> > (post bk-1.2115) I have the following:  radeonfb seems to load, but when I
> > try to load X, my y-resolution seems to be half of what it ought to be...
> 
> X-fbdev, or X + native radeon driver?  Do still get a framebuffer console?
> Any other fb apps you have that's also broken?

Hold my tongue: BenH's latest patch (already in mainline) fixes it for me.

-David
