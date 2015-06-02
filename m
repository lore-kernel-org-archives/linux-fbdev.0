From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 02 Jun 2015 06:53:27 +0000
Subject: Re: [PATCH 10/12] Staging: sm750fb: Insert spaces after commas in two files.
Message-Id: <20150602064127.GE6382@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433134873-9869-1-git-send-email-isaac.a.travers@gmail.com>
 <1433134873-9869-11-git-send-email-isaac.a.travers@gmail.com>
In-Reply-To: <1433134873-9869-11-git-send-email-isaac.a.travers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Isaac Assegai <isaac.a.travers@gmail.com>
Cc: gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, May 31, 2015 at 10:01:11PM -0700, Isaac Assegai wrote:
> Insert Spaces after commas to rectify the following
> checkpatch errors in ddk750_help.c and ddk750_mode.c:
> ERROR: space required after that ','
> 
> Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> ---
>  
<snip>
>  
> -		ulTmpValue = FIELD_VALUE(0,CRT_DISPLAY_CTRL,VSYNC_PHASE,pModeParam->vertical_sync_polarity)|
> -					  FIELD_VALUE(0,CRT_DISPLAY_CTRL,HSYNC_PHASE,pModeParam->horizontal_sync_polarity)|
> -					  FIELD_SET(0,CRT_DISPLAY_CTRL,TIMING,ENABLE)|
> +		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL,VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
							^^^^^^^^
missed this
> +					  FIELD_VALUE(0, CRT_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity)|
> +					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING,ENABLE)|
									     ^^^^^
this also

regards
sudip
