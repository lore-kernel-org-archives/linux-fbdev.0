From: =?UTF-8?B?R2llZHJpdXMgU3RhdGtldmnEjWl1cw==?=  <giedrius.statkevicius@gmail.com>
Date: Sun, 08 Mar 2015 12:59:03 +0000
Subject: Re: [PATCH 3/4] staging: sm750fb: correctly define SM750LE_REVISION_ID
Message-Id: <54FC4797.6040704@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com> <1425817886-14387-3-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425817886-14387-3-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2015.03.08 14:31, Sudip Mukherjee wrote:
> check if it is already defined before defining SM750LE_REVISION_ID
> again and at the same time mention correct data type.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/staging/sm750fb/ddk750_chip.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
> index 1c78875..e7d27e8 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.h
> +++ b/drivers/staging/sm750fb/ddk750_chip.h
> @@ -1,7 +1,9 @@
>  #ifndef DDK750_CHIP_H__
>  #define DDK750_CHIP_H__
>  #define DEFAULT_INPUT_CLOCK 14318181 /* Default reference clock */
> -#define SM750LE_REVISION_ID (char)0xfe
> +#ifndef SM750LE_REVISION_ID
> +#define SM750LE_REVISION_ID ((unsigned char)0xfe)
> +#endif

Do you need these parantheses? Also, you can now then fix up this line
too to avoid a redundant cast in the same patch:
sm750_hw.c: if(share->revid = (unsigned char)SM750LE_REVISION_ID){


-- 
Thanks,
Giedrius
