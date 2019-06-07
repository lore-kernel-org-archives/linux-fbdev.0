From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Jun 2019 12:25:59 +0000
Subject: Re: [PATCH v3] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
Message-Id: <7f6b5d26-de84-c38a-7510-fee1f7e7eea3@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190530123016eucas1p2e18747b8ac1d156657232eab52876a61@eucas1p2.samsung.com>
        <69cd6b8b-1fd1-86fa-2070-99d0ce15a868@samsung.com>
        <20190601210651.GB3558@piout.net>
In-Reply-To: <20190601210651.GB3558@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


On 6/1/19 11:06 PM, Alexandre Belloni wrote:
> On 30/05/2019 14:30:19+0200, Bartlomiej Zolnierkiewicz wrote:
>> Add COMPILE_TEST support to atmel_lcdfb driver for better compile
>> testing coverage.
>>
>> While at it fix improper use of UL (to silence build warnings on
>> x86_64).
>>
>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks, I queued the patch for v5.3.

>> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>> v3: fix build warnings on x86_64
> 
> Hopefully, no building errors anymore ;)

I hope so. :)

>> v2: add missing HAVE_CLK && HAS IOMEM dependencies
>>
>>  drivers/video/fbdev/Kconfig       |    3 ++-
>>  drivers/video/fbdev/atmel_lcdfb.c |    4 ++--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
