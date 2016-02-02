From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 Feb 2016 21:10:49 +0000
Subject: Re: [PATCH] video: ARM CLCD: runtime check for Versatile
Message-Id: <25978729.oSoMp4ZgxA@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454446059-30526-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454446059-30526-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 02 February 2016 21:47:39 Linus Walleij wrote:
>         } else {
> -#ifdef CONFIG_ARCH_VERSATILE
> -               fb->off_ienb = CLCD_PL111_IENB;
> -               fb->off_cntl = CLCD_PL111_CNTL;
> -#else
> -               fb->off_ienb = CLCD_PL110_IENB;
> -               fb->off_cntl = CLCD_PL110_CNTL;
> -#endif
> +               if (of_machine_is_compatible("arm,versatile-ab") ||
> +                   of_machine_is_compatible("arm,versatile-pb")) {
> +                       fb->off_ienb = CLCD_PL111_IENB;
> +                       fb->off_cntl = CLCD_PL111_CNTL;
> +               } else {
> +                       fb->off_ienb = CLCD_PL110_IENB;
> +                       fb->off_cntl = CLCD_PL110_CNTL;
> +               }
>         }
> 

Could that be done based on the AMBA device ID instead?

	Arnd
