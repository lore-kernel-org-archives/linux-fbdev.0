From: "Etheridge, Darren" <detheridge@ti.com>
Date: Fri, 30 Aug 2013 15:25:58 +0000
Subject: RE: [PATCH 0/4] video: da8xx-fb: numerous bugfixes
Message-Id: <1A80A2FD7F34484786E5DF71F3968B6940F89ADD@DLEE10.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377294773-25678-1-git-send-email-detheridge@ti.com>
In-Reply-To: <1377294773-25678-1-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> From: Valkeinen, Tomi
> Sent: Friday, August 30, 2013 6:53 AM
> >
> > Darren Etheridge (4):
> >   video: da8xx-fb fixing incorrect porch mappings
> >   video: da8xx-fb: fixing timing off by one errors
> >   video: da8xx-fb: support lcdc v2 timing register expansion
> >   video: da8xx-fb: fix the polarities of the hsync/vsync pulse
> >
> >  drivers/video/da8xx-fb.c |   35 +++++++++++++++++++++++++----------
> >  1 files changed, 25 insertions(+), 10 deletions(-)
> >
> 
> These look good to me, queuing for 3.12.
> 
> There was a space missing between 'if' and '(' in one of the patches, I fixed
> that.
> 
>  Tomi
> 
Tomi,

Thank you.

Darren

