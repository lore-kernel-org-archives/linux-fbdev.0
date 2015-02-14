From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Sat, 14 Feb 2015 16:12:32 +0000
Subject: Re: [PATCH 2/8] fbdev: ssd1307fb: Unify init code and make controller configurable from device tree
Message-Id: <20150214171232.11ccb264@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>
	<20150207104225.GM2079@lukather>
	<20150207155933.4f1d0998@maestro.intranet>
	<20150212164147.GK2079@lukather>
In-Reply-To: <20150212164147.GK2079@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Am Thu, 12 Feb 2015 17:41:47 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Sat, Feb 07, 2015 at 03:59:33PM +0100, Thomas Niederprüm wrote:
> > Am Sat, 7 Feb 2015 11:42:25 +0100
> > schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
> > 
> > > Hi,
> > > 
> > > On Fri, Feb 06, 2015 at 11:28:08PM +0100, niederp@physik.uni-kl.de
> > > wrote:
> > > > From: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > > > 
> > > > This patches unifies the init code for the ssd130X chips and
> > > > adds device tree bindings to describe the hardware configuration
> > > > of the used controller. This gets rid of the magic bit values
> > > > used in the init code so far.
> > > > 
> > > > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > > > ---
> > > >  .../devicetree/bindings/video/ssd1307fb.txt        |  11 +
> > > >  drivers/video/fbdev/ssd1307fb.c                    | 243
> > > > ++++++++++++++------- 2 files changed, 174 insertions(+), 80
> > > > deletions(-)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> > > > b/Documentation/devicetree/bindings/video/ssd1307fb.txt index
> > > > 7a12542..1230f68 100644 ---
> > > > a/Documentation/devicetree/bindings/video/ssd1307fb.txt +++
> > > > b/Documentation/devicetree/bindings/video/ssd1307fb.txt @@
> > > > -15,6 +15,17 @@ Required properties: Optional properties:
> > > >    - reset-active-low: Is the reset gpio is active on physical
> > > > low?
> > > > +  - solomon,segment-remap: Invert the order of data column to
> > > > segment mapping
> > > > +  - solomon,offset: Map the display start line to one of COM0 -
> > > > COM63
> > > > +  - solomon,contrast: Set initial contrast of the display
> > > > +  - solomon,prechargep1: Set the duration of the precharge
> > > > period phase1
> > > > +  - solomon,prechargep2: Set the duration of the precharge
> > > > period phase2
> > > > +  - solomon,com-alt: Enable/disable alternate COM pin
> > > > configuration
> > > > +  - solomon,com-lrremap: Enable/disable left-right remap of COM
> > > > pins
> > > > +  - solomon,com-invdir: Invert COM scan direction
> > > > +  - solomon,vcomh: Set VCOMH regulator voltage
> > > > +  - solomon,dclk-div: Set display clock divider
> > > > +  - solomon,dclk-frq: Set display clock frequency
> > > 
> > > I'm sorry, but this is the wrong approach, for at least two
> > > reasons: you broke all existing users of that driver, which is a
> > > clear no-go,
> > 
> > Unfortunately this is true. The problem is that the SSD130X
> > controllers allow for a very versatile wiring of the display to the
> > controller.  It's over to the manufacturer of the OLED module
> > (disp+controller) to decide how it's actually wired and during
> > device initialization the driver has to take care to configure the
> > SSD130X controller according to that wiring. If the driver fails to
> > do so you will end up having your display showing
> > garbage.
> 
> How so?

One good example is the segment remap. It basically allows to invert the
order of the output pins connecting to the oled panel. This gives the
manufacturer of the module the freedom wire it the one way or the
other, depending on the PCB restrictions/panel layout (Section 10.1.12
of [0], 10.1.8 in [1], 9.1.8 in [2]). However, once the panel is
connected to the controller it's determined whether the segment remap
is needed or not. Setting the segment remap as done in the current
initialization code for ssd1306 and ssd1307 makes my display module
show it's contents mirrored left to right, probably since the
manufacturer decided not to connect the panel in an inverted order.

