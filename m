From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 May 2016 18:40:57 +0000
Subject: Re: [PATCH 0/2] fbdev: sh_mobile_meram: use ARCH_RENESAS
Message-Id: <CAMuHMdWV+yNvhiN2dR=Fc7Lzh4DKLtsN4=bdC7dWHw06KSPtww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457663298-31973-1-git-send-email-horms+renesas@verge.net.au>
	<5731A229.7010307@ti.com>
In-Reply-To: <5731A229.7010307@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

Hi Tomi,

On Tue, May 10, 2016 at 10:56 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 11/03/16 04:28, Simon Horman wrote:
>> Use ARCH_RENESAS in place of ARCH_SHMOBILE.
>>
>> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
>> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
>> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>>
>> As a follow-up also depend on COMPILE_TEST to provided for increased
>> compile testing.
>>
>> Based on v4.5-rc1
>>
>> Simon Horman (2):
>>   fbdev: sh_mobile_meram: use ARCH_RENESAS
>>   fbdev: sh_mobile_meram: depend on COMPILE_TEST
>>
>>  drivers/video/fbdev/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> What was the conclusion in this thread? Should I apply these?

I think the conclusion was "changes requested".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
