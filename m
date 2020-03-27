From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 27 Mar 2020 08:25:18 +0000
Subject: Re: [PATCH 0/3] video: Use scnprintf() for avoiding potential buffer overflow
Message-Id: <s5hftdufbm9.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200311093230.24900-1-tiwai@suse.de>
 <CGME20200319154932eucas1p2ef5a13ed2630d236acb7a7bb0b5e56c6@eucas1p2.samsung.com>
 <s5hh7ykuyyg.wl-tiwai@suse.de>
 <85a0f31c-2e83-cf13-d5e8-2ea7f236f921@samsung.com>
In-Reply-To: <85a0f31c-2e83-cf13-d5e8-2ea7f236f921@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, 20 Mar 2020 14:42:51 +0100,
Bartlomiej Zolnierkiewicz wrote:
> 
> 
> On 3/19/20 4:49 PM, Takashi Iwai wrote:
> > On Wed, 11 Mar 2020 10:32:27 +0100,
> > Takashi Iwai wrote:
> >>
> >> Hi,
> >>
> >> here is a series of trivial patches just to convert suspicious
> >> snprintf() usages with the more safer one, scnprintf().
> >>
> >>
> >> Takashi
> >>
> >> => >>
> >> Takashi Iwai (3):
> >>   video: omapfb: Use scnprintf() for avoiding potential buffer overflow
> >>   video: omap2: Use scnprintf() for avoiding potential buffer overflow
> >>   video: uvesafb: Use scnprintf() for avoiding potential buffer overflow
> >>
> >>  drivers/video/fbdev/omap/omapfb_main.c          | 14 +++++++-------
> >>  drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c |  8 ++++----
> >>  drivers/video/fbdev/uvesafb.c                   |  2 +-
> >>  3 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > Just a gentle ping about those patches.
> > Let me know if any further changes needed.
> Patches #1-3 queued for v5.7, thanks!

I still don't see those in linux-next as of today.
Could you check it?


thanks,

Takashi
