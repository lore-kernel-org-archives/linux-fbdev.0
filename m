From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 May 2013 16:57:55 +0000
Subject: Re: [PATCH] video: simplefb: add mode parsing function
Message-Id: <CAMuHMdVs4hy7dWAGxN51XP3YuWBY6rk22Z6tCU+-HujZH4jL2Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369296231-26597-1-git-send-email-acourbot@nvidia.com>
 <519E438A.9030408@wwwdotorg.org>
In-Reply-To: <519E438A.9030408-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Thu, May 23, 2013 at 6:27 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> +
>> +             cpt += field->length;
>> +     }
>> +
>> +     format->bits_per_pixel = ((cpt + 7) / 8) * 8;
>
> Should this error-check that isn't > 32?

So pixels can't be larger than 32 bits?
IIRC, some SGI and Sun graphics cards had e.g. 80 bit pixels (incl. Z buffer).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
