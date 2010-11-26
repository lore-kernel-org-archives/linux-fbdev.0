From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 26 Nov 2010 06:09:11 +0000
Subject: Re: [PATCH 1/2] fbdev: bf537-lq035: new Blackfin Sharp LQ035 framebuffer driver
Message-Id: <20101126060911.GB7893@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290591239-6089-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1290591239-6089-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Nov 25, 2010 at 04:21:48AM -0500, Mike Frysinger wrote:
> On Thursday, November 25, 2010 03:28:11 Paul Mundt wrote:
> > On Wed, Nov 24, 2010 at 04:33:58AM -0500, Mike Frysinger wrote:
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > > 
> > > For LCDs hooked up to BF537-STAMP boards.
> > > 
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > > ---
> > > note: these have been posted in the past, but before we got a fbdev
> > > 
> > > 	maintainer, so i'm just reposting them to hopefully get merged
> > 
> > On Wed, Nov 24, 2010 at 04:33:59AM -0500, Mike Frysinger wrote:
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > > 
> > > Driver for ADV7393 add-on card for multiple Blackfin boards.
> > > 
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > > ---
> > > note: these have been posted in the past, but before we got a fbdev
> > > 
> > > 	maintainer, so i'm just reposting them to hopefully get merged
> > 
> > While I don't really have any strong opinions about these drivers one way
> > or the other, a cursory glance shows that they end up sharing quite a bit
> > of code, along with the existing in-tree blackfin fb drivers. Have you
> > considered trying to abstract things a bit and moving things in to a
> > drivers/video/bfin or the like? Much of the DMA and PPI stuff looks like
> > it could be pretty easily broken out.
> 
> we have thought about it quite a bit, but havent quite gotten an answer that 
> worked without a lot of cruft

Ok. They're pretty limited in scope anyways, so there's not much harm in
adding them as-is. I've queued them up for .38. I would like to see some
effort to get the blackfin drivers tidied up and a bit more consolidated
in the future, before things get too far out of hand, however.
