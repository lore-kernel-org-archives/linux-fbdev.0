From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 18 May 2012 08:57:53 +0000
Subject: Re: [PULL for v3.4] SH Mobile LCDC fix
Message-Id: <2559608.rGoHhuJBVh@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <26224047.6PR9YZjWoc@avalon>
In-Reply-To: <26224047.6PR9YZjWoc@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Friday 18 May 2012 01:39:19 Florian Tobias Schandinat wrote:
> On 05/17/2012 10:23 PM, Laurent Pinchart wrote:
> > Hi Florian,
> > 
> > Is it still possible for the following patch to go to v3.4 ? I've only
> > realized now that MERAM support was broken in some use cases (one of them
> > being fbcon) due to a v3.4-rc regression - thanks to Guennadi Liakhovetski
> > for reporting this.
> 
> Umm, I don't like last minute stuff, but this is important enough. BUT...

I don't like it either, I'll add fbcon to my test cases for the future.

> > If this is too late for v3.4 please let me know and I'll CC stable on the
> > patch and resend a pull request for v3.5.
> > 
> > The following changes since commit 
5e7b911f9a3e582635801675b7fe935b16cd4af5:
> >   drivers/video: fsl-diu-fb: don't initialize the THRESHOLDS registers
> > 
> > (2012-05-13 13:08:56 +0000)
> 
> ...how am I supposed to merge this? It's based on top of all the stuff
> that I plan to ask Linus to pull during the merge window and AFAIK there
> is no way to merge only upper parts of branches. I could cherry-pick it
> but that wouldn't look like a merge or a patch I applied.

Oops, my bad, sorry.

> As this is only a single patch and not much time left, I'd suggest you
> send it directly to Linus (as a patch) with my Ack added to it. Oh and
> make sure to mention that this fixes a regression.

Sure, I'll do that.

Thank you.

-- 
Regards,

Laurent Pinchart

