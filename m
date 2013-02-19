From: Olaf Hering <olaf@aepfle.de>
Date: Tue, 19 Feb 2013 16:51:18 +0000
Subject: Re: [PATCH RFC] video: Add Hyper-V Synthetic Video Frame Buffer Driver
Message-Id: <20130219165118.GA17715@aepfle.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360955396-14183-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1360955396-14183-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, kys@microsoft.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org

On Fri, Feb 15, Haiyang Zhang wrote:

> @@ -508,6 +544,18 @@ static int __init vesafb_init(void)
>  	int ret;
>  	char *option = NULL;
>  
> +#if IS_ENABLED(CONFIG_HYPERV_FB)
> +	/*
> +	 * On Hyper-V both the emulated and synthetic video devices are
> +	 * available. To avoid conflicts, we disable vesafb for the emulated
> +	 * video if hyperv_fb is configured.
> +	 */
> +	if (is_hyperv()) {
> +		pr_info("Disabled vesafb on Hyper-V.\n");
> +		return -ENODEV;
> +	}
> +#endif

What is the reason for this hook? Is it not possible to claim the
display like its appearently done by other drivers (like radeonfb can
take over display from vesafb)?

Olaf
