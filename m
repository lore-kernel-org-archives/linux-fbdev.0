From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 03 Jan 2017 14:11:33 +0000
Subject: RE: [PATCH] backlight: da9052: Fix module autoload
Message-Id: <2E89032DDAA8B9408CB92943514A03370142A753C0@SW-EX-MBX01.diasemi.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1483373008-9905-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1483373008-9905-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Javier Martinez Canillas <javier@osg.samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Support Opensource <Support.Opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>

On 02 January 2017 16:03, Javier Martinez Canillas wrote:

> The driver has a platform device ID table with multiple device entries,
> each setting a different register address in its driver_data to control
> the WLED brightness.
> 
> But the driver doesn't export these as aliases with MODULE_DEVICE_TABLE()
> when the driver is built as a module, instead it just has a single alias
> using MODULE_ALIAS("platform:da9052-backlight"). That is clearly wrong
> since there isn't a "da9052-backlight" in the platform device ID table,
> so if that device name is used, the device won't even match the driver.
> 
> So instead of having a wrong alias, export the ones in the dev ID table.
> 
> Before this patch:
> 
> $ modinfo drivers/video/backlight/da9052_bl.ko | grep alias
> alias:          platform:da9052-backlight
> 
> After this patch:
> 
> $ modinfo drivers/video/backlight/da9052_bl.ko | grep alias
> alias:          platform:da9052-wled3
> alias:          platform:da9052-wled2
> alias:          platform:da9052-wled1
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
