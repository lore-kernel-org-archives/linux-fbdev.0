From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 07 Mar 2017 17:44:26 +0000
Subject: Re: [PATCH 3/3] staging: sm750fb: Alignment should match open parenthesis
Message-Id: <20170307174426.GM4171@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170305112450.9066-1-arushisinghal19971997@gmail.com>
 <20170305112450.9066-4-arushisinghal19971997@gmail.com>
In-Reply-To: <20170305112450.9066-4-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

On Sun, Mar 05, 2017 at 04:54:50PM +0530, Arushi Singhal wrote:
> @@ -147,18 +146,18 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
>  				PANEL_HORIZONTAL_SYNC_START_MASK));
>  
>  		poke32(PANEL_VERTICAL_TOTAL,
> -			(((pModeParam->vertical_total - 1) <<
> -				PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) &
> -				PANEL_VERTICAL_TOTAL_TOTAL_MASK) |
> -			((pModeParam->vertical_display_end - 1) &
> -				PANEL_VERTICAL_TOTAL_DISPLAY_END_MASK));
> +		       (((pModeParam->vertical_total - 1) <<
> +			 PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) &
> +			PANEL_VERTICAL_TOTAL_TOTAL_MASK) |
> +		       ((pModeParam->vertical_display_end - 1) &
> +			ANEL_VERTICAL_TOTAL_DISPLAY_END_MASK));
                        ^^^^

Missing P in PANEL means this won't compile.

>  
>  		poke32(PANEL_VERTICAL_SYNC,
> -			((pModeParam->vertical_sync_height <<
> -				PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) &
> -				PANEL_VERTICAL_SYNC_HEIGHT_MASK) |
> -			((pModeParam->vertical_sync_start - 1) &
> -				PANEL_VERTICAL_SYNC_START_MASK));
> +		       ((pModeParam->vertical_sync_height <<
> +			 PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) &
> +			PANEL_VERTICAL_SYNC_HEIGHT_MASK) |
> +		       ((pModeParam->vertical_sync_start - 1) &
> +			PANEL_VERTICAL_SYNC_START_MASK));
>  
>  		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
>  		if (pModeParam->vertical_sync_polarity)

regards,
dan carpenter
