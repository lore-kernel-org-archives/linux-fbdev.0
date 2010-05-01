From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 01 May 2010 12:55:00 +0000
Subject: Re: [PATCH 2/2] sh: make interrupt resource optional in SH framebuffer driver
Message-Id: <20100501125500.GA29020@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1004301805371.4055@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004301805371.4055@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, May 01, 2010 at 09:43:14PM +0900, Magnus Damm wrote:
> On Sat, May 1, 2010 at 9:15 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Sat, 1 May 2010, Magnus Damm wrote:
> >> Why? Doesn't the LCDC hardware block always come with an IRQ line?
> >
> > Because on AP4 intcs is not supported in the mainline yet. And because we
> > can?;) Some code paths in the driver already care for the case, when no
> > IRQ is configured, so, we can just use it.
> 
> Patches for INTCS have been posted for SH-Mobile ARM G3/G4/AP4. They
> will be part of the upcoming .35 release. The merge order dependencies
> are a bit tricky, so please apply whatever needed locally for now.
> 
> I don't agree with you that allowing people to not hook up an IRQ is a
> good thing. The driver already has too many different modes of
> operation, adding another one will just make it more error prone.
> Trying to reduce the number of special cases is the way forward, not
> making yet another one...
> 
I tend to agree. Adding functionality for functionality's sake really
only creates an undue maintenance burden. If there are LCDC blocks that
don't have IRQ lines, then of course we will have to do something like
this. If we're just waiting on patches to get upstream in order to enable
the IRQs then I don't really see the point -- there are out of tree
patches we're waiting on in both cases, so this can only really be
considered a stop-gap until the intcs patches are merged anyways,
especially since we'll still want to enable the IRQs on AP4 once those
patches are merged.
