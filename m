From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [Linux-fbdev-devel] [PATCH][resend] drivers/video/kyro/fbdev.c
 ignoring return value of copy_*_user
Date: Fri, 4 Mar 2005 21:27:15 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503042126020.2794@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.62.0503041514110.2794@dragon.hygekrogen.localhost>
 <200503050132.10895.adaplas@hotpop.com>
Mime-Version: 1.0
In-Reply-To: <200503050132.10895.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Paul Mundt <lethal@chaoticdreams.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, 5 Mar 2005, Antonino A. Daplas wrote:

> On Friday 04 March 2005 22:26, Jesper Juhl wrote:
> > Hi,
> >
> > 2.6.11 still contain these warnings :
> >
> > drivers/video/kyro/fbdev.c:597: warning: ignoring return value of
> > `copy_from_user', declared with attribute warn_unused_result
> > drivers/video/kyro/fbdev.c:607: warning: ignoring return value of
> > `copy_from_user', declared with attribute warn_unused_result
> > drivers/video/kyro/fbdev.c:628: warning: ignoring return value of
> > `copy_to_user', declared with attribute warn_unused_result
> > drivers/video/kyro/fbdev.c:631: warning: ignoring return value of
> > `copy_to_user', declared with attribute warn_unused_result
> > drivers/video/kyro/fbdev.c:634: warning: ignoring return value of
> > `copy_to_user', declared with attribute warn_unused_result
> >
> > Here's a patch that has been send before but obviously didn't make it in.
> > re-diff'ed against 2.6.11
> 
> Your patch is already in the mm tree along with the other fbdev patches.
> 
Yeah, I'm an idiot, I had forgotten about that. Sorry for the noice.

-- 
Jesper
