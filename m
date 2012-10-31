From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 31 Oct 2012 05:23:09 +0000
Subject: RE: [PATCH] da8xx: Allow use by am33xx based devices
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9E1129@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351698968-3965-1-git-send-email-panto@antoniou-consulting.com>
In-Reply-To: <1351698968-3965-1-git-send-email-panto@antoniou-consulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pantelis Antoniou <panto@antoniou-consulting.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, "Porter, Matt" <mporter@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

Hi,

On Wed, Oct 31, 2012 at 21:26:08, Pantelis Antoniou wrote:
> This driver can be used for AM33xx devices, like the popular beaglebone.
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
>  drivers/video/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 9791d10..e7868d8 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2202,7 +2202,7 @@ config FB_SH7760
>  
>  config FB_DA8XX
>  	tristate "DA8xx/OMAP-L1xx Framebuffer support"
> -	depends on FB && ARCH_DAVINCI_DA8XX
> +	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)

Agreed this is present on da8xx and am33xx, but moving forward for
supporting DT, we should be avoiding these dependencies. So instead
change this to remove machine dependencies.

Thanks,
Prakash

>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 1.7.12
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

