From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 05 Mar 2013 15:45:46 +0000
Subject: Re: [PATCH v2] fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings
Message-Id: <3616474.9Jo4TxL1sT@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Morimoto-san,

Thanks for the patch.

On Monday 04 March 2013 21:07:10 Kuninori Morimoto wrote:
> The lcdc B side horizon output is shifted
> if sh_mobile_lcdc_pan() was called.
> This patch fixup this issue.
> It is tested on R8A7740 Armadillo800eva HDMI output.
> Special thanks to Fukushima-san, and Sano-san
> 
> Reported-by: Osamu Fukushima <osamu.fukushima.wr@renesas.com>
> Signed-off-by: Hideyuki Sano <hideyuki.sano.dn@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v1 -> v2
> 
>  - git log has tested SoC/board
> 
>  drivers/video/sh_mobile_lcdcfb.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/sh_mobile_lcdcfb.c
> b/drivers/video/sh_mobile_lcdcfb.c index 63203ac..0264704 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -858,6 +858,7 @@ static void sh_mobile_lcdc_geometry(struct
> sh_mobile_lcdc_chan *ch) tmp = ((mode->xres & 7) << 24) | ((display_h_total
> & 7) << 16)
> 
>  	    | ((mode->hsync_len & 7) << 8) | (hsync_pos & 7);
> 
>  	lcdc_write_chan(ch, LDHAJR, tmp);
> +	lcdc_write_chan_mirror(ch, LDHAJR, tmp);
>  }
> 
>  static void sh_mobile_lcdc_overlay_setup(struct sh_mobile_lcdc_overlay
> *ovl)

-- 
Regards,

Laurent Pinchart

