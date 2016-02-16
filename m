From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Feb 2016 15:05:20 +0000
Subject: Re: [PATCH] xen kconfig: clarify INPUT_XEN_KBDDEV_FRONTEND select
Message-Id: <2697712.W9djLKoMG1@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455278707-2008263-1-git-send-email-arnd@arndb.de>
 <2801550.oZPkqjv8nW@wuerfel>
 <alpine.DEB.2.02.1602161156160.27008@kaball.uk.xensource.com>
In-Reply-To: <alpine.DEB.2.02.1602161156160.27008@kaball.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 16 February 2016 12:14:14 Stefano Stabellini wrote:
> > at all.
> 
> Please correct me if I am wrong, but the difference is that with this
> change if INPUT=m, then the build system would ask the user whether she
> wants to select INPUT_XEN_KBDDEV_FRONTEND as m or y, instead of
> unconditionally set INPUT_XEN_KBDDEV_FRONTEND=y.

INPUT_XEN_KBDDEV_FRONTEND cannot be set by the user to 'y' if
INPUT=m, because of an implied dependency around the input/misc/Kconfig
file.

> However it is true that if the users chooses
> INPUT_XEN_KBDDEV_FRONTEND=y, then the problem persists.
> Maybe we also need:
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 1f2337a..303df24 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -721,7 +721,7 @@ config INPUT_CMA3000_I2C
>  
>  config INPUT_XEN_KBDDEV_FRONTEND
>         tristate "Xen virtual keyboard and mouse support"
> -       depends on XEN
> +       depends on XEN && INPUT
>         default y
>         select XEN_XENBUS_FRONTEND
>         help
> 
> 
> Do you have a kernel config with INPUT=m that I can use to test with?

You can easily set that in any config if you disable CONFIG_VT. I don't
think it's worth spending more time on that, as everyone seems to be
happy with just removing the 'select', and I've sent a replacement
patch to do that.

	Arnd
