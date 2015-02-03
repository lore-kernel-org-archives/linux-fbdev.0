From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 03 Feb 2015 17:44:34 +0000
Subject: Re: [PATCH] staging: sm7xxfb: make smtc_scr_info static
Message-Id: <20150203173234.GB26315@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422953068-12072-1-git-send-email-mperepelitsyn@gmail.com>
In-Reply-To: <1422953068-12072-1-git-send-email-mperepelitsyn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Perepelitsyn <mperepelitsyn@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, Feb 03, 2015 at 02:44:28PM +0600, Max Perepelitsyn wrote:
> This symbol is never used anywhere else besides sm7xxfb.c
> 
> Signed-off-by: Max Perepelitsyn <mperepelitsyn@gmail.com>

Tested-by: Sudip Mukherjee <sudip@vectorindia.org>

> ---
>  drivers/staging/sm7xxfb/sm7xxfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
> index 2ae9fd0..72036c2 100644
> --- a/drivers/staging/sm7xxfb/sm7xxfb.c
> +++ b/drivers/staging/sm7xxfb/sm7xxfb.c
> @@ -111,7 +111,7 @@ static struct vesa_mode vesa_mode_table[] = {
>  	{"0x31B", 1280, 1024, 24},
>  };
>  
> -struct screen_info smtc_scr_info;
> +static struct screen_info smtc_scr_info;
>  
>  /* process command line options, get vga parameter */
>  static int __init sm7xx_vga_setup(char *options)
> -- 
> 2.2.2
> 
