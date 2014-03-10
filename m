From: Rob Herring <robherring2@gmail.com>
Date: Mon, 10 Mar 2014 21:45:58 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
	<20140228155937.GQ21483@n2100.arm.linux.org.uk>
	<1393604717.3802.61.camel@paszta.hi.pengutronix.de>
In-Reply-To: <1393604717.3802.61.camel-+qGW7pzALmz7o/J7KWpOmN53zsg1cpMQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Fri, Feb 28, 2014 at 10:25 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Freitag, den 28.02.2014, 15:59 +0000 schrieb Russell King - ARM
> Linux:
>> On Fri, Feb 28, 2014 at 02:20:10PM +0200, Tomi Valkeinen wrote:
>> > Add DT binding documentation for DVI Connector.
>> >
>> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> > Reviewed-by: Archit Taneja <archit@ti.com>
>> > ---
>> >  .../devicetree/bindings/video/dvi-connector.txt    | 26 ++++++++++++++++++++++
>> >  1 file changed, 26 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
>> > new file mode 100644
>> > index 000000000000..6a0aff866c78
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
>> > @@ -0,0 +1,26 @@
>> > +DVI Connector
>> > +=======
>> > +
>> > +Required properties:
>> > +- compatible: "dvi-connector"
>> > +
>> > +Optional properties:
>> > +- label: a symbolic name for the connector
>> > +- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
>> > +
>> > +Required nodes:
>> > +- Video port for DVI input
>> > +
>> > +Example
>> > +-------
>> > +
>> > +dvi0: connector@0 {
>> > +   compatible = "dvi-connector";
>> > +   label = "dvi";
>> > +
>> > +   i2c-bus = <&i2c3>;
>> > +
>> > +   dvi_connector_in: endpoint {
>> > +           remote-endpoint = <&tfp410_out>;
>> > +   };
>> > +};
>>
>> This looks far too simplistic.  There are different classes of DVI
>> connector - there is:
>>
>> DVI A - analogue only
>> DVI D - digital only (single and dual link)
>> DVI I - both (single and dual digital link)
>>
>> DRM at least makes a distinction between these three classes, and this
>> disctinction is part of the user API.  How would a display system know
>> which kind of DVI connector is wired up on the board from this DT
>> description?
>
> Maybe this could be inferred from the sources connected to it. For
> example a i.MX5 board with the SoC internal TV Encoder and an external
> SiI902x HDMI encoder connected to the same DVI I connector:
>
> ipu {
>         port@2 {
>                 ipu_di0_disp0: endpoint {
>                         remote-endpoint = <&sii902x_in>;
>                 };
>         };
>         port@3 {
>                 ipu_di1_tve: endpoint {
>                         remote-endpoint = <&tve_in>;
>                 };
>         };
> };
>
> &sii902x {
>         compatible = "si,sii9022";
>
>         port@0 {
>                 sii902x_in: endpoint {
>                         remote-endpoint = <&ipu_di0>;
>                 };
>         };
>         port@1 {
>                 sii902x_out: endpoint {
>                         remote-endpoint = <&dvi_d_in>;
>                 };
>         };
> };
>
> &tve {
>         compatible = "fsl,imx53-tve";
>         port@0 {
>                 tve_in: endpoint {
>                         remote-endpoint = <&ipu_di1>;
>                 };
>         };
>         port@1 {
>                 tve_out: endpoint {
>                         remote-endpoint = <&dvi_a_in>;
>                 };
>         };
> };
>
> dvi-connector {
>         compatible = "dvi-connector";
>         ddc-i2c-bus = <&i2c3>;
>
>         port {
>                 dvi_d_in: endpoint@0 {
>                         remote-endpoint = <&sii902x_out>;
>                 };
>                 dvi_a_in: endpoint@1 {
>                         remote-endpoint = <&tve_out>;
>                 };
>         };
> };
>
> It should be possible to let the connector know that those two endpoints
> are connected to a TMDS source and to a VGA source, respectively.

I like this proposal over the others. Although, would dual link be a
single endpoint or 2 endpoints? How would you differentiate that?

The port node seems a bit pointless.

Rob
