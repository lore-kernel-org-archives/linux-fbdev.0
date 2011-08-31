From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 31 Aug 2011 11:01:32 +0000
Subject: Re: [PULL] SH mobile LCDC cleanups and fixes
Message-Id: <201108311301.32869.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108191044.52130.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108191044.52130.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Tuesday 30 August 2011 22:41:39 Florian Tobias Schandinat wrote:
> On 08/19/2011 08:44 AM, Laurent Pinchart wrote:
> > Hi Florian,
> > 
> > Here are the latest SH mobile LCDC and MERAM cleanups and fixes based on
> > top of v3.1-rc2. All the patches have been posted to the list. I've
> > incorporated acked-by and tested-by lines when available, but most of
> > the patches received no comment.
> > 
> > The following changes since commit 
93ee7a9340d64f20295aacc3fb6a22b759323280:
> >   Linux 3.1-rc2 (2011-08-14 15:09:08 -0700)
> > 
> > are available in the git repository at:
> >   git://linuxtv.org/pinchartl/fbdev.git sh-mobile-lcdc
> 
> Pulled, thanks.

Thanks you.

Do you plan to pull the "sh_mobile_lcdc: Support format changes at runtime" 
patch set as well ? I've just submitted a v2 that includes an additional patch 
to fix a MERAM issue.

> It looks good to me, as far as I can tell.
> Just the first commits that were not your own ones should have had more
> verbose commit messages and I think they should have had your Signed-off
> as you received them via e-mail?

I've just picked them from the list, as I needed them to build the other 
patches.

> And on another note:
> Would you mind adding yourself as maintainer of drivers/video/sh_mobile_*
> in MAINTAINERS? I can't find any entry for it yet and having me as primary
> source for review for a driver I don't know is a bad idea, at least if
> there are people that know it better.

I don't know the driver *that* well :-) I'm not sure how long I will work on 
that driver, so maybe it would be a better idea to list Magnus as the 
maintainer. Magnus, what's your opinion ?

-- 
Regards,

Laurent Pinchart
