From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 17 Feb 2014 01:51:28 +0000
Subject: Re: [PATCH RFC 2/3] fbdev: move fbdev core files to separate directory
Message-Id: <000d01cf2b82$c5f2cbc0$51d86340$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392376711-11290-1-git-send-email-tomi.valkeinen@ti.com>
 <1392376711-11290-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1392376711-11290-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, 'Geert Uytterhoeven' <geert@linux-m68k.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'David Airlie' <airlied@linux.ie>'Geert Uytterhoeven' <geert@linux-m68k.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, February 14, 2014 8:19 PM, Tomi Valkeinen wrote:
> 
> Instead of having fbdev framework core files at the root fbdev
> directory, mixed with random fbdev device drivers, move the fbdev core
> files to a separate core directory. This makes it much clearer which of
> the files are actually part of the fbdev framework, and which are part
> of device drivers.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Tomi,

This is what I wanted for a long time!
Thank you for your effort!

Last year, I noticed that the current FB directory and files
are not clear. It looks good!

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/fbdev/Makefile                 | 16 +---------------
>  drivers/video/fbdev/core/Makefile            | 16 ++++++++++++++++
>  drivers/video/fbdev/{ => core}/cfbcopyarea.c |  0
>  drivers/video/fbdev/{ => core}/cfbfillrect.c |  0
>  drivers/video/fbdev/{ => core}/cfbimgblt.c   |  0
>  drivers/video/fbdev/{ => core}/fb_ddc.c      |  2 +-
>  drivers/video/fbdev/{ => core}/fb_defio.c    |  0
>  drivers/video/fbdev/{ => core}/fb_draw.h     |  0
>  drivers/video/fbdev/{ => core}/fb_notify.c   |  0
>  drivers/video/fbdev/{ => core}/fb_sys_fops.c |  0
>  drivers/video/fbdev/{ => core}/fbcmap.c      |  0
>  drivers/video/fbdev/{ => core}/fbcvt.c       |  0
>  drivers/video/fbdev/{ => core}/fbmem.c       |  0
>  drivers/video/fbdev/{ => core}/fbmon.c       |  2 +-
>  drivers/video/fbdev/{ => core}/fbsysfs.c     |  0
>  drivers/video/fbdev/{ => core}/modedb.c      |  0
>  drivers/video/fbdev/{ => core}/svgalib.c     |  0
>  drivers/video/fbdev/{ => core}/syscopyarea.c |  0
>  drivers/video/fbdev/{ => core}/sysfillrect.c |  0
>  drivers/video/fbdev/{ => core}/sysimgblt.c   |  0
>  drivers/video/fbdev/wmt_ge_rops.c            |  2 +-
>  21 files changed, 20 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/video/fbdev/core/Makefile
>  rename drivers/video/fbdev/{ => core}/cfbcopyarea.c (100%)
>  rename drivers/video/fbdev/{ => core}/cfbfillrect.c (100%)
>  rename drivers/video/fbdev/{ => core}/cfbimgblt.c (100%)
>  rename drivers/video/fbdev/{ => core}/fb_ddc.c (99%)
>  rename drivers/video/fbdev/{ => core}/fb_defio.c (100%)
>  rename drivers/video/fbdev/{ => core}/fb_draw.h (100%)
>  rename drivers/video/fbdev/{ => core}/fb_notify.c (100%)
>  rename drivers/video/fbdev/{ => core}/fb_sys_fops.c (100%)
>  rename drivers/video/fbdev/{ => core}/fbcmap.c (100%)
>  rename drivers/video/fbdev/{ => core}/fbcvt.c (100%)
>  rename drivers/video/fbdev/{ => core}/fbmem.c (100%)
>  rename drivers/video/fbdev/{ => core}/fbmon.c (99%)
>  rename drivers/video/fbdev/{ => core}/fbsysfs.c (100%)
>  rename drivers/video/fbdev/{ => core}/modedb.c (100%)
>  rename drivers/video/fbdev/{ => core}/svgalib.c (100%)
>  rename drivers/video/fbdev/{ => core}/syscopyarea.c (100%)
>  rename drivers/video/fbdev/{ => core}/sysfillrect.c (100%)
>  rename drivers/video/fbdev/{ => core}/sysimgblt.c (100%)

