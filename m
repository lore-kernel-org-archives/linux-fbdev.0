From: Damian <dhobsong@igel.co.jp>
Date: Wed, 23 Feb 2011 11:22:36 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <4D64EDFC.6070203@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


>> diff --git a/include/linux/sh_mobile_fb.h b/include/linux/sh_mobile_fb.h
>> new file mode 100644
>> index 0000000..ec448bc
>> --- /dev/null
>> +++ b/include/linux/sh_mobile_fb.h
>> @@ -0,0 +1,14 @@
>> +/*
>> + * SH-Mobile High-Definition Multimedia Interface (HDMI)
>> + *
>> + * Copyright (C) 2011, Damian Hobson-Garciax<dhobsong@igel.co.jp>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef SH_MOBILE_FB_H
>> +#define SH_MOBILE_FB_H
>> +
>> +#define SH_FB_YUV	0x1
>> +#endif /* SH_MOBILE_FB_H */
>> diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
>> index daabae5..650ff17 100644
>> --- a/include/video/sh_mobile_lcdc.h
>> +++ b/include/video/sh_mobile_lcdc.h
>> @@ -77,6 +77,7 @@ struct sh_mobile_lcdc_chan_cfg {
>>   	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
>>   	struct sh_mobile_lcdc_board_cfg board_cfg;
>>   	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
>> +	int nonstd;
>>   };
>>
>>   struct sh_mobile_lcdc_info {
>> --
>> 1.7.1
>
> Can't the SH_FB_YUV macro definition go into
> include/video/sh_mobile_lcdc.h too?

My thinking behind separating this out was that I wanted this
define to be accessible from user space.  The reason is so that
an application can test the value of .nonstd against the flag to
know for sure if it is dealing with a YUV framebuffer or not.
I was under the impression that only headers under include/linux/ should 
be accessed from user space, but to be honest, I'm not sure about that.
If that is in fact not the case, then I totally agree that it can go
into include/video/sh_mobile_lcdc.h.
Do you know where the proper place for such a header would be?

>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/

Thanks,
Damian
-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
