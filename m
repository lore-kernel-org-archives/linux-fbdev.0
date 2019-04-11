From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 11 Apr 2019 17:23:36 +0000
Subject: Re: [PATCH -next] video: fbdev: atmel_lcdfb: remove set but not used variable 'pdata'
Message-Id: <eb732f69-5f7e-899e-21f8-8dab1056c7ef@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190403072445.42983-1-yuehaibing@huawei.com>
 <CGME20190403082107epcas2p2b26003b0a03a107f4c19abb6f4876f41@epcas2p2.samsung.com>
 <961c397f-1c3c-5f96-5281-3233b34088c3@microchip.com>
In-Reply-To: <961c397f-1c3c-5f96-5281-3233b34088c3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas.Ferre@microchip.com, yuehaibing@huawei.com
Cc: alexandre.belloni@bootlin.com, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org


On 04/03/2019 10:20 AM, Nicolas.Ferre@microchip.com wrote:
> On 03/04/2019 at 09:24, YueHaibing wrote:
>> External E-Mail
>>
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/video/fbdev/atmel_lcdfb.c: In function 'atmel_lcdfb_remove':
>> drivers/video/fbdev/atmel_lcdfb.c:1255:28: warning:
>>   variable 'pdata' set but not used [-Wunused-but-set-variable]
>>
>> It's not used since commit 42110e91de7f ("video: atmel_lcdfb: introduce
>> atmel_lcdfb_power_control")
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Indeed:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
