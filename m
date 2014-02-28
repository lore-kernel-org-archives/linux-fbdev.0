From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Feb 2014 16:34:31 +0000
Subject: Re: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <20140228163431.GV21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>
	<20140228160612.GR21483@n2100.arm.linux.org.uk>
	<5310B609.1010105@ti.com>
In-Reply-To: <5310B609.1010105@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Fri, Feb 28, 2014 at 06:15:05PM +0200, Tomi Valkeinen wrote:
> On 28/02/14 18:06, Russell King - ARM Linux wrote:
> 
> >> +hdmi0: connector@1 {
> >> +	compatible = "hdmi-connector";
> >> +	label = "hdmi";
> >> +
> >> +	hdmi_connector_in: endpoint {
> >> +		remote-endpoint = <&tpd12s015_out>;
> >> +	};
> >> +};
> > 
> > It seems rather weird to have DVI connectors having an optional I2C
> > property, but HDMI (which augments DVI) not having that as at least an
> > optional property.
> 
> I have added only the properties that I have used. I did think about the
> i2c for HDMI also, but thought that I don't use it, and so can't test
> it, and so I could well create a bad binding.
> 
> And, as I don't see any issue in adding it later, when someone uses it,
> I decided to leave it out.
> 
> > I can quite well see the iMX HDMI support needing an i2c bus here.
> > 
> > Also, HDMI has two connector standards - type A and type B, much like
> > the single vs dual link of DVI.  Again, DRM exposes this to userspace.
> 
> True, but isn't that just a form factor? No functional differences? But
> I agree, we can add the two types here also to the compatible string.

HDMI A is 19 pins carrying TMDS channels 0-2.  HDMI B is 29 pins
carrying TMDS channels 0-5.  So, the difference is the same as the
single vs dual link on DVI-D/I connectors.

There's actually three HDMI connectors:

  All three connectors carry all required HDMI signals, including a TMDS
  link. The Type B connector is slightly larger and carries a second TMDS
  link, which is necessary to support very high resolution displays using
  dual link. The Type C connector carries the same signals as the Type A
  but is more compact and intended for mobile applications.

So, Type C and Type A are electrically the same.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
