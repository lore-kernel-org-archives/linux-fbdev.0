From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 22 Dec 2017 17:33:37 +0000
Subject: Re: [PATCH] backlight: otm3225a: add support for ORISE OTM3225A LCD SoC
Message-Id: <8288d7dc-8a53-695b-3e88-139d5c8fe555@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1513792670-4114-1-git-send-email-fb@ltec.ch>
 <000601d37b49$89598210$9c0c8630$@gmail.com>
In-Reply-To: <000601d37b49$89598210$9c0c8630$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>, 'Felix Brack' <fb@ltec.ch>, linux-fbdev@vger.kernel.org
Cc: lee.jones@linaro.org, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org

On 22/12/17 17:23, Jingoo Han wrote:>> diff --git 
a/drivers/video/backlight/otm3225a.c
>> b/drivers/video/backlight/otm3225a.c
>> new file mode 100644
>> index 0000000..0de75f8
>> --- /dev/null
>> +++ b/drivers/video/backlight/otm3225a.c
>> @@ -0,0 +1,210 @@
>> +/*
>> + * Driver for ORISE Technology OTM3225A SOC for TFT LCD
>> + *
>> + * Copyright (C) 2014-2017, EETS GmbH, Felix Brack <fb@ltec.ch>
> 
> Please change the year of copyright as below. >
> + * Copyright (C) 2017, EETS GmbH, Felix Brack <fb@ltec.ch>

... and include (or just rely entirely on) a SPDX header to describe the 
licensing of the file.


Daniel.
