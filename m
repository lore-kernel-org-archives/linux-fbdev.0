From: David Eger <eger@havoc.gtf.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 13:52:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040910175202.GA11054@havoc.gtf.org>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267620AbUIJRwJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200409101328.57431.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, Sep 10, 2004 at 01:28:57PM +0800, Antonino A. Daplas wrote:
> On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> > Recent changes upstream are breaking fbdev on pmacs.
> >
> > I haven't had time to go deep into that (but I suspect Linus sees it
> > too on his own g5 unless he removed offb from his .config).
> >
> > From what I see, it seems that offb is kicking in by default, reserves
> > the mmio regions, and then whatever chip driver loads can't access them.
> >
> > offb is supposed to be a "fallback" driver in case no fbdev is taking
> > over, it should also be "forced" in with video=ofonly kernel command
> > line. This logic has been broken.

I dearly *hope* this is what I'm seeing with recent kernels, though I
have my doubts....  What I *do* know is that with recent bk snapshots
(post bk-1.2115) I have the following:  radeonfb seems to load, but when I
try to load X, my y-resolution seems to be half of what it ought to be...
The only code I see poking around at fb is yours...  *shrug*

-Happy to try new patches David
