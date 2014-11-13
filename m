From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2014 08:58:41 +0000
Subject: Re: [PATCH 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <CAMuHMdXZ4V4GHvyDLOP8FYvPuGArc5G0aO6NCE9FKHT24YRGPg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather>
In-Reply-To: <20141113085238.GE20972@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Maxime,

On Thu, Nov 13, 2014 at 9:52 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
>> -module_init(simplefb_init);
>> +/*
>> + * While this can be a module, if builtin it's most likely the console
>> + * So let's leave module_exit but move module_init to an earlier place
>> + */
>
> Not really related to this patch itself, but do we want to support
> simplefb as a module? It seems like it's going to be most of the time
> broken.

If it depends on clocks, it won't work as a module, as CCF will have disabled
all unused clocks at that point.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
