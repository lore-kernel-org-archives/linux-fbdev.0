From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 21 Jun 2014 21:32:43 +0000
Subject: Re: [PATCH] video: fbdev: skeletonfb.c: Adding code to managing allocation error
Message-Id: <CAFo99gYbiKa50crxEf4YA7voRTe0qj_9aXdTBwvU=J2EjwywaA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403356646-29443-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	<1403359116.4076.44.camel@joe-AO725>
	<CAMuHMdVJ=sA7ixyA+4BSffD1fzWOMwGivEQGZ+UN437VTw_xpw@mail.gmail.com>
In-Reply-To: <CAMuHMdVJ=sA7ixyA+4BSffD1fzWOMwGivEQGZ+UN437VTw_xpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joe Perches <joe@perches.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi

Sounds like a good idea to have better error handling although it is
an example, even more important there.

At the first return nothing has been allocated, so it's ok I guess.
At the second I reflect about adding some deallocation, there are
comments on some form of goto error part which would appropriately
handle a deallocation. But all the other places in the code is just do
a return, that was why I chose to do it at the second return to.


Kind regards
Rickard Strandqvist


2014-06-21 22:48 GMT+02:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Sat, Jun 21, 2014 at 3:58 PM, Joe Perches <joe@perches.com> wrote:
>> (Adding Geert, who probably wrote most of this
>>  and likely might have forgotten all of it)
>>
>> On Sat, 2014-06-21 at 15:17 +0200, Rickard Strandqvist wrote:
>>> Adding missing code for managing a memory allocation error that may occur.
>>>
>>> This was partly found using a static code analysis program called cppcheck.
>>
>> skeletonfb.c is not meant to be compiled.
>> It's a sample driver template.
>
> Yep.
>
>> Those /* goto error path */ lines are for
>> driver writers that use this to figure out
>> what to do.
>
> Still, it's nice if a sample driver has correct error handling.
> Just comments are not good enough as guidance for some people ;-)
>
>> The second return is not correct as it would
>> not free the first alloc'd block.
>
> Indeed. Better do it right.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
