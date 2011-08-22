From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Mon, 22 Aug 2011 16:40:57 +0000
Subject: RE: [PATCH] video: ep93xx-fb: add missing include of linux/module.h
Message-Id: <ADE657CA350FB648AAC2C43247A983F001F388575258@AUSP01VMBX24.collaborationhost.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313937545.13671.5.camel@phoenix> <4E5197B8.8020608@gmail.com>
 <4E519AC7.3030001@gmail.com>
 <CAF+7xWkezyMrnt-_0EVtNWtAB2v7pceATB8HEbdC8oqOY0camw@mail.gmail.com>
 <4E51A34C.6060207@gmail.com>
In-Reply-To: <4E51A34C.6060207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ryan Mallon <rmallon@gmail.com>, "axel.lin@gmail.com" <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>

On Sunday, August 21, 2011 5:31 PM, Ryan Mallon wrote:
> On 22/08/11 10:06, Axel Lin wrote:
>> 2011/8/22 Ryan Mallon<rmallon@gmail.com>:
>>> On 22/08/11 09:41, Ryan Mallon wrote:
>>>> On 22/08/11 00:39, Axel Lin wrote:
>>>>> ep93xx-fb.c uses interfaces from linux/module.h,
>>>>> so it should include that file.  This patch fixes below build errors.
>>>> What actually changed to make these files broken? Did some other header
>>>> previously include module.h for us? How many other drivers are broken?
>>>>
>>>> Anyway, the change is okay.
>>>>
>>>> Acked-by: Ryan Mallon<rmallon@gmail.com>
>>> Actually, having a second look at this it does not look right.
>>>
>>> drivers/video/ep93xx-fb.c includes linux/platform.h (as its first include),
>>> which includes linux/driver.h, which includes linux/module.h.
>>>
>>> Just tested on Linus' latest tree and both this driver and the ep93xx
>>> backlight driver build fine. What kernel version are you using?
>>>
>>> ~Ryan
>> hi Ryan,
>>
>> The patch is against linux-next tree.
>> I got build error for ep93xx-fb.c and ep93xx_bl.c on linux-next tree.
>> ( next-20110819 )
>
> Ok, I see now. The change which caused the breakage is fdb697c: 
> "include: replace linux/module.h with "struct module" wherever 
> possible". How many other drivers got broken now that device.h does not 
> include module.h?

Probably a lot...  Which is one of the reasons linux-next exists.. . ;-)

Actually, Paul Gortmaker caused this breakage with the commit.  He should
take a deeper look and see what it broke.  From his commit:

    Most of the implicit dependencies on module.h being present by
    these headers pulling it in have been now weeded out, so we can
    finally make this change with hopefully minimal breakage.

Regards,
Hartley