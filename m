From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Dec 2011 20:16:59 +0000
Subject: Re: Should I use FBINFO_VIRTFB?
Message-Id: <CAMuHMdULFdR4tRED10=pduizWw8CbtdJcXSVDtVWnyo=_-rFJQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EEA5DA7.3010406@freescale.com>
In-Reply-To: <4EEA5DA7.3010406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 16, 2011 at 19:18, Timur Tabi <timur@freescale.com> wrote:
> Geert Uytterhoeven wrote:
>> This depends on which of these two is fastest for scrolling the console:
>>   - panning the virtual screen and redrawing the missing part: set
>> FBINFO_PARTIAL_PAN_OK
>>   - copying or redrawing the screen: don't set FBINFO_PARTIAL_PAN_OK
>
> I'm a little confused about panning support in my driver (which I didn't write -- I'm just cleaning it up).  There is .fb_pan_display function, but it only gets called early in the boot process, and only with xoffset=0 and yoffset=0.  After that, it never seems to get called again.  Under what circumstances is panning really used?

Is yres_virtual larger than yres? Is the font size a multiple of ypanstep?
If not, panning is disabled.

>>> I have the same problem with FBINFO_READS_FAST.
>>
>> You should set this flag if reading from frame buffer memory is a fast
>> operation.
>> On many graphics devices, reading from frame buffer memory is much slower
>> than writing. As you use system RAM, you probably want to set it.
>
> I see a lot of drivers that set FBINFO_VIRTFB but don't set FBINFO_READS_FAST.  Why?
>
>> If this flag is set, scrolling is implemented by copying memory around.
>> If not set, scrolling is implemented by redrawing the whole screen.
>>
>> A simple way to find the optimal settings of both flags (all 4 combinations) is
>> running "clear; time cat big_text_file" and comparing the timing results
>
> That's the funny thing -- I've been trying various combinations of FBINFO_VIRTFB, FBINFO_PARTIAL_PAN_OK, and FBINFO_READS_FAST, and I always get the same timing result.  It seems to have no affect on performance.

If panning is disabled, FBINFO_PARTIAL_PAN_OK doesn't do anything.
For FBINFO_READS_FAST, I can imagine that with a fast CPU and a good
writeback cache, redrawing the screen is as fast as copying data around.

It just means your hardware is well balanced ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
