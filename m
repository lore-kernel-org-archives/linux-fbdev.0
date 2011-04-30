From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 30 Apr 2011 18:30:26 +0000
Subject: Re: fbdev test application
Message-Id: <BANLkTi=VMYQHYs5MHpW6V7ydnEDrm28-Sw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104301643.23482.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201104301643.23482.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On Sat, Apr 30, 2011 at 19:31, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Saturday 30 April 2011 19:13:47 Geert Uytterhoeven wrote:
>> On Sat, Apr 30, 2011 at 16:43, Laurent Pinchart
>> > I've developed a small fbdev application for internal test purpose that
>> > might be useful to other developers, so I'm releasing it under the GPL.
>>
>> Have you ever looked at
>> http://git.kernel.org/?p=linux/kernel/git/geert/fbtest.git,
>> which is a git clone of CVS module FBdev/utlilities/fbtest of project
>> linux-fbdev on sf.net?
>
> I've seen the project, but my fbdev test application serves slightly different
> purposes, as I wanted to control FB devices from the command line, not run a

Ah, so it's more like fbset.

> test suite. It was also a way for me to learn the FB API, no existing
> application could have properly helped me there :-)

IC...

> I see that fbtest.git hasn't been updated for quite some time. Do you think we
> should try to merge the projects ?

Perhaps, if you're willing to spend time on it. I don't think I can
work much on it
currently.

One big advantage of fbtest is that it knows how to draw on whatever
frame buffer
format and visual, while most fbdev apps support cfb8 in pseudocolor
and cfb32 in
truecolor only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
