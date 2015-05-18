From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 18 May 2015 05:16:21 +0000
Subject: Re: [PATCH] staging: sm750fb: fix typo in fb_videomode Array
Message-Id: <20150518050421.GA3906@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150516193128.GA1534@x230-arch.Speedport_W_724V_01011602_00_001>
In-Reply-To: <20150516193128.GA1534@x230-arch.Speedport_W_724V_01011602_00_001>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, May 16, 2015 at 09:31:28PM +0200, Michel von Czettritz wrote:
> It appears that 'FB_SYNC_HOR_HIGH_ACT' should be assined to 'sync'
> and 'FB_VMODE_NONINTERLACED' is a flag for 'vmode'.
> 
<snip>
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 77310ff..8ff29c6 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -94,7 +94,8 @@ static const struct fb_videomode lynx750_ext[] = {
>  	 FB_VMODE_NONINTERLACED},
>  
>  	{NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
> -	 FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
> +	 FB_SYNC_HOR_HIGH_ACT,
> +	 FB_VMODE_NONINTERLACED},

good catch. But, see that all the entries are having:
        FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
        FB_VMODE_NONINTERLACED

this is the only entry with a different flag settings. moreover this
entry is for 1360x768@60 , see the next entry and that is also for
1360x768@60 with the correct flags. So my opinion this entry is wrong.

Send a patch instead to delete this entry and I can check that on the
hardware.

regards
sudip

	
>  
>  	/*	1360 x 768	[1.77083:1]	*/
>  	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
> -- 
> 2.3.7
> 
