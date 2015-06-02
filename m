From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 02 Jun 2015 06:48:15 +0000
Subject: Re: [PATCH 12/12] Staging: sm750fb: Insert spaces after commas in three files.
Message-Id: <20150602064806.GF6382@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433134873-9869-1-git-send-email-isaac.a.travers@gmail.com>
 <1433134873-9869-13-git-send-email-isaac.a.travers@gmail.com>
In-Reply-To: <1433134873-9869-13-git-send-email-isaac.a.travers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Isaac Assegai <isaac.a.travers@gmail.com>
Cc: gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, May 31, 2015 at 10:01:13PM -0700, Isaac Assegai wrote:
> Insert Spaces after commas to rectify the following checkpatch
> errors in ddk750_mode.c, sm750_accel.c and sm750_help.h:
> ERROR: space required after that ','
> 
> Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 46 +++++++++++++++++------------------
>  drivers/staging/sm750fb/sm750_accel.c |  2 +-
>  drivers/staging/sm750fb/sm750_help.h  |  2 +-
>  3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index 4e252fb..a054747 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -101,29 +101,29 @@ static int programModeRegisters(mode_parameter_t * pModeParam, pll_value_t * pll
>              | FIELD_VALUE(0, CRT_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
>  
>  
> -		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL,VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
> +		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
>  					  FIELD_VALUE(0, CRT_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity)|
> -					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING,ENABLE)|
> -					  FIELD_SET(0,CRT_DISPLAY_CTRL,PLANE,ENABLE);
> +					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING, ENABLE)|
> +					  FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
I am getting confused now.
This part you have modified in patch 10/12 and i just replied that
you have missed two modifications.

regards
sudip
