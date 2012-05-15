From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 15 May 2012 19:19:05 +0000
Subject: Re: [PULL for v3.5] SH Mobile LCDC overlay support
Message-Id: <1542928.AI4txoYCM9@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5022250.LOHRC1DPLO@avalon>
In-Reply-To: <5022250.LOHRC1DPLO@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Sunday 13 May 2012 20:36:29 Florian Tobias Schandinat wrote:
> On 04/24/2012 11:31 AM, Laurent Pinchart wrote:
> > Hi Florian,
> > 
> > Could you please pull the following patches that add overlay support for
> > the SH Mobile LCDC ? They have been posted for review as part of a bigger
> > series some time ago.
> 
> Well, besides that I dislike everyone inventing his/her own overlay API
> and just not having time to propose something that fits everyone your
> patch looks mostly okay.

This is a topic that we started to discuss at the ELC a couple of months ago. 
My goal was to come up with a single API shared between DRM/KMS, FB and V4L2 
to handle graphics pipeline configuration. It quickly turned out that there 
was not enough shared interest between DRM and V4L2 developers to make this 
happen. Should we resume the discussion for FB, or would you rather want a 
separate FB-specific API ?

> Two things:
> 
> "That's fine, but you need a Documentation/ABI entry for any new sysfs
> file you create." [Greg K-H]

Thank you for reminding me.

> So as far as I understand Gregs statement and your code correct you
> should add such thing.
> 
> I'm not convinced that you don't leak resources. Is the memory you
> allocate with dma_alloc_coherent for the overlays really freed after
> normal use and in error paths?

I'm not sure where the cleanup part of the patch went to, but definitely not 
in that branch :-/ I'll fix that and resubmit.

-- 
Best regards,

Laurent Pinchart

