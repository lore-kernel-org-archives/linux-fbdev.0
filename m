From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Sep 2011 05:17:03 +0000
Subject: Re: [PATCH] gma500: gtt based hardware scrolling console
Message-Id: <CAMuHMdU0Kd2cwaz3F56LywZDqrBJk3_A6PSTgueStAAuwSDtZQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110922184316.25068.54702.stgit@localhost.localdomain>
	<CAMuHMdWBz9+TCBUbaOY3HRv=khiDHkRCKdx5e53HCen54RUBVw@mail.gmail.com>
	<20110922212146.609065b1@lxorguk.ukuu.org.uk>
In-Reply-To: <20110922212146.609065b1@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Thu, Sep 22, 2011 at 22:21, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> > +       info->fix.ywrapstep = gtt_roll;
>>
>> Do you really want to set this? I didn't see any other wrapping
>> support in your patch.
>> However, I guess you can implement wrapping support using the same
>> mapping trick?
>
> It is actually wrapping - it writes the low pages back below the high
> ones so it works the GTT as a circular buffer - or am I misunderstanding
> this.

Then it should not set ypanstep to a non-zero value, and set/handle the other
various *YWRAP flags, to communicate with the frame buffer console driver.

Panning is moving inside a virtual screen bigger than the visible screen size.

> One thing I wasn't sure of on the fb side. If I've got a display width
> that is annoying and can't fit on a 4Kbyte stride am I right in thinking
> I can set this to say 8 and use a 512 byte stride and still get
> acceleration for the usual font choice ?

Yep, that should work. The console code can use ywrap resp. ypan if the
font height is a multiple of ywrapstep resp. ypanstep.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
