From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Sat, 11 Sep 2004 05:27:05 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409110527.05516.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com> <20040910175202.GA11054@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267901AbUIJV1j@vger.kernel.org>
In-Reply-To: <20040910175202.GA11054@havoc.gtf.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Saturday 11 September 2004 01:52, David Eger wrote:
> On Fri, Sep 10, 2004 at 01:28:57PM +0800, Antonino A. Daplas wrote:
> > On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> > > Recent changes upstream are breaking fbdev on pmacs.
> > >
> > > I haven't had time to go deep into that (but I suspect Linus sees it
> > > too on his own g5 unless he removed offb from his .config).
> > >
> > > From what I see, it seems that offb is kicking in by default, reserves
> > > the mmio regions, and then whatever chip driver loads can't access
> > > them.
> > >
> > > offb is supposed to be a "fallback" driver in case no fbdev is taking
> > > over, it should also be "forced" in with video=ofonly kernel command
> > > line. This logic has been broken.
>
> I dearly *hope* this is what I'm seeing with recent kernels, though I
> have my doubts....  What I *do* know is that with recent bk snapshots
> (post bk-1.2115) I have the following:  radeonfb seems to load, but when I
> try to load X, my y-resolution seems to be half of what it ought to be...

X-fbdev, or X + native radeon driver?  Do still get a framebuffer console?
Any other fb apps you have that's also broken?

Not sure why that happens. Note that the fbdev changes in the latest bk are
mostly driver specific changes and the initialization code cleanup which I'm
addressing at the moment.

Tony
