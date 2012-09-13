From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Sep 2012 19:06:35 +0000
Subject: Re: [PATCH 2/5] drivers/video/gbefb.c: use devm_ functions
Message-Id: <CAMuHMdWsiXmt=2uo3C8ZC_apnHRV2aHi3yZrYV_jgwB22=3Mfw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343752762-16861-1-git-send-email-damien.cassou@lifl.fr>
	<1343752762-16861-3-git-send-email-damien.cassou@lifl.fr>
	<50369498.4010006@gmx.de>
In-Reply-To: <50369498.4010006@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Damien Cassou <damien.cassou@lifl.fr>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 23, 2012 at 10:37 PM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> On 07/31/2012 04:39 PM, Damien Cassou wrote:
>> From: Damien Cassou <damien.cassou@lifl.fr>
>>
>> The various devm_ functions allocate memory that is released when a driver
>> detaches.  This patch uses these functions for data that is allocated in
>> the probe function of a platform device and is only freed in the remove
>> function.
>>
>> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>
>
> Applied.

>> diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
>> index 7e7b7a9..9b79d38 100644
>> --- a/drivers/video/gbefb.c
>> +++ b/drivers/video/gbefb.c
>> @@ -1156,7 +1156,8 @@ static int __devinit gbefb_probe(struct platform_device *p_dev)
>>               goto out_release_framebuffer;
>>       }
>>
>> -     gbe = (struct sgi_gbe *) ioremap(GBE_BASE, sizeof(struct sgi_gbe));
>> +     gbe = (struct sgi_gbe *) devm_ioremap(&p_dev->dev, GBE_BASE,
>> +                                           sizeof(struct sgi_gbe));

drivers/video/gbefb.c:1159:16: error: implicit declaration of function
'devm_ioremap' [-Werror=implicit-function-declaration]
drivers/video/gbefb.c:1179:3: error: implicit declaration of function
'devm_ioremap_nocache' [-Werror=implicit-function-declaration]

http://kisskb.ellerman.id.au/kisskb/buildresult/7187731/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
