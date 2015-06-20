From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 20 Jun 2015 07:55:35 +0000
Subject: Re: [PATCH v3] staging: sm750fb: use tabs for indentation
Message-Id: <20150620074335.GB15195@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434779457-18601-1-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1434779457-18601-1-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Jun 19, 2015 at 10:50:57PM -0700, Juston Li wrote:
> Replace spaces with tabs for indentation to fix the checkpatch.pl warning
> 'WARNING: please, no spaces at the start of a line'
> 
> checkpatch doesn't catch comments indented by spaces but I fixed comments
> adjacent to warnings as well so they would remain aligned.
> 
> Signed-off-by: Juston Li <juston.h.li@gmail.com>
> ---
<snip>
> diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
> index 7826376..23d6e19 100644
> --- a/drivers/staging/sm750fb/ddk750_hwi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
> @@ -9,71 +9,69 @@
>  #define HWI2C_WAIT_TIMEOUT              0xF0000
>  
>  
> -int hwI2CInit(
> -    unsigned char busSpeedMode
> -)
> +int hwI2CInit(unsigned char busSpeedMode)
but this is what you say in commit message. Please only do one type of
change in a single patch.

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
