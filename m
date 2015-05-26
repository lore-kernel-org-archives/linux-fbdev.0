From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2015 07:41:57 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <CAMuHMdWrxkH17dbhzgqAAhtqJSg5WRLOmvdeupvLB-1cKE7ybg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de>
	<5562B9CE.7050807@ti.com>
	<5563EEF9.3080901@denx.de>
	<556418A9.8010603@ti.com>
	<55641E1E.9010607@denx.de>
	<CAMuHMdWc=vsdmjxmQdSRYkQ-t_Rmn-LoTp1Jn0wgp++rEStcxw@mail.gmail.com>
	<55642243.5000205@denx.de>
In-Reply-To: <55642243.5000205@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hs@denx.de
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi Heiko,

On Tue, May 26, 2015 at 9:35 AM, Heiko Schocher <hs@denx.de> wrote:
> Am 26.05.2015 09:25, schrieb Geert Uytterhoeven:
>>
>> On Tue, May 26, 2015 at 9:17 AM, Heiko Schocher <hs@denx.de> wrote:
>>>
>>> 4) draw only one logo even on multicores ... why must every core draw
>>> a logo? Currently each core draws the logo, and on a system with more
>>> than 4 cores, I think this looks not really good ...
>>
>>
>> I don't think each core draws a logo. They're all drawn from
>> fbcon_switch().
>
> Hmm... I have here an imx6dl based system, and it draws two logos when
> booting...

It draw one logo _for_ each cpu core, but each logo is not drawn _by_ each
cpu core.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
