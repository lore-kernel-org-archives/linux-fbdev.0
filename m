From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Feb 2014 08:03:39 +0000
Subject: Re: [PATCH 0/3] Reorder drivers/video directory
Message-Id: <CAMuHMdVcXmukvrJ7KYNY5WJPgS3=oOqsfvb3k89UANx_6QBTKA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393502086-9433-1-git-send-email-tomi.valkeinen@ti.com>
	<530F80ED.1040509@infradead.org> <5310359F.2040904@ti.com>
In-Reply-To: <5310359F.2040904@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Fri, Feb 28, 2014 at 8:07 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 27/02/14 20:16, Randy Dunlap wrote:
>> On 02/27/2014 03:54 AM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> This is a re-send of the series, with RFC removed from the subject, and a bunch
>>> of acks added.
>>>
>>> I'm cc'ing more people, to make sure this doesn't come as a surprise, and to
>>> make sure this is not a bad idea, doomed to fail horribly.
>>
>> What does this patch apply to?  I can't get it to apply cleanly to
>> -rc4 or Linus's current git tree.
>>
>> I like what I see so far.
>
> My branch was based on -rc2. Some minor fbdev fixes went in after that,
> and they seem to break the apply. I think the drivers/video/Kconfig and
> drivers/video/Makefile are the most problematic ones, any change there
> will conflict badly.

So you want to do the move based on one of the later -rcs, to avoid conflicits.
-rc5 may be too late, but it's up to Linus to decide.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
