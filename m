From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Jan 2015 13:58:16 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <CAMuHMdVTmuToU8iagmhzEu=0FJcW-mk4d5RfvK+4cE2v6_vuhQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Maxime,

On Fri, Jan 9, 2015 at 12:03 PM, maxime.ripard@free-electrons.com
<maxime.ripard@free-electrons.com> wrote:
>> > can fbtest
>> > (https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/)
>> > be used to to draw something ?
>> >
>> how do I set pixels of it ? Please if you can point me to some stuff that would be helpful.
>
> Last time I tried, fbtest didn't support monochrome display.

Really?

On ARAnyM:

atari:~# fbset -i

mode "640x480-60"
    # D: 25.176 MHz, H: 31.470 kHz, V: 59.943 Hz
    geometry 640 480 640 972 1
    timings 39720 42 18 31 11 100 3
    rgba 1/0,1/0,1/0,0/0
endmode

Frame buffer device information:
    Name        : Atari Builtin
    Address     : 0x67a000
    Size        : 311296
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 32
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 80
    Accelerator : Atari Blitter
atari:~# ./m68k-linux-gnu-fbtest
Using drawops planar (monochrome and (interleaved) bitplanes)
Available visuals:
  Monochrome
  Grayscale 2
  Pseudocolor 2
Using visops pseudocolor
Running all tests
test001: PASSED
test002: PASSED
test004: PASSED
test005: PASSED
test006: PASSED
test009: PASSED
test011: PASSED
Benchmarking... 10x10 squares: 17.25 Mpixels/s
Benchmarking... 20x20 squares: 40.96 Mpixels/s
Benchmarking... 50x50 squares: 102.41 Mpixels/s
Benchmarking... 100x100 squares: 195.06 Mpixels/s
Benchmarking... 200x200 squares: 348.61 Mpixels/s
Benchmarking... 500x500 squares: 742.07 Mpixels/s
test012: PASSED
Benchmarking... triangles of max size 10: 139444.38 triangles/s
Benchmarking... triangles of max size 20: 107443.29 triangles/s
Benchmarking... triangles of max size 50: 71237.96 triangles/s
Benchmarking... triangles of max size 100: 40962.10 triangles/s
Benchmarking... triangles of max size 200: 23407.09 triangles/s
Benchmarking... triangles of max size 500: 9102.64 triangles/s
test013: PASSED
atari:~#

And the result did look good ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
