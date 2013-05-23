From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 May 2013 19:42:57 +0000
Subject: Re: [PATCH] video: simplefb: add mode parsing function
Message-Id: <CAMuHMdWLvWcQXCyvag1DCU=6De2_8US6Zj2VhnZ6Fo5UKwG5WA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369296231-26597-1-git-send-email-acourbot@nvidia.com>
 <519E438A.9030408@wwwdotorg.org>
 <CAMuHMdVs4hy7dWAGxN51XP3YuWBY6rk22Z6tCU+-HujZH4jL2Q@mail.gmail.com>
 <519E6C37.2010706@wwwdotorg.org>
In-Reply-To: <519E6C37.2010706-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Thu, May 23, 2013 at 9:21 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/23/2013 10:57 AM, Geert Uytterhoeven wrote:
>> On Thu, May 23, 2013 at 6:27 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> +
>>>> +             cpt += field->length;
>>>> +     }
>>>> +
>>>> +     format->bits_per_pixel = ((cpt + 7) / 8) * 8;
>>>
>>> Should this error-check that isn't > 32?
>>
>> So pixels can't be larger than 32 bits?
>> IIRC, some SGI and Sun graphics cards had e.g. 80 bit pixels (incl. Z buffer).
>
> That's a good point.
>
> Out of curiosity, how does the FB core treat these format definitions?
> Are they expected to fit into a 16-/32-/64-/128- bit power-of-two
> bit-size, or are they treated as a string of bytes that get serialized
> into memory LSB first (or perhaps MSB first on BE systems?)
>
> The difference would be that from a CPU perspective only, if you pack
> the RGB components into a u32, then write that to RAM as a u32, then the
> in-memory byte-by-byte order is different on different endian systems,
> whereas if the FB core treats it as a series of bytes only, then
> presumably the in-memory byte-by-byte order is identical irrespective of
> host CPU endianness.

I don't think any of the current FB drivers support these.

Conceptually, a (packed) frame buffer is just a block of memory,
containing lines
of line_length bytes.
Each line contains xres_virtual pixels, each of bits_per_pixel bits.

As long as bits_per_pixel is an integer multiple of 8, it's
more-or-less well-defined.
We did have issues with endianness on e.g. bits_per_pixel = 4 (2 pixels in
one byte, which order?), bits_per_pixel = 16 (byteswapped RGB565), etc.
If bits_per_pixel is larger than 32, and not an integer multiple of 32,
you indeed can have more of them...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
