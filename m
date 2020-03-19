From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 19 Mar 2020 15:49:27 +0000
Subject: Re: [PATCH 0/3] video: Use scnprintf() for avoiding potential buffer overflow
Message-Id: <s5hh7ykuyyg.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200311093230.24900-1-tiwai@suse.de>
In-Reply-To: <20200311093230.24900-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 11 Mar 2020 10:32:27 +0100,
Takashi Iwai wrote:
> 
> Hi,
> 
> here is a series of trivial patches just to convert suspicious
> snprintf() usages with the more safer one, scnprintf().
> 
> 
> Takashi
> 
> => 
> Takashi Iwai (3):
>   video: omapfb: Use scnprintf() for avoiding potential buffer overflow
>   video: omap2: Use scnprintf() for avoiding potential buffer overflow
>   video: uvesafb: Use scnprintf() for avoiding potential buffer overflow
> 
>  drivers/video/fbdev/omap/omapfb_main.c          | 14 +++++++-------
>  drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c |  8 ++++----
>  drivers/video/fbdev/uvesafb.c                   |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)

Just a gentle ping about those patches.
Let me know if any further changes needed.


thanks,

Takashi
