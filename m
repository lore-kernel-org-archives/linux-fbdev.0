From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2014 21:30:54 +0000
Subject: Re: [PATCH 01/28] Remove CPU_MMP3
Message-Id: <20140211213054.GA2555@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-2-git-send-email-richard@nod.at>
In-Reply-To: <1391971686-9517-2-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:USB PHY LAYER" <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

On Sun, Feb 09, 2014 at 07:47:39PM +0100, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Acked-by: Paul Bolle <pebolle@tiscali.nl>
> 
> ---
>  drivers/usb/phy/Kconfig      | 1 -
>  drivers/video/mmp/Kconfig    | 2 +-
>  drivers/video/mmp/hw/Kconfig | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 7d1451d..b9b1c52 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -61,7 +61,6 @@ config KEYSTONE_USB_PHY
>  
>  config MV_U3D_PHY
>  	bool "Marvell USB 3.0 PHY controller Driver"
> -	depends on CPU_MMP3
>  	select USB_PHY
>  	help
>  	  Enable this to support Marvell USB 3.0 phy controller for Marvell

Do this and the driver breaks the build so it needs to depend on
something:

drivers/usb/phy/phy-mv-u3d-usb.c: In function ‘mv_u3d_phy_read’:
drivers/usb/phy/phy-mv-u3d-usb.c:42:2: error: implicit declaration of function ‘writel_relaxed’ [-Werror=implicit-function-declaration]

Sorry, I can't take this as-is.

greg k-h
