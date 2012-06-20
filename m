From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 20 Jun 2012 01:01:31 +0000
Subject: Re: [PULL for v3.6] SH Mobile LCDC fixes and planes support
Message-Id: <4FE120EB.2030608@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3246665.HJN7RE5zfe@avalon>
In-Reply-To: <3246665.HJN7RE5zfe@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 06/16/2012 02:07 PM, Laurent Pinchart wrote:
> Hi Florian,
> 
> Could you please pull the following LCDC patches ?

looks good, except...

> 
> The following changes since commit b67989515defba7412acff01162e5bb1f0f5923a:
> 
>   video: s3c-fb: fix possible division by zero in s3c_fb_calc_pixclk 
> (2012-06-13 17:34:16 +0000)
> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git planes
> 
> Guennadi Liakhovetski (1):
>       fbdev: sh_mipi_dsi: fix a section mismatch
> 
> Laurent Pinchart (4):
>       fbdev: sh_mobile_lcdc: Don't confuse line size with pitch

...for this patch it would have been better if you based your work on a
more recent tree of Linus that already contains it instead of asking me
to pull it again [I now forwarded my fbdev-next to -rc3]. It's not a big
issue as git handles such situations but pushing patches around that are
essentially nops should be avoided I think. Well, if you decide to fix
it I'd be happy, otherwise I'll pull this in a few days nonetheless.


Best regards,

Florian Tobias Schandinat

>       fbdev: sh_mobile_lcdc: Constify sh_mobile_lcdc_fix structure
>       fbdev: sh_mobile_lcdc: Rename fb operation handlers with a common prefix
>       fbdev: sh_mobile_lcdc: Implement overlays support
> 
>  .../sysfs-devices-platform-sh_mobile_lcdc_fb       |   44 +
>  drivers/video/sh_mipi_dsi.c                        |    7 +-
>  drivers/video/sh_mobile_lcdcfb.c                   |  987 +++++++++++++++++--
>  drivers/video/sh_mobile_lcdcfb.h                   |    1 +
>  include/video/sh_mobile_lcdc.h                     |    7 +
>  5 files changed, 944 insertions(+), 102 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-
> sh_mobile_lcdc_fb
> 
