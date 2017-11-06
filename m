From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Mon, 06 Nov 2017 10:06:15 +0000
Subject: Re: video: atmel_lcdfb: Use common error handling code in atmel_lcdfb_of_init()
Message-Id: <2d650d87-034c-d05b-b3aa-f689f25ab184@microchip.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2db677d2-ad4e-1f79-344b-dfa38ce948c9@users.sourceforge.net>
 <5477205e-2067-de4f-8736-71a2c9dc1653@microchip.com>
 <8d297cae-5dd1-d345-8d9d-9bf3ec32d4f8@users.sourceforge.net>
In-Reply-To: <8d297cae-5dd1-d345-8d9d-9bf3ec32d4f8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 06/11/2017 at 10:32, SF Markus Elfring wrote:
>> Sorry but NACK: the message was malformed and resulted in the
>> duplication of the error log that you spotted.
>>
>> The proper way to fix this is to modify the second occurrence of this message.
> 
> * Would you like to achieve that a corresponding message will mention
>   anything around a property “atmel,dmacon” (instead of “bits-per-pixel”)?

Yes: that would actually fix the wrong log message.

> * Can it make sense to adjust the used message format then?

In another patch, why not... Beware about the added complexity though.

Regards,
-- 
Nicolas Ferre
