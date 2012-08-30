From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Aug 2012 06:27:00 +0000
Subject: Re: [PATCH 00/19] SH Mobile LCDC panel cleanup (including board code)
Message-Id: <20120830062700.GA1370@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345122054-16013-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1345122054-16013-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Aug 29, 2012 at 04:58:10PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 29 August 2012 15:07:49 Simon Horman wrote:
> > On Mon, Aug 27, 2012 at 05:35:46PM +0200, Laurent Pinchart wrote:
> > > On Monday 27 August 2012 17:54:52 Simon Horman wrote:
> > > > On Thu, Aug 16, 2012 at 03:00:35PM +0200, Laurent Pinchart wrote:
> > > > > Hi everybody,
> > > > > 
> > > > > As part of a general panel API implementation (more on that a bit
> > > > > later), I've cleaned up panel support in the LCDC driver and in the
> > > > > related board code. The result is 19 patches independent of the
> > > > > generic panel API that I would like to get reviewed by the respective
> > > > > board maintainers.
> > > > 
> > > > Hi Paul,
> > > > 
> > > > I'm happy for you to take all of this, including the mach-shmobile
> > > > portions through your tree if that works for you.
> > > 
> > > I usually push the LCDC patches through the fbdev tree. I'm fine with both
> > > options though.
> > 
> > I'm happy for you to handle things in your normal way.
> > 
> > I guess that means that once the LCDC changes are in the fbdev tree
> > Paul should take the linux-sh changes and I should take the shmobile
> > changes, is that correct?
> 
> To avoid bisection breakages all the patches should go through the same tree. 
> This will of course increase the chances of merge conflicts. Would you rather 
> take them all through linux-sh ?

I'm happy for them to go through the fbdev tree.

Feel free to ad my Ack.

Paul has indicated a similar sentiment in another email in this thread.
