From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 02 Jun 2015 06:37:50 +0000
Subject: Re: [PATCH 03/12] Staging: sm750fb: sm750.h: Insert spaces after commas.
Message-Id: <20150602062550.GD6382@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433134873-9869-1-git-send-email-isaac.a.travers@gmail.com>
 <1433134873-9869-4-git-send-email-isaac.a.travers@gmail.com>
In-Reply-To: <1433134873-9869-4-git-send-email-isaac.a.travers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Isaac Assegai <isaac.a.travers@gmail.com>
Cc: gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, May 31, 2015 at 10:01:04PM -0700, Isaac Assegai wrote:
> Insert Spaces after commas to rectify the
> following checkpatch errors in sm750.h:
> ERROR: space required after that ','
> 
> Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.h | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index 5528912..5f86077 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -12,7 +12,7 @@
>  #define MB(x) ((x)<<20)
>  #define MHZ(x) ((x) * 1000000)
>  /* align should be 2,4,8,16 */
> -#define PADDING(align,data) (((data)+(align)-1)&(~((align) -1)))
> +#define PADDING(align, data) (((data)+(align)-1)&(~((align) -1)))
>  extern int smi_indent;
>  
>  
> @@ -27,15 +27,16 @@ struct lynx_accel{
>  
>  
> -	int (*de_imageblit)(struct lynx_accel *,const char *,u32,u32,u32,
> -						u32,u32,u32,u32,u32,u32,u32,u32,u32);
> +	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32, 
										^^^^^
oops, trailing whitespace errors :(
> +							       u32, u32, u32, u32, 
										^^^^^
here also
please test your patch with checkpatch before sending

regards
sudip

