From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Sat, 03 Oct 2015 18:05:25 +0000
Subject: Re: [PATCH] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <1443895525.17648.29.camel@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443888694-12311-1-git-send-email-robert.jarzmik@free.fr>
	 <CA+gwMceq-+8UX4J7zgMG_DcGYE1RhmiHhKig8i7MVwga53LQRw@mail.gmail.com>
	 <87fv1rdfxb.fsf@belgarion.home>
In-Reply-To: <87fv1rdfxb.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Am Samstag, den 03.10.2015, 19:23 +0200 schrieb Robert Jarzmik:
[...]
> a/Documentation/devicetree/bindings/video/marvell,pxafb.txt
> > > b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
> > > new file mode 100644
> > > index 000000000000..489055bf3c57
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
> > > @@ -0,0 +1,75 @@
> > > +PXA LCDC Framebuffer
> > > +-----------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible :
> > > +       "marvell,pxa2xx-fb",
> > 
> > Should be "marvell,pxa2xx-lcd-controller", "marvell,pxa2xx-lcdc" or
> > something like this.
> Whichever you see fit.

Personally, I like the lcdc one better, even though it is an arbitrary
abbreviation of the text found in the manual.


> > > +- reg : Should contain 1 register ranges(address and length).
> > > +       Can contain an additional register range(address and
> > > length)
> > > +       for fixed framebuffer memory. Useful for dedicated
> > > memories.
> > > +- interrupts : framebuffer controller interrupt
> > > +- display: a phandle pointing to the display node
> > > +
> > > +Required nodes:
> > > +- display: a display node is required to initialize the lcd
> > > panel
> > > +          This should be in the board dts.
> > 
> > I'd prefer to use an of-graph link to a panel node with a proper
> > compatible value for the panel, instead of this custom display
> > property.
> > That way, if somebody ever decides convert the fbdev driver to a
> > drm
> > driver, we don't have to change the device tree and can directly
> > use
> > drm_panel.
> Ok, if you give me an example it would be easier for me.

Have a look at the of-graph connection between capture interface and
sensor (QCI and MT9M111) in your example below. The connection between
LCD controller and panel should look similar:

	pxabus {
		lcd-controller@40500000 {
			compatible = "marvell,pxa2xx-lcdc";
			/* ... */

			port {
				lcdc_out: endpoint {
					remote-endpoint = <&panel_in>;

					bus-width = <16>;
				};
			};
		};
	};

	panel {
		compatible = "toshiba,ltm0305a776";
		lcd-type = "color-tft";
		power-supply = <&lcd_supply>;
		backlight = <&lcd_backlight>;

		port {
			panel_in: endpoint {
				remote-endpoint = <&lcdc_out>;
			};
		};
	}

The bus-width could be made a property of the lcdc_out endpoint for
symmetry with the QCI binding, and as documented in
Documentation/devicetree/bindings/media/video-interfaces.txt

If you later bind a drm_panel driver to the panel node, it can look up
that information (and the timings) just from the compatible string.

[...]
> > > +Optional properties:
> > > +- lcd-supply: Regulator for LCD supply voltage.
> > 
> > How does this differ from the regulator below?
> Ah yes, good point. In the end I couldn't decide which one was the
> correct one
> ... My feeling is that it's the display's one, as hardware wise the
> power is
> necessary for the display, not the framebuffer.

Then I'd suggest a power-supply property in the panel node, as is
already documented for simple panels:
Documentation/devicetree/bindings/panel/simple-panel.txt

> > > +PXA LCDC Display
> > > +-----------------------------------------------------
> > > +Required properties (as per of_videomode_helper):
> > > + - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color
> > > -dstn",
> > > +                   "color-tft", "smart-panel"
> > > + - bits-per-pixel: LCD data bus width
> > 
> > This is already found in the lcd controller node above.
> I think the bus-width should be here. It represents the number of
> data lines
> between the SoC and the panel.

With the of-graph, it can be argued that this is a property of both
endpoints of the bus (imagine an 18-bit panel driven by a 16-bit LCD
controller with some funny wiring).

regards
Philipp
