From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 13 Feb 2019 16:12:42 +0000
Subject: Re: [PATCH v2 1/2] video: lcd: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
Message-Id: <64fd6532-83da-333d-279b-748a34428f97@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
 <CGME20190117161952epcas1p39e54da4b33639ac2b807bc2743b9affa@epcas1p3.samsung.com>
 <20190117161908.4fd2lx62m5soqrff@holly.lan>
 <d75a5e8a-570a-25ca-7a46-ff4195d0ef81@samsung.com>
 <20190212084219.GW20638@dell>
 <1c721088-9bd4-bb88-d6c0-58f73c6f39cc@samsung.com>
 <CAKMK7uHaYAXW2k9Fkb4c365=GQ-y9pDm2n10=k+-xMgX0shgyw@mail.gmail.com>
In-Reply-To: <CAKMK7uHaYAXW2k9Fkb4c365=GQ-y9pDm2n10=k+-xMgX0shgyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Jingoo Han <jingoohan1@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Lee Jones <lee.jones@linaro.org>


On 02/13/2019 04:19 PM, Daniel Vetter wrote:
> On Wed, Feb 13, 2019 at 4:04 PM Bartlomiej Zolnierkiewicz via
> dri-devel <dri-devel@lists.freedesktop.org> wrote:
>>
>>
>> On 02/12/2019 09:42 AM, Lee Jones wrote:
>>> On Fri, 08 Feb 2019, Bartlomiej Zolnierkiewicz wrote:
>>>
>>>>
>>>> On 01/17/2019 05:19 PM, Daniel Thompson wrote:
>>>>> On Thu, Jan 17, 2019 at 04:33:35PM +0300, Alexander Shiyan wrote:
>>>>>> We have two *_CLASS_DEVICE kernel config options (LCD_CLASS_DEVICE
>>>>>> and BACKLIGHT_LCD_DEVICE) that do the same job.
>>>>>> The patch removes useless BACKLIGHT_LCD_SUPPORT option
>>>>>> and converts LCD_CLASS_DEVICE into a menu.
>>>>>>
>>>>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>>>>
>>>>> A cover letter with the v1 -> v2 changelog would be nice... but
>>>>> nevertheless:
>>>>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>>
>>>> Also:
>>>>
>>>> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>
>>>> Lee, will you pick this up or do you want me to do it?
>>>
>>> You can take them if you want.  I will require a pull-request from an
>>> independent immutable branch though please.
>>
>> OK, immutable branch will also allow other trees (drm) to sync with
>> these changes if desired.
>>
>> I will do it for v5.2 if you are fine with it (too late for v5.1
>> IMHO and I also won't have time too fix any potential issues next
>> week).
> 
> Topic branch for these 2 simple patches seems like serious overkill.
> Especially for backlight stuff, which doesn't move fast. Anyway, up to

This depends on the development stage we are in [*]. Right now things
are calm so there is low probability of conflicts and we might just
merge these patches without topic branch.

[*] In case of fbdev/Kconfig FB_CLPS711X config option was modified
in v4.20 and both FB_IMX and FB_MX3 config options still need to be
converted to support COMPILE_TEST so at least in theory there is
a potential for conflicts with fbdev if merged for 5.2.

> you, ack for all the drm patches to go through whatever tree you
> people can agree on. Would be good to get it into 5.1 still though,
> just to avoid too many conflicts.

Well, if so I'm also fine with this going in 5.1 w/o topic branch.

Lee, do you want to merge this directly into backlight tree (you
have now both fbdev and drm acks)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
