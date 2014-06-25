From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Jun 2014 12:26:10 +0000
Subject: Re: [PATCH v2 1/2] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <201406251426.11130.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403194843-32574-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1403194843-32574-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday 19 June 2014, Alexander Shiyan wrote:
> -config FB_CLPS711X
> -       bool "CLPS711X LCD support"
> -       depends on (FB = y) && ARM && ARCH_CLPS711X
> +config FB_CLPS711X_OLD
> +       bool
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT
> +
> +config FB_CLPS711X
> +       tristate "CLPS711X LCD support"
> +       depends on FB && (ARCH_CLPS711X || COMPILE_TEST)
> +       select FB_CLPS711X_OLD if ARCH_CLPS711X && !ARCH_MULTIPLATFORM
> +       select BACKLIGHT_LCD_SUPPORT
> +       select FB_MODE_HELPERS

I found that with this change, you can now end up in a situation of CONFIG_FB=m
and FB_CLPS711X=y, which doesn't link properly.

We need to either turn FB_CLPS711X_OLD into 'tristate' or add
'depends on ARCH_MULTIPLATFORM || FB=y' to FB_CLPS711X.

	Arnd
