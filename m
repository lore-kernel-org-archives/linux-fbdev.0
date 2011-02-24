From: Damian <dhobsong@igel.co.jp>
Date: Thu, 24 Feb 2011 03:38:41 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <4D65D2C1.2050200@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus,
On 2011/02/24 8:28, Magnus Damm wrote:
> Hi Damian,
>
> On Wed, Feb 23, 2011 at 8:22 PM, Damian<dhobsong@igel.co.jp>  wrote:
>>
>>>> diff --git a/include/linux/sh_mobile_fb.h b/include/linux/sh_mobile_fb.h
>>>> new file mode 100644
>>>> index 0000000..ec448bc
>>>> --- /dev/null
>>>> +++ b/include/linux/sh_mobile_fb.h
>>>> @@ -0,0 +1,14 @@
>>>> +/*
>>>> + * SH-Mobile High-Definition Multimedia Interface (HDMI)
>>>> + *
>>>> + * Copyright (C) 2011, Damian Hobson-Garciax<dhobsong@igel.co.jp>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +#ifndef SH_MOBILE_FB_H
>>>> +#define SH_MOBILE_FB_H
>>>> +
>>>> +#define SH_FB_YUV      0x1
>>>> +#endif /* SH_MOBILE_FB_H */
>>>> diff --git a/include/video/sh_mobile_lcdc.h
>>>> b/include/video/sh_mobile_lcdc.h
>>>> index daabae5..650ff17 100644
>>>> --- a/include/video/sh_mobile_lcdc.h
>>>> +++ b/include/video/sh_mobile_lcdc.h
>>>> @@ -77,6 +77,7 @@ struct sh_mobile_lcdc_chan_cfg {
>>>>         struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
>>>>         struct sh_mobile_lcdc_board_cfg board_cfg;
>>>>         struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn
>>>> I/F */
>>>> +       int nonstd;
>>>>   };
>>>>
>>>>   struct sh_mobile_lcdc_info {
>>>> --
>>>> 1.7.1
>>>
>>> Can't the SH_FB_YUV macro definition go into
>>> include/video/sh_mobile_lcdc.h too?
>>
>> My thinking behind separating this out was that I wanted this
>> define to be accessible from user space.  The reason is so that
>> an application can test the value of .nonstd against the flag to
>> know for sure if it is dealing with a YUV framebuffer or not.
>
> Hm, but ideally we want something standard. How do you know the nonstd
> flag is working as you expect from user space? All of a sudden you
> have code that depends on what type of fbdev driver you are using.
> This is ugly, but abstracting the nonstd interface does not make it
> better IMO.
>
> The nonstd thing is a hack, but for now it is close enough. V4L2 has
> standard NV12/NV16 support already, but I don't think there is any
> such thing for fbdev. So i see your patches as a stop-gap, but I
> really don't want to make it more complicated than it has to be. So
> exporting nonstd values in a header file to user space seems too
> complicated IMO.
>
> Please just live with the fact that nonstd is special for now. We need
> to rework the entire LCDC/HDMI/DSI area to support multiple planes and
> better PM anyway. Perhaps KMS is the way forward, or perhaps Media
> Controller? Maybe both?
>
>> I was under the impression that only headers under include/linux/ should be
>> accessed from user space, but to be honest, I'm not sure about that.
>> If that is in fact not the case, then I totally agree that it can go
>> into include/video/sh_mobile_lcdc.h.
>
> Please ditch the SH_FB_YUV constant all together. No need to build
> some abstraction on top of a hackish interface. Just check if nonstd
> is non-zero in the driver and assume that means YUV for now. That's
> good enough.
>

Ok, I see what you're saying. But if the SH_FB_YUV flag is disappearing, 
I guess it makes sense to ditch the second patch in this series as well, 
since that's just further abstraction (albeit locally).

> Thanks,
>
> / magnus

Thank you,
-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
