From: Marek Vasut <marex@denx.de>
Date: Wed, 03 Apr 2013 02:26:16 +0000
Subject: Re: [PATCH v2 2/2] video: mxsfb: Use of_get_display_gpio_enable()
Message-Id: <201304030426.17055.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364953516-7664-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1364953516-7664-2-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Use of_get_display_gpio_enable() helper to retrieve the GPIO from
> devicetree that turns on the display.
> 
> This lets the code smaller and cleaner.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Looks ok,

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
