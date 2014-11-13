From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2014 08:34:07 +0000
Subject: Re: [linux-sunxi] [PATCH 2/4] simplefb: Add support for enumerating simplefb dt nodes in /chosen
Message-Id: <CAMuHMdVSfYyHc52Tdu_wzb6ZYPzeZtOzweUwADHxiJLypuBQNw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-2-git-send-email-hdegoede@redhat.com>
 <CAGRGNgW_Q6oghpe5Mw-8aYPVVj1YZ6R3iaqOQzCE9dSD1nYSyA@mail.gmail.com>
 <54646B5B.1070604@redhat.com>
In-Reply-To: <54646B5B.1070604@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Hans,

On Thu, Nov 13, 2014 at 9:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> +       char name[16];
>>> +       struct device_node *np;
>>> +
>>> +       ret = platform_driver_register(&simplefb_driver);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       for (i = 0; ; i++) {
>>> +               snprintf(name, sizeof(name), "framebuffer%d", i);
>>
>> This smells like an infinite loop: we can be pretty sure that no
>> hardware will ever exist with more than 9999 (I think?) framebuffers,
>> however if that ever happens this'll loop until it runs out of RAM.
>> Maybe add a suitably high limit to the for loop?
>
> The loop will stop as soon as there are no more framebuffer# nodes in chosen,
> so the loop is only infinite if there are infinite nodes in the devicetree,
> which would make the devicetree infinitely large, so this will never happen.

If there are 10000 frame buffers, the loop will continue beyond that,
as the index will be truncated to 4 digits due to the size of name[].
It will stop when (signed) i becomes negative, though ;-)

One solution is to increase the size of name[], another to use kasprintf().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
