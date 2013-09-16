From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Sep 2013 09:28:19 +0000
Subject: Re: [PATCH] video/ps3fb: Fix section mismatch warning
Message-Id: <CAMuHMdWHw-3i8wO4N=FAiQyoFwQzWEfM8FufL-WeHDfS_XuTXw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369141302.3652.14.camel@clam>
In-Reply-To: <1369141302.3652.14.camel@clam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Sep 16, 2013 at 11:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 21/05/13 16:01, Geoff Levand wrote:
>> Remove the __initdata attribute from the ps3fb_fix variable.  This is in
>> follow up to the removal of the __devinit attribute on the ps3fb_probe()
>> routine in commit 48c68c4f1b542444f175a9e136febcecf3e704d8 (Drivers:
>> video: remove __dev* attributes).
>>
>> Fixes build warnings like these:
>>
>>   WARNING: vmlinux.o Section mismatch in reference from the function .ps3fb_probe() to the variable .init.data:ps3fb_fix
>>   The function .ps3fb_probe() references the variable __initdata ps3fb_fix.
>>   This is often because .ps3fb_probe lacks a __initdata annotation or the annotation of ps3fb_fix is wrong.
>>
>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>
> Thanks, applied for 3.13.

Too late. It already got in last week through Cell and PS3 supporter BenH ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
