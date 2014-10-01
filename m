From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 01 Oct 2014 18:43:27 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAMuHMdXQ8bWCyaLiyOBKQNhB4rJDHBUzHnNMCf7_sPBtR1AKVg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo> <20141001171704.GG4273@sirena.org.uk>
In-Reply-To: <20141001171704.GG4273@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 1, 2014 at 7:17 PM, Mark Brown <broonie@kernel.org> wrote:
>> Well, I don't think it should because it describes the same resources
>> that the device tree node for the real device already describes. But
>> perhaps this is one of the cases where duplication isn't all that bad?
>
> If we were worried about this wecould also do it by referring to
> those nodes and saying "get all the resources these things need" rather
> than duplicating the references (this might make it easier to work out
> when the system is ready to hand off to the real drivers).

You can have a single node for both simplefb and the later "real" driver.
DT describes the hardware, not the software ecosystem running on the
hardware. Clock, regulators, etc. don't change from a hardware point of
view.

If the firmware initialized a suitable graphics mode, it just has to add
"linux,simplefb" to the compatible property (and perhaps a few other
simplefb-specific properties).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
