From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 19 Apr 2015 20:15:57 +0000
Subject: Re: Question abouf FB actual size
Message-Id: <CAMuHMdWd7rDFvUewR-yvzmwz793onPWhL6yo9UZX6C8Hu8tk-w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFAVkqVPVG_h+Kwq-KjdivMWh+2WthJdJvQqRcf1m-qjHTpX1A@mail.gmail.com>
In-Reply-To: <CAFAVkqVPVG_h+Kwq-KjdivMWh+2WthJdJvQqRcf1m-qjHTpX1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Sun, Apr 19, 2015 at 10:01 PM, Paolo Niccolò Giubelli
<paoloniccolo.giubelli@gmail.com> wrote:
> On Sun, Apr 19, 2015 at 9:29 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sun, Apr 19, 2015 at 7:39 PM, Paolo Niccolò Giubelli
>> <paoloniccolo.giubelli@gmail.com> wrote:
>>> There's something wrong with the math, because i have a 1366x768x32
>>> FB, but my finfo.line_length (finfo is obtained via
>>> FBIOGET_FSCREENINFO) is 5504 bytes. Well, 5504/4 (4 is 4 bytes per
>>> pixel) is 1376 that is 10 pixels more than 1366.
>>
>> 1366 * 4 is not a multiple of 64. 5504 is.
>> I guess your hardware requires each line to start at an address which is a
>> multiple of 64.
>
> Thank you Geert! So I guess there's some kind of padding after the end
> of the line, where I can write anything that has no effect. Do you
> know if there's something to check into fb.h so to guess the alignment
> requirements?

The only way to find out is to look at fb_fix_screeninfo.line_length.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
