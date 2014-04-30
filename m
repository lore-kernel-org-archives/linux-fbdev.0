From: Tony Lindgren <tony@atomide.com>
Date: Wed, 30 Apr 2014 17:47:52 +0000
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and ldp
Message-Id: <20140430174751.GA12362@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
In-Reply-To: <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Joachim Eastwood <manabian@gmail.com> [140429 18:08]:
> On 30 April 2014 01:52, Tony Lindgren <tony@atomide.com> wrote:
> > Looks like quite a few omaps have sharp ls037v7dw01 that's configured
> > as various panel dpi entries for whatever legacy reasons. For device
> > tree based support, let's just configure these properly for panel
> > ls037v7dw01 instead of panel dpi.
> >
> > This patch creates a common file for panel ls037v7dw01, and makes
> > boards ldp and omap3-evm to use it. The panel for ldp is configured
> > in the qvga mode and omap3-evm panel in vga mode.
> >
> > The ls037v7dw01 also seems to be coupled with an ad7846 touchscreen
> > controller for the omaps, so let's add a basic configuration for
> > the touchscreen also using the default values.
> >
> > Note that we can now remove the regulator-name = "vdds_dsi"
> > entry for ldp, that's no longer needed as we have the entry
> > for vdds_dsi-supply = <&vpll2>.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  .../arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi | 82 ++++++++++++++++++++++
> >  arch/arm/boot/dts/omap3-evm-37xx.dts               | 50 +++++++++++++
> >  arch/arm/boot/dts/omap3-evm-common.dtsi            | 47 +++++++++++++
> >  arch/arm/boot/dts/omap3-ldp.dts                    | 31 ++++++--
> >  4 files changed, 205 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
> 
> > diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
> > index 0abe986..50fdac9 100644
> > --- a/arch/arm/boot/dts/omap3-ldp.dts
> > +++ b/arch/arm/boot/dts/omap3-ldp.dts
> > @@ -164,6 +164,7 @@
> >
> >  #include "twl4030.dtsi"
> >  #include "twl4030_omap3.dtsi"
> > +#include "omap-panel-sharp-ls037v7dw01.dtsi"
> >
> >  &i2c2 {
> >         clock-frequency = <400000>;
> > @@ -173,6 +174,31 @@
> >         clock-frequency = <400000>;
> >  };
> >
> > +&lcd_3v3 {
> > +       gpio = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
> > +       enable-active-high;
> > +};
> > +
> > +&lcd0 {
> > +       reset-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;     /* gpio55, lcd RESB */
> > +       gpios = <&gpio2 24 GPIO_ACTIVE_LOW      /* gpio56, lcd MO */
> 
> enable-gpios ?

Oops yes, changed from gpios to enable-gpios while reading the panel
binding doc, probably forgot to commit the change, will update.

Tony
