From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 Jun 2014 20:48:37 +0000
Subject: Re: [PATCH] video: fbdev: skeletonfb.c: Adding code to managing allocation error
Message-Id: <CAMuHMdVJ=sA7ixyA+4BSffD1fzWOMwGivEQGZ+UN437VTw_xpw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403356646-29443-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	<1403359116.4076.44.camel@joe-AO725>
In-Reply-To: <1403359116.4076.44.camel@joe-AO725>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jun 21, 2014 at 3:58 PM, Joe Perches <joe@perches.com> wrote:
> (Adding Geert, who probably wrote most of this
>  and likely might have forgotten all of it)
>
> On Sat, 2014-06-21 at 15:17 +0200, Rickard Strandqvist wrote:
>> Adding missing code for managing a memory allocation error that may occur.
>>
>> This was partly found using a static code analysis program called cppcheck.
>
> skeletonfb.c is not meant to be compiled.
> It's a sample driver template.

Yep.

> Those /* goto error path */ lines are for
> driver writers that use this to figure out
> what to do.

Still, it's nice if a sample driver has correct error handling.
Just comments are not good enough as guidance for some people ;-)

> The second return is not correct as it would
> not free the first alloc'd block.

Indeed. Better do it right.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
