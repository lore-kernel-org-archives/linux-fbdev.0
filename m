From: Julia Lawall <julia.lawall@lip6.fr>
Date: Wed, 30 Oct 2019 05:27:46 +0000
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: sm750fb: Fix typo in comment
Message-Id: <alpine.DEB.2.21.1910300627330.2471@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
 <20191029232207.4113-2-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191029232207.4113-2-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, trivial@kernel.org, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com, lkcamp@lists.libreplanetbr.org, sudipm.mukherjee@gmail.com



On Tue, 29 Oct 2019, Gabriela Bittencourt wrote:

> Fixing typo in word 'and'.
>
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  drivers/staging/sm750fb/sm750_accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 645813a87490..5925d7c7d464 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -224,7 +224,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>
>  	/*
>  	 * Note:
> -	 * DE_FOREGROUND are DE_BACKGROUND are don't care.
> +	 * DE_FOREGROUND and DE_BACKGROUND are don't care.
>  	 * DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS
>  	 * are set by set deSetTransparency().
>  	 */
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191029232207.4113-2-gabrielabittencourt00%40gmail.com.
>
