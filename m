From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 07 Mar 2017 17:39:35 +0000
Subject: Re: [PATCH 1/3] staging: sm750fb: fixes add blank line after function/struct/union/enum declarations
Message-Id: <20170307173935.GL4171@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170305112450.9066-1-arushisinghal19971997@gmail.com>
 <20170305112450.9066-2-arushisinghal19971997@gmail.com>
In-Reply-To: <20170305112450.9066-2-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

On Sun, Mar 05, 2017 at 04:54:48PM +0530, Arushi Singhal wrote:
> This patch fixes the warnings reported by checkpatch.pl
> for please use a blank line after function/struct/union/enum
> declarations.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_display.h | 1 +
>  drivers/staging/sm750fb/ddk750_mode.h    | 2 ++
>  drivers/staging/sm750fb/ddk750_power.h   | 1 +
>  drivers/staging/sm750fb/sm750_cursor.c   | 3 +++
>  4 files changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
> index e2a3f84ca4c5..8bf22e4f0d8b 100644
> --- a/drivers/staging/sm750fb/ddk750_display.h
> +++ b/drivers/staging/sm750fb/ddk750_display.h
> @@ -100,6 +100,7 @@ typedef enum _disp_output_t {
>  	do_CRT_PRI = CRT_2_PRI | PRI_TP_ON | DPMS_ON | DAC_ON,
>  	do_CRT_SEC = CRT_2_SEC | SEC_TP_ON | DPMS_ON | DAC_ON,
>  }
> +
>  disp_output_t;


Nah...  This is a typedef and this change makes it even worse.  It
should be on the same line as the }.

} disp_output_t;

But actually this typedef is not allowed.

regards,
dan carpenter

