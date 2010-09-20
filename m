From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Sep 2010 08:27:37 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <AANLkTimH4HmxH=gcX7-=t64pHttQjrhm9XkxnnpQYR1S@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home>
	<4C963E99.9080207@gmx.de>
In-Reply-To: <4C963E99.9080207@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

On Sun, Sep 19, 2010 at 18:47, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> Bruno Prémont schrieb:
>> diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
>> index 0a08f13..be5f342 100644
>> --- a/drivers/video/fbsysfs.c
>> +++ b/drivers/video/fbsysfs.c
>> @@ -58,6 +58,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct
>> device *dev)
>>                info->par = p + fb_info_size;
>>        info->device = dev;
>> +       kref_init(&info->refcount);
>
> As far as I know there exist framebuffer drivers which do not call
> framebuffer_alloc but contain their own fb_info. I guess these would be
> broken as well.

Those should be converted to framebuffer_alloc() anyway. Janitors?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
