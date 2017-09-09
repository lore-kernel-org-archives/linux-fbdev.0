From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sat, 09 Sep 2017 17:11:09 +0000
Subject: Re: [Outreachy kernel] [PATCH] staging: sm750fb: Remove extra blank lines
Message-Id: <alpine.DEB.2.20.1709091910580.2149@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1504953287-14740-1-git-send-email-harshasharmaiitr@gmail.com>
In-Reply-To: <1504953287-14740-1-git-send-email-harshasharmaiitr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harsha Sharma <harshasharmaiitr@gmail.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com, linux-fbdev@vger.kernel.org



On Sat, 9 Sep 2017, Harsha Sharma wrote:

> This was reported by checkpatch.pl
>
> Signed-off-by: Harsha Sharma <harshasharmaiitr@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/staging/sm750fb/sm750_cursor.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
> index aa47a16..6b27b06 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.c
> +++ b/drivers/staging/sm750fb/sm750_cursor.c
> @@ -18,8 +18,6 @@
>  #include "sm750.h"
>  #include "sm750_cursor.h"
>
> -
> -
>  #define poke32(addr, data) \
>  writel((data), cursor->mmio + (addr))
>
> @@ -45,7 +43,6 @@
>  #define HWC_COLOR_3                         0xC
>  #define HWC_COLOR_3_RGB565_MASK             0xffff
>
> -
>  /* hw_cursor_xxx works for voyager,718 and 750 */
>  void sm750_hw_cursor_enable(struct lynx_cursor *cursor)
>  {
> @@ -134,7 +131,6 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
>  	}
>  }
>
> -
>  void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
>  			      const u8 *pcol, const u8 *pmsk)
>  {
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1504953287-14740-1-git-send-email-harshasharmaiitr%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
