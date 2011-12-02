From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 02 Dec 2011 10:52:24 +0000
Subject: Re: backlight/ld9040.c: regulator control in the lcd driver
Message-Id: <20111202105223.GD8245@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
 <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
 <CAH9JG2XdDn26ziceug6-Dc8g3+z3AUuzL34-oHRy10qL2RjF2w@mail.gmail.com>
 <20111202103139.GA8245@opensource.wolfsonmicro.com>
 <CACRpkdYrNcuch-H9ttHE3saceCM-WsB-Wx0-tih8LHxu6ftaYA@mail.gmail.com>
In-Reply-To: <CACRpkdYrNcuch-H9ttHE3saceCM-WsB-Wx0-tih8LHxu6ftaYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 02, 2011 at 11:36:13AM +0100, Linus Walleij wrote:

> I don't think that's true. You *must* have some voltage on VMMC
> to power the card, the optional part is regulating that voltage to
> different levels as requested by the card internal machinery when
> talking to it. All MMC/SD cards can run on a fixed voltage, something
> like 3.8V I think.

> In line with our previous discussions I think this should actually be
> defined as a fixed voltage regulator in case it cannot be controlled,
> because there sure as hell is a voltage there on all systems.

I have to say that I was very suspicious of this claim at the time but
there was so much pain associated with the MMC stuff that it just got
left to slide.  Similarly with the use of regulator_get_exclusive() to
vary the voltage, I'd *really* expect that the code would be able to
cope with shared supplies.
