From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 12:06:28 +0000
Subject: Re: [PATCH][next] video: fbdev: atmel_lcdfb: remove redundant initialization to variable ret
Message-Id: <fae5c288-cf9b-5b54-1aeb-06126f140b84@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190611170913.20913-1-colin.king@canonical.com>
        <37ac8530-6601-a1a0-37e0-8c6d5d1702cd@microchip.com>
        <CGME20190612141513epcas2p32873b9574f918732b4cf8a6838cdd54d@epcas2p3.samsung.com>
        <20190612141356.riiesqub4zvxafh3@M43218.corp.atmel.com>
In-Reply-To: <20190612141356.riiesqub4zvxafh3@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <Nicolas.Ferre@microchip.com>, Colin King <colin.king@canonical.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 6/12/19 4:13 PM, Ludovic Desroches wrote:
> On Wed, Jun 12, 2019 at 09:55:30AM +0200, Nicolas Ferre - M43238 wrote:
>> On 11/06/2019 at 19:09, Colin King wrote:
>>> External E-Mail
>>>
>>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently variable ret is being initialized with -ENOENT however that
>>> value is never read and ret is being re-assigned later on. Hence this
>>> assignment is redundant and can be removed.
>>>
>>> Addresses-Coverity: ("Unused value")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> Indeed:
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
