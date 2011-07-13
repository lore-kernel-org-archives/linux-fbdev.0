From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:21:13 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Turn dot clock on before resuming from runtime PM
Message-Id: <20110713082113.GH13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 12, 2011 at 11:37:57AM +0200, Laurent Pinchart wrote:
> On Tuesday 12 July 2011 11:33:09 Guennadi Liakhovetski wrote:
> > On Mon, 11 Jul 2011, Laurent Pinchart wrote:
> > > Resuming from runtime PM restores all LCDC registers. If the dot clock
> > > is off at that time display panning information will be corrupted.
> > > 
> > > Turn the dot clock on before resuming from runtime PM. Similarly,
> > > turn the clock off after suspending the LCDC.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> > 
> > (testing would have been a bit easier, if prerequisites had been specified
> > in the patch;))
> 
> They're specified a couple of lines down ;-)
> 
> > Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Thank you.
> 
Folded in on top of the rest of the MERAM changes, thanks.
