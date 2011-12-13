From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 13 Dec 2011 23:02:11 +0000
Subject: Re: [PATCH 06/57] fbdev: sh_mobile_hdmi: Don't access LCDC channel
Message-Id: <Pine.LNX.4.64.1112132354410.20293@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-7-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-7-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 13 Dec 2011, Laurent Pinchart wrote:

> Instead of relying on info->par being a pointer to an LCDC channel, cast
> the notifier block pointer to an sh_hdmi pointer.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_hdmi.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
> index 647ba98..b1e90f5 100644
> --- a/drivers/video/sh_mobile_hdmi.c
> +++ b/drivers/video/sh_mobile_hdmi.c
> @@ -225,6 +225,8 @@ struct sh_hdmi {
>  	struct notifier_block notifier;
>  };
>  
> +#define notifier_to_hdmi(n)	container_of(n, struct sh_hdmi, notifier)
> +
>  static void hdmi_write(struct sh_hdmi *hdmi, u8 data, u8 reg)
>  {
>  	iowrite8(data, hdmi->base + reg);
> @@ -1204,9 +1206,7 @@ static int sh_hdmi_notify(struct notifier_block *nb,
>  {
>  	struct fb_event *event = data;
>  	struct fb_info *info = event->info;
> -	struct sh_mobile_lcdc_chan *ch = info->par;
> -	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
> -	struct sh_hdmi *hdmi = board_cfg->board_data;
> +	struct sh_hdmi *hdmi = notifier_to_hdmi(nb);
>  
>  	if (!hdmi || nb != &hdmi->notifier || hdmi->info != info)

Then you also can drop the first two of the three checks above. If I'm not 
mistaken, in a HDMI / LCD set up, if this notifier is called for the LCD 
panel, hdmi will wtill point to the HDMI-related sh_hdmi object, whose 
->info will then mismatch the info pointer, derived from the notifier 
"data" pointer.

>  		return NOTIFY_DONE;
> -- 
> 1.7.3.4

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
