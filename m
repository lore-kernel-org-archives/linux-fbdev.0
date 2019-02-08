From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:19:20 +0000
Subject: Re: [PATCH v2 1/2] video: lcd: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
Message-Id: <d75a5e8a-570a-25ca-7a46-ff4195d0ef81@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
 <CGME20190117161952epcas1p39e54da4b33639ac2b807bc2743b9affa@epcas1p3.samsung.com>
 <20190117161908.4fd2lx62m5soqrff@holly.lan>
In-Reply-To: <20190117161908.4fd2lx62m5soqrff@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


On 01/17/2019 05:19 PM, Daniel Thompson wrote:
> On Thu, Jan 17, 2019 at 04:33:35PM +0300, Alexander Shiyan wrote:
>> We have two *_CLASS_DEVICE kernel config options (LCD_CLASS_DEVICE
>> and BACKLIGHT_LCD_DEVICE) that do the same job.
>> The patch removes useless BACKLIGHT_LCD_SUPPORT option
>> and converts LCD_CLASS_DEVICE into a menu.
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> A cover letter with the v1 -> v2 changelog would be nice... but
> nevertheless:
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Also:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Lee, will you pick this up or do you want me to do it?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
