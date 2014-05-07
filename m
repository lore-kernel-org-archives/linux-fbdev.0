From: Tony Lindgren <tony@atomide.com>
Date: Wed, 07 May 2014 15:03:43 +0000
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Message-Id: <20140507150343.GA9502@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com>
In-Reply-To: <5369EAE7.3030705@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 01:13]:
> On 30/04/14 02:52, Tony Lindgren wrote:
> > We can pass the GPIO configuration for ls037v7dw01 in a standard
> > gpios property.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  .../bindings/panel/sharp,ls037v7dw01.txt           | 53 ++++++++++++++
> >  .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 84 ++++++++++++++++++++--
> >  2 files changed, 133 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
> > new file mode 100644
> > index 0000000..7f6f5e1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
> > @@ -0,0 +1,53 @@
> > +SHARP LS037V7DW01 TFT-LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "sharp,ls037v7dw01"
> > +
> > +Optional properties:
> > +- reset-gpios: a GPIO spec for the optional reset pin
> > +- enable-gpios: a GPIO array for the optional configuration GPIOs
> > +  ordered MO, LR, UD, INI as specified in the LS037V7DW01.pdf file.
> > +
> > +This binding is compatible with the simple-panel binding, which is specified
> > +in simple-panel.txt in this directory.
> > +
> > +This panel can have zero to five GPIOs to configure
> > +to change configuration between QVGA and VGA mode
> > +and the scan direction. As these pins can be also
> > +configured with external pulls, all the GPIOs are
> > +considered optional with holes in the array.
> > +
> > +Example when connected to a omap2+ based device:
> > +
> > +	lcd0: display {
> > +		compatible = "sharp,ls037v7dw01";
> > +		power-supply = <&lcd_3v3>;
> > +		reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
> > +		enable-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
> > +				&gpio1 2 GPIO_ACTIVE_HIGH	/* gpio2, lcd LR */
> > +				&gpio1 3 GPIO_ACTIVE_HIGH	/* gpio3, lcd UD */
> > +				&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
> 
> Why are most of the gpios in 'enable-gpios'? MO, LR and UD don't really
> have anything to do with enabling the panel. Why not just have one
> 'gpios' array with all the gpios, as they are quite a mixed bunch?

Yeah that's what I had initially, but reading simple-panel.txt noticed
there are some standardized GPIOs for reset and enable.

How about we set up one reset-gpios, one enable-gpios and an array of
three unlabelled GPIOs?

Or if we want to add something generic, we could add new mode-gpios
property that other panels might be able to use too?

BTW, I'm also personally fine with all five gpios showing in a single
gpios property, I'm not too exited about naming anything in DT..

Regards,

Tony

