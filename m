From: Timur Tabi <timur@tabi.org>
Date: Thu, 03 Dec 2015 01:12:49 +0000
Subject: Re: [PATCH v2] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <565F9711.1090009@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449062416-12245-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1449062416-12245-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> If diu_ops is not implemented on platform, kernel will access a null
> pointer. we need to check this pointer in diu initialization.

Please fix capitalization: We, DIU, NULL.

> @@ -1915,6 +1918,10 @@ static int __init fsl_diu_init(void)
>   #else
>   	monitor_port = fsl_diu_name_to_port(monitor_string);
>   #endif
> +
> +	if (!diu_ops.set_pixel_clock)
> +		return -ENODEV;
> +

Please add a comment explaining that set_pixel_clock is required, so if 
it isn't set, then that means that there is no platform support for the DIU.

