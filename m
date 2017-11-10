From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Nov 2017 15:31:38 +0000
Subject: Re: [PATCH] video: fbdev: pxa3xx_gcu: Convert timers to use timer_setup()
Message-Id: <1873548.3BWMf1Kard@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171109184844epcas3p2cce92ea7c58b3a517914b069013a08d0@epcas3p2.samsung.com>
 <20171109184840.GA115388@beast>
In-Reply-To: <20171109184840.GA115388@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

On Thursday, November 09, 2017 10:48:40 AM Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> This also fixes the use of the "priv" variable in QERROR(), since it was
> pointing to struct timer_list, not struct pxa3xx_gcu_priv.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Cc: Himanshu Jha <himanshujha199640@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> If you can take this for v4.15, please do. Otherwise, I can carry it in the
> timers tree in late rc1. Thanks!

Thanks, I queued this for v4.15 with a trivial fix for:

>  #else
> -static inline void pxa3xx_gcu_init_debug_timer(void) {}
> +static inline void pxa3xx_gcu_init_debug_timer(struct pxa3xx_gcu_priv *) {}
>  #endif

which caused:

drivers/video/fbdev/pxa3xx-gcu.c: In function ‘pxa3xx_gcu_init_debug_timer’:
drivers/video/fbdev/pxa3xx-gcu.c:534:133: error: parameter name omitted
make[3]: *** [drivers/video/fbdev/pxa3xx-gcu.o] Error 1
make[3]: *** Waiting for unfinished jobs....

for the non-debug case.

I also queued the original fbdev conversion patch on top of this one.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