The same applies to the com-alt, com-lrremap and com-invdir values,
which define different possibilities for the COM signals pin
configuration (Section 10.1.26 of [0], 10.1.18 in [1], 9.1.18 in [2])
and readout direction of the video memory (Section 10.1.21 of [0],
10.1.14 in [1], 9.1.14 in [2]). Setting com-alt incorrectly leaves
every other line of the display blank. Setting com-lrremap incorrectly
produces a very distorted image. Setting com-invdir incorrectly flips
the image upside down.

IMHO at least these four hardware-specific properties need to be known
to the driver in order to initialize the hardware correctly.

> 
> Does it depend on the X, or can it change from one same controller to
> another? to what extent?

Unfortunately I do not posses any hardware utilizing a ssd1306 or
ssd1307 controller. My primary and only target device is a Newhaven
NHD-3.12-25664UCB2 OLED display module using an SSD1305 controller. I
just inferred from the datasheets of ssd1306/7 [1,2] that they should
behave the same since the registers are bit to bit identical (except
for the VHCOM register). Maybe that was a bit too naive :/

> 
> The 1306 for example seems to not be using these values at all, while
> the 1307 does.

That is surprising. In that case I would like to ask the guys from
Solomon why they describe all these options in the SSD1306 datasheet
[1]. But in any case, isn't that good news for the problem of setting
the default values. When the 1306 isn't using these values anyway we can
not break the initialization by setting different default values. In
this case the problem of the default values boils down to the segment
remap only since this is set in the init code of the 1307, while the
default would be to leave it off.

> 
> > Unfortunately the current sate of the initialization code of the
> > ssd1307fb driver is not very flexible in that respect. Taking a look
> > at the initialization code for the ssd1306 shows that it was written
> > with one very special display module in mind. Most of the magic bit
> > values set there are non-default values according to the
> > datasheet. The result is that the driver works with that one
> > particular display module but many other (differently wired) display
> > modules using a ssd1306 controller won't work without changing the
> > hardcoded magic bit values.
> > 
> > My idea here was to set all configuration to the default values (as
> > given in the datasheet) unless it is overwritten by DT. Of course,
> > without a change in DT, this breaks the driver for all existing
> > users. The only alternative would be to set the current values as
> > default. Somehow this feels wrong to me as these values look
> > arbitrary when you don't know what exact display module they were
> > set for. But if you insist, I will change the default values.
> 
> Unfortunately, the DT bindings are to be considered an ABI, and we
> should support booting with older DTs (not that I personally care
> about it, but that's another issue). So we really don't have much
> choice here.
> 
> Moreover, that issue left aside, modifying bindings like this without
> fixing up the in-tree users is considered quite rude :)

I didn't intend to be rude, sorry. A quick search revealed that there
is luckily only one in-tree user, which is imx28-cfa10036.dts. In case
it will be necessary I will include a patch to fix this.

> > > and the DT itself should not contain any direct mapping of the
> > > registers.
> > > 
> > 
> > I think I don't get what you mean here. Is it because I do no sanity
> > checks of the numbers set in DT? I was just looking for a way to
> > hand over the information about the wiring of display to the
> > driver. How would you propose to solve this?
> 
> What I meant was that replicating direct registers value is usually a
> recipe for a later failure, especially if we can have the information
> under a generic and easy to understand manner.
> 
> For example, replacing the solomon,dclk-div and solomon,dclk-frq
> properties by a clock-frequency property in Hz, and computing the
> divider and that register in your driver is usually better, also
> because it allows to have different requirements / algorithms to
> compute that if some other chip needs it.

I'll give that a try, even though that particular one is not trivial
since the documentation on the actual frequency that is set by the
dclk-freq is very poor (not present for 1306/1307 [1,2], just a graph
for 1305 [0]).

For the properties describing the hardware pin configuration (see above)
I see no real alternative. Maybe they can all be covered by one DT
property like:
solomon,com-cfg = PINCFG_SEGREMAP | PINCFG_COMALT | PINCFG_COMINV |
PINCFG_COMLRRM
each PINCFG_* setting one bit. The driver will then translate this into
the correct settings for the 130X registers. The only problem here is
that this implicitly assumes the default values of each bit to be 0.

> 
> Maxime
> 

[0]http://www.newhavendisplay.com/app_notes/SSD1305.pdf
[1]http://www.adafruit.com/datasheets/SSD1306.pdf
[2]http://www.displayfuture.com/Display/datasheet/controller/SSD1307.pdf

Thomas
