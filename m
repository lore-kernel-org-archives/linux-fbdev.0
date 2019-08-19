From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Aug 2019 14:04:06 +0000
Subject: Re: [PATCH v2] video: fbdev: Mark expected switch fall-through
Message-Id: <270684a4-ce22-ebb8-73a8-c004674c8f5d@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190730152542epcas2p46c9b1c2e97c0b33df072e4fa1328f8d0@epcas2p4.samsung.com>
        <20190730152530.3055-1-anders.roxell@linaro.org>
In-Reply-To: <20190730152530.3055-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Anders Roxell <anders.roxell@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, gustavo@embeddedor.com


On 7/30/19 5:25 PM, Anders Roxell wrote:
> Now that -Wimplicit-fallthrough is passed to GCC by default, the
> following warnings shows up:
> 
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_channel_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2086:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2087:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_overlay_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1596:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1597:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> 
> Rework to address a warnings due to the enablement of
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
