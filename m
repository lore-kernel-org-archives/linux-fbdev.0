From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 20 Jul 2010 00:14:21 +0000
Subject: Re: [PATCH] viafb: Depends on X86
Message-Id: <4C44EA5D.4010801@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279582816.4883.214.camel@localhost>
In-Reply-To: <1279582816.4883.214.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Ben Hutchings schrieb:
> VIA UniChrome and Chrome9 GPUs only exist as Integrated Graphics
> Processors in x86 chipsets.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3d94a14..162a0b7 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1505,7 +1505,7 @@ config FB_SIS_315
>  
>  config FB_VIA
>         tristate "VIA UniChrome (Pro) and Chrome9 display support"
> -       depends on FB && PCI
> +       depends on FB && PCI && X86
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT

