From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 24 Aug 2011 14:15:46 +0000
Subject: Re: [PULL] Use display information in info not in var for panning
Message-Id: <4E550792.1070907@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108191038.43286.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108191038.43286.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 08/19/2011 08:38 AM, Laurent Pinchart wrote:
> Hi Florian (or should I call you Florian Tobias ?),

Florian is good. I just use my full name as an indication of authenticity.

> Here is the latest version of the pan patches based on top of v3.1-rc2. Apart 
> from being rebased, they're identical to the v3 version posted to the linux-
> fbdev mailing list.

Pulled this one.

JFYI: I want to have a deeper look at the other pull request you sent and
therefore I will need some time for it.


Thanks,

Florian Tobias Schandinat


> The following changes since commit 93ee7a9340d64f20295aacc3fb6a22b759323280:
> 
>   Linux 3.1-rc2 (2011-08-14 15:09:08 -0700)
> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git pan-fixes
> 
> Laurent Pinchart (29):
>       68328fb: use display information in info not in var for panning
>       acornfb: Dont BUG() on invalid pan parameters
>       acornfb: use display information in info not in var for panning
>       arkfb: use display information in info not in var for panning
>       atmel_lcdfb: use display information in info not in var for panning
>       radeonfb: use display information in info not in var for panning
>       fbdev: da8xx: use display information in info not in var for panning
>       fbdev: unicore32: use display information in info not in var for panning
>       g364fb: use display information in info not in var for panning
>       gxt4500: use display information in info not in var for panning
>       hgafb: use display information in info not in var for panning
>       imsttfb: use display information in info not in var for panning
>       intelfb: use display information in info not in var for panning
>       mb862xxfb: use display information in info not in var for panning
>       mx3fb: use display information in info not in var for panning
>       neofb: use display information in info not in var for panning
>       pm2fb: use display information in info not in var for panning
>       pm3fb: use display information in info not in var for panning
>       s3c-fb: use display information in info not in var for panning
>       s3fb: use display information in info not in var for panning
>       savagefb: use display information in info not in var for panning
>       sisfb: use display information in info not in var for panning
>       sm501fb: use display information in info not in var for panning
>       tridentfb: use display information in info not in var for panning
>       vfb: use display information in info not in var for panning
>       vga16fb: use display information in info not in var for panning
>       vt8500lcdfb: use display information in info not in var for panning
>       vt8623fb: use display information in info not in var for panning
>       staging: xgifb: use display information in info not in var for panning
> 
>  drivers/staging/xgifb/XGI_main_26.c    |   22 ++++++----------------
>  drivers/video/68328fb.c                |    4 ++--
>  drivers/video/acornfb.c                |    5 +++--
>  drivers/video/arkfb.c                  |    9 +++++----
>  drivers/video/atmel_lcdfb.c            |   15 +++++++++------
>  drivers/video/aty/radeon_base.c        |   10 +++++-----
>  drivers/video/da8xx-fb.c               |    4 ++--
>  drivers/video/fb-puv3.c                |    4 ++--
>  drivers/video/g364fb.c                 |    5 +++--
>  drivers/video/gxt4500.c                |    4 ++--
>  drivers/video/hgafb.c                  |    4 ++--
>  drivers/video/imsttfb.c                |    2 +-
>  drivers/video/intelfb/intelfbhw.c      |    6 +++---
>  drivers/video/mb862xx/mb862xxfbdrv.c   |    2 +-
>  drivers/video/mx3fb.c                  |    6 +++---
>  drivers/video/neofb.c                  |    4 ++--
>  drivers/video/pm2fb.c                  |    4 ++--
>  drivers/video/pm3fb.c                  |    4 ++--
>  drivers/video/s3c-fb.c                 |    2 +-
>  drivers/video/s3fb.c                   |    7 ++++---
>  drivers/video/savage/savagefb_driver.c |   16 +++++++---------
>  drivers/video/sis/sis_main.c           |   30 ++++++++++--------------------
>  drivers/video/sm501fb.c                |    6 +++---
>  drivers/video/tridentfb.c              |    4 ++--
>  drivers/video/vfb.c                    |    4 ++--
>  drivers/video/vga16fb.c                |    2 +-
>  drivers/video/vt8500lcdfb.c            |    4 ++--
>  drivers/video/vt8623fb.c               |    9 +++++----
>  28 files changed, 92 insertions(+), 106 deletions(-)
> 

