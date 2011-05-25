From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 09:41:59 +0000
Subject: Re: [PATCH] viafb: use display information in info not in var for panning
Message-Id: <201105251142.00164.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201105232211.40154.laurent.pinchart@ideasonboard.com> <1306188446-5160-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1306188446-5160-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

Hi Florian,

On Tuesday 24 May 2011 00:07:26 Florian Tobias Schandinat wrote:
> As Laurent pointed out we must not use any information in the passed
> var besides xoffset, yoffset and vmode as otherwise applications
> might abuse it. Also use the aligned fix.line_length and not the
> (possible) unaligned xres_virtual.
> 
> Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: stable@kernel.org

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/video/via/viafbdev.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 3114a87..aa87529 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -348,8 +348,9 @@ static int viafb_pan_display(struct fb_var_screeninfo
> *var, struct fb_info *info)
>  {
>  	struct viafb_par *viapar = info->par;
> -	u32 vram_addr = (var->yoffset * var->xres_virtual + var->xoffset)
> -		* (var->bits_per_pixel / 8) + viapar->vram_addr;
> +	u32 vram_addr = viapar->vram_addr
> +		+ var->yoffset * info->fix.line_length
> +		+ var->xoffset * info->var.bits_per_pixel / 8;
> 
>  	DEBUG_MSG(KERN_DEBUG "viafb_pan_display, address = %d\n", vram_addr);
>  	if (!viafb_dual_fb) {

-- 
Regards,

Laurent Pinchart
