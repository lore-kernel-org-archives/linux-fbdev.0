From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Fri, 03 Dec 2010 11:26:09 +0000
Subject: Re: [PATCH v4+] viafb: I2C/DDC LCD detection for VIA framebuffer
Message-Id: <4CF8D3D1.3010404@bspu.unibel.by>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CED3DD5.5080405@bspu.unibel.by>
In-Reply-To: <4CED3DD5.5080405@bspu.unibel.by>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Paul Mundt wrote:

>> diff -pruN a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
>> --- a/drivers/video/via/via-core.c	2010-11-24 00:12:22.000000000 +0200
>> +++ b/drivers/video/via/via-core.c	2010-11-24 17:04:00.749999967 +0200
>> @@ -2,6 +2,7 @@
>>   * Copyright 1998-2009 VIA Technologies, Inc. All Rights Reserved.
>>   * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
>>   * Copyright 2009 Jonathan Corbet <corbet@lwn.net>
>> + * Copyright 2010 Dzianis Kahanovich <mahatma@eu.by>
>>   */
>>
>>  /*
>> @@ -16,6 +17,8 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>>
>> +extern char *viafb_active_dev;
>> +
> This belongs in viafbdev.h.

But not visible here. Must add "#include" instead?

>> diff -pruN a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
>> --- a/drivers/video/via/viafbdev.c	2010-11-21 11:34:11.000000000 +0200
>> +++ b/drivers/video/via/viafbdev.c	2010-11-24 00:14:48.070000002 +0200
>> @@ -43,7 +43,7 @@ static int viafb_second_size;
>>  static int viafb_accel = 1;
>>
>>  /* Added for specifying active devices.*/
>> -char *viafb_active_dev;
>> +char *viafb_active_dev = NULL;
>>
> 
> This you can just drop.

Hmm. OK, removed. But only if you sure in memory model or else. But I still sure
this variable still uninitialized by default (fixme?) and I found many zeroed
global variables in tree. Keep to your opinion.

> Since viafb has an active tree, I'll leave this for the viafb folks to
> pick up at their leisure.

While I not answering - I found bug. Resolution may be unset at least in
fb_parse_edid() code. v5 will be sent.

-- 
WBR, Dzianis Kahanovich AKA Denis Kaganovich, http://mahatma.bspu.unibel.by/
