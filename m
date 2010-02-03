From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 03 Feb 2010 22:36:44 +0000
Subject: Re: [PATCH 09/10] drivers/video/via: Fix continuation line formats
Message-Id: <4B69FA7C.9040309@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265095093.git.joe@perches.com> <4affbba1523b0cc13bb02f309e3091a29a6ccf6a.1265095094.git.joe@perches.com>
In-Reply-To: <4affbba1523b0cc13bb02f309e3091a29a6ccf6a.1265095094.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi,

Joe Perches schrieb:
> String constants that are continued on subsequent lines with \
> are not good.

I agree.

> Signed-off-by: Joe Perches <joe@perches.com>

According to how I understand CodingStyle this is the way those things 
should be done.

Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Andrew, can you please take care of this patch?


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/via/dvi.c |    8 ++++----
>  drivers/video/via/lcd.c |   12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/via/dvi.c b/drivers/video/via/dvi.c
> index 67b3693..b3b7822 100644
> --- a/drivers/video/via/dvi.c
> +++ b/drivers/video/via/dvi.c
> @@ -467,8 +467,8 @@ static int dvi_get_panel_size_from_DDCv1(void)
>  	default:
>  		viaparinfo->tmds_setting_info->dvi_panel_size >  			VIA_RES_1024X768;
> -		DEBUG_MSG(KERN_INFO "Unknown panel size max resolution = %d !\
> -					 set default panel size.\n", max_h);
> +		DEBUG_MSG(KERN_INFO "Unknown panel size max resolution = %d ! "
> +			  "set default panel size.\n", max_h);
>  		break;
>  	}
>  
> @@ -534,8 +534,8 @@ static int dvi_get_panel_size_from_DDCv2(void)
>  	default:
>  		viaparinfo->tmds_setting_info->dvi_panel_size >  			VIA_RES_1024X768;
> -		DEBUG_MSG(KERN_INFO "Unknown panel size max resolution = %d!\
> -					set default panel size.\n", HSize);
> +		DEBUG_MSG(KERN_INFO "Unknown panel size max resolution = %d! "
> +			  "set default panel size.\n", HSize);
>  		break;
>  	}
>  
> diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
> index 09353e2..4962297 100644
> --- a/drivers/video/via/lcd.c
> +++ b/drivers/video/via/lcd.c
> @@ -171,13 +171,13 @@ static bool lvds_identify_integratedlvds(void)
>  		if (viaparinfo->chip_info->lvds_chip_info.lvds_chip_name) {
>  			viaparinfo->chip_info->lvds_chip_info2.lvds_chip_name >  			    INTEGRATED_LVDS;
> -			DEBUG_MSG(KERN_INFO "Support two dual channel LVDS!\
> -				  (Internal LVDS + External LVDS)\n");
> +			DEBUG_MSG(KERN_INFO "Support two dual channel LVDS! "
> +				  "(Internal LVDS + External LVDS)\n");
>  		} else {
>  			viaparinfo->chip_info->lvds_chip_info.lvds_chip_name >  			    INTEGRATED_LVDS;
> -			DEBUG_MSG(KERN_INFO "Not found external LVDS,\
> -				  so can't support two dual channel LVDS!\n");
> +			DEBUG_MSG(KERN_INFO "Not found external LVDS, "
> +				  "so can't support two dual channel LVDS!\n");
>  		}
>  	} else if (viafb_display_hardware_layout = HW_LAYOUT_LCD1_LCD2) {
>  		/* Two single channel LCD (Internal LVDS + Internal LVDS): */
> @@ -185,8 +185,8 @@ static bool lvds_identify_integratedlvds(void)
>  		INTEGRATED_LVDS;
>  		viaparinfo->chip_info->lvds_chip_info2.lvds_chip_name >  			INTEGRATED_LVDS;
> -		DEBUG_MSG(KERN_INFO "Support two single channel LVDS!\
> -			  (Internal LVDS + Internal LVDS)\n");
> +		DEBUG_MSG(KERN_INFO "Support two single channel LVDS! "
> +			  "(Internal LVDS + Internal LVDS)\n");
>  	} else if (viafb_display_hardware_layout != HW_LAYOUT_DVI_ONLY) {
>  		/* If we have found external LVDS, just use it,
>  		   otherwise, we will use internal LVDS as default. */

