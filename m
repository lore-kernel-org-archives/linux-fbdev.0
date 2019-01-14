From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 14 Jan 2019 21:50:34 +0000
Subject: Re: [PATCH] video: offb: annotate implicit fall throughs
Message-Id: <15854ad8-7bd5-ede7-6ce4-00122d6ba279@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190114204044.20528-1-malat@debian.org>
In-Reply-To: <20190114204044.20528-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org



On 1/14/19 2:40 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
> 
> This commit remove the following warnings:
> 
>    drivers/video/fbdev/offb.c:211:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    drivers/video/fbdev/offb.c:142:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks
--
Gustavo

> ---
>   drivers/video/fbdev/offb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 31f769d67195..e0f0c5351306 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -141,6 +141,7 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>   		/* Clear PALETTE_ACCESS_CNTL in DAC_CNTL */
>   		out_le32(par->cmap_adr + 0x58,
>   			 in_le32(par->cmap_adr + 0x58) & ~0x20);
> +		/* fall through */
>   	case cmap_r128:
>   		/* Set palette index & data */
>   		out_8(par->cmap_adr + 0xb0, regno);
> @@ -210,6 +211,7 @@ static int offb_blank(int blank, struct fb_info *info)
>   				/* Clear PALETTE_ACCESS_CNTL in DAC_CNTL */
>   				out_le32(par->cmap_adr + 0x58,
>   					 in_le32(par->cmap_adr + 0x58) & ~0x20);
> +				/* fall through */
>   			case cmap_r128:
>   				/* Set palette index & data */
>   				out_8(par->cmap_adr + 0xb0, i);
> 
