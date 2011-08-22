From: Axel Lin <axel.lin@gmail.com>
Date: Mon, 22 Aug 2011 00:06:32 +0000
Subject: Re: [PATCH] video: ep93xx-fb: add missing include of linux/module.h
Message-Id: <CAF+7xWkezyMrnt-_0EVtNWtAB2v7pceATB8HEbdC8oqOY0camw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313937545.13671.5.camel@phoenix> <4E5197B8.8020608@gmail.com> <4E519AC7.3030001@gmail.com>
In-Reply-To: <4E519AC7.3030001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ryan Mallon <rmallon@gmail.com>
Cc: linux-kernel@vger.kernel.org, H Hartley Sweeten <hsweeten@visionengravers.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

2011/8/22 Ryan Mallon <rmallon@gmail.com>:
> On 22/08/11 09:41, Ryan Mallon wrote:
>>
>> On 22/08/11 00:39, Axel Lin wrote:
>>>
>>> ep93xx-fb.c uses interfaces from linux/module.h,
>>> so it should include that file. =A0This patch fixes below build errors.
>>
>> What actually changed to make these files broken? Did some other header
>> previously include module.h for us? How many other drivers are broken?
>>
>> Anyway, the change is okay.
>>
>> Acked-by: Ryan Mallon <rmallon@gmail.com>
>
> Actually, having a second look at this it does not look right.
>
> drivers/video/ep93xx-fb.c includes linux/platform.h (as its first include=
),
> which includes linux/driver.h, which includes linux/module.h.
>
> Just tested on Linus' latest tree and both this driver and the ep93xx
> backlight driver build fine. What kernel version are you using?
>
> ~Ryan

hi Ryan,

The patch is against linux-next tree.
I got build error for ep93xx-fb.c and ep93xx_bl.c on linux-next tree.
( next-20110819 )

Regards,
Axel

>
>
>>
>>> =A0 CC =A0 =A0 =A0drivers/video/ep93xx-fb.o
>>> drivers/video/ep93xx-fb.c:120: error: expected ')' before 'int'
>>> drivers/video/ep93xx-fb.c:122: error: expected ')' before string consta=
nt
>>> drivers/video/ep93xx-fb.c:409: error: 'THIS_MODULE' undeclared here (not
>>> in a function)
>>> drivers/video/ep93xx-fb.c:645: error: expected declaration specifiers or
>>> '...' before string constant
>>> drivers/video/ep93xx-fb.c:645: warning: data definition has no type or
>>> storage class
>>> drivers/video/ep93xx-fb.c:645: warning: type defaults to 'int' in
>>> declaration of 'MODULE_DESCRIPTION'
>>> drivers/video/ep93xx-fb.c:645: warning: function declaration isn't a
>>> prototype
>>> drivers/video/ep93xx-fb.c:646: error: expected declaration specifiers or
>>> '...' before string constant
>>> drivers/video/ep93xx-fb.c:646: warning: data definition has no type or
>>> storage class
>>> drivers/video/ep93xx-fb.c:646: warning: type defaults to 'int' in
>>> declaration of 'MODULE_ALIAS'
>>> drivers/video/ep93xx-fb.c:646: warning: function declaration isn't a
>>> prototype
>>> drivers/video/ep93xx-fb.c:647: error: expected declaration specifiers or
>>> '...' before string constant
>>> drivers/video/ep93xx-fb.c:647: warning: data definition has no type or
>>> storage class
>>> drivers/video/ep93xx-fb.c:647: warning: type defaults to 'int' in
>>> declaration of 'MODULE_AUTHOR'
>>> drivers/video/ep93xx-fb.c:647: warning: function declaration isn't a
>>> prototype
>>> drivers/video/ep93xx-fb.c:649: error: expected declaration specifiers or
>>> '...' before string constant
>>> drivers/video/ep93xx-fb.c:649: warning: data definition has no type or
>>> storage class
>>> drivers/video/ep93xx-fb.c:649: warning: type defaults to 'int' in
>>> declaration of 'MODULE_LICENSE'
>>> drivers/video/ep93xx-fb.c:649: warning: function declaration isn't a
>>> prototype
>>> make[2]: *** [drivers/video/ep93xx-fb.o] Error 1
>>> make[1]: *** [drivers/video] Error 2
>>> make: *** [drivers] Error 2
>>>
>>> Signed-off-by: Axel Lin<axel.lin@gmail.com>
>>> ---
>>> =A0drivers/video/ep93xx-fb.c | =A0 =A01 +
>>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
>>> index 40e5f17..8133a9d 100644
>>> --- a/drivers/video/ep93xx-fb.c
>>> +++ b/drivers/video/ep93xx-fb.c
>>> @@ -17,6 +17,7 @@
>>> =A0 *
>>> =A0 */
>>>
>>> +#include<linux/module.h>
>>> =A0#include<linux/platform_device.h>
>>> =A0#include<linux/dma-mapping.h>
>>> =A0#include<linux/slab.h>
>>
>
>
