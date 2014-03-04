From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 04 Mar 2014 12:59:48 +0000
Subject: Re: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <20140304125948.GA17001@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>
	<20140228160612.GR21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228160612.GR21483@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Fri, Feb 28, 2014 at 04:06:12PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 28, 2014 at 02:20:11PM +0200, Tomi Valkeinen wrote:
> > Add DT binding documentation for HDMI Connector.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Reviewed-by: Archit Taneja <archit@ti.com>
> > ---
> >  .../devicetree/bindings/video/hdmi-connector.txt   | 23 ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/video/hdmi-connector.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/video/hdmi-connector.txt b/Documentation/devicetree/bindings/video/hdmi-connector.txt
> > new file mode 100644
> > index 000000000000..5d25f6a432bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/hdmi-connector.txt
> > @@ -0,0 +1,23 @@
> > +HDMI Connector
> > +=======
> > +
> > +Required properties:
> > +- compatible: "hdmi-connector"
> > +
> > +Optional properties:
> > +- label: a symbolic name for the connector
> > +
> > +Required nodes:
> > +- Video port for HDMI input
> > +
> > +Example
> > +-------
> > +
> > +hdmi0: connector@1 {
> > +	compatible = "hdmi-connector";
> > +	label = "hdmi";
> > +
> > +	hdmi_connector_in: endpoint {
> > +		remote-endpoint = <&tpd12s015_out>;
> > +	};
> > +};
> 
> It seems rather weird to have DVI connectors having an optional I2C
> property, but HDMI (which augments DVI) not having that as at least an
> optional property.
> 
> I can quite well see the iMX HDMI support needing an i2c bus here.
> 
> Also, HDMI has two connector standards - type A and type B, much like
> the single vs dual link of DVI.  Again, DRM exposes this to userspace.

Yeah, there's a dual-link hdmi standard somewhere. I've never seen it in
the wild anywhere though, and newer hdmi all just increase the max link
clock to push higher res modes over the wire. Imo can't hurt to just
enumerate all type of physical connectors standardized.

HDMI revisions themselves are only relevant for the sink (as advertised
capabilities in the EDID) and for your hdmi encoder chip (where pretty
much just the max dotclock is interesting really). So I don't think we
need a hdmi revision in dt for the physical connector.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
