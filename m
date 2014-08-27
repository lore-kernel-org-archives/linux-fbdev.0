From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Aug 2014 17:22:42 +0000
Subject: Re: [PATCH 03/16] video: Add DT binding documentation for VGA connector
Message-Id: <1455918.Ek46oPnquz@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1409157673-4154-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAL_JsqLOzrgncpTa3SqMjc=XeYuvXhGrvk9dKA+Fgh_g_wycCA@mail.gmail.com>
In-Reply-To: <CAL_JsqLOzrgncpTa3SqMjc=XeYuvXhGrvk9dKA+Fgh_g_wycCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>

Hi Rob,

On Wednesday 27 August 2014 12:12:36 Rob Herring wrote:
> On Wed, Aug 27, 2014 at 11:41 AM, Laurent Pinchart wrote:
> > The VGA connector is described by a single input port and an optional
> > DDC bus.
> 
> Wasn't there a generic connector binding for DVI, HDMI, etc.?

As far as I know, there are three separate generic bindings for DVI 
connectors, HDMI connectors, and analog TV connectors. The VGA connector 
doesn't seem to really fit into one of those categories.

> > Cc: devicetree@vger.kernel.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../devicetree/bindings/video/vga-connector.txt    | 28
> >  ++++++++++++++++++++++ 1 file changed, 28 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/video/vga-connector.txt> 
> > diff --git a/Documentation/devicetree/bindings/video/vga-connector.txt
> > b/Documentation/devicetree/bindings/video/vga-connector.txt new file mode
> > 100644
> > index 0000000..9a45ec1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/vga-connector.txt
> > @@ -0,0 +1,28 @@
> > +VGA Connector
> > +=======
> > +
> > +Required properties:
> > +- compatible: "vga-connector"
> > +
> > +Optional properties:
> > +- label: a symbolic name for the connector
> 
> ...which corresponds to hardware labels.
> 
> > +- ddc-i2c-bus: phandle to the I2C bus that is connected to VGA DDC
> > +
> > +Required nodes:
> > +- Video port for VGA input
> 
> A reference to the relevant video graph bindings should be added here.

I'll fix that.

> > +
> > +Example
> > +-------
> > +
> > +vga0: connector@0 {
> > +       compatible = "vga-connector";
> > +       label = "vga";
> > +
> > +       ddc-i2c-bus = <&i2c3>;
> > +
> > +       port {
> > +               vga_connector_in: endpoint {
> > +                       remote-endpoint = <&adv7123_out>;
> > +               };
> > +       };
> > +};

-- 
Regards,

Laurent Pinchart

