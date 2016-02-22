From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Feb 2016 12:39:37 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Use ARCH_RENESAS
Message-Id: <CAMuHMdU6wyvqFxpQ6q60dDPaQqEq7nEcC8qG3odFAU=TctbycA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On Mon, Feb 22, 2016 at 1:24 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 22 February 2016 10:59:51 Simon Horman wrote:
>> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>>
>> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
>> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
>> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> Wouldn't it make sense to drop the driver instead ? We have a DRM driver that
> replaces it.

Does the DRM driver work on all hardware supported by the fbdev driver?
It's not only used on r8a7740/armadillo (through staging/board due to lack of
DT support), but also on many SH boards.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
