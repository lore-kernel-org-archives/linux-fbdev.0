From: Kalle Valo <kvalo@codeaurora.org>
Date: Thu, 15 Mar 2018 12:54:07 +0000
Subject: Re: [PATCH 11/16] treewide: simplify Kconfig dependencies for removed archs
Message-Id: <873711zehc.fsf@purkki.adurom.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
In-Reply-To: <20180314144614.1632190-1-arnd-r2nGTMty4D4@public.gmane.org> (Arnd Bergmann's message
        of "Wed, 14 Mar 2018 15:43:46 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org

Arnd Bergmann <arnd@arndb.de> writes:

> A lot of Kconfig symbols have architecture specific dependencies.
> In those cases that depend on architectures we have already removed,
> they can be omitted.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

>  drivers/net/wireless/cisco/Kconfig   |  2 +-

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
