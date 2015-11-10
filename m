From: Heiko Stuebner <heiko@sntech.de>
Date: Tue, 10 Nov 2015 14:18:10 +0000
Subject: Re: [PATCH v4] pwm-backlight: Avoid backlight flicker when probed from DT
Message-Id: <3447562.c3gSANEMio@phil>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1446483356-14338-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1446483356-14338-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Philipp,

Am Montag, 2. November 2015, 17:55:56 schrieb Philipp Zabel:
> If the driver is probed from the device tree, and there is a phandle
> property set on it, and the enable GPIO is already configured as output,
> and the backlight is currently disabled, keep it disabled.
> If all these conditions are met, assume there will be some other driver
> that can enable the backlight at the appropriate time.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

this patch improves the white screen when booting a veyron chromebook
a lot. I still see a small white flash, but that can probably come from
the WIP edp driver.

Tested-by: Heiko Stuebner <heiko@sntech.de>
