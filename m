From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Feb 2014 16:48:04 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <20140228164804.GW21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<531087C0.1090501@gmail.com> <53108B9C.5000006@ti.com>
	<5310945A.9040106@gmail.com>
In-Reply-To: <5310945A.9040106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org

On Fri, Feb 28, 2014 at 02:51:22PM +0100, Sebastian Hesselbarth wrote:
> Is it really the logical place to handle HPD? I'd have put it into the
> HDMI encoder because it's the unit most interested in the state of HPD.

I think this is where differences in hardware become a problem.

Yes, it makes sense to handle the HPD at the encoder level, because
your HDMI encoder may require a HPD signal from the connector, and it
may handle this internally.

However, it's also true that the HPD signal from the HDMI connector may
be routed directly to a GPIO on the SoC.

Both are equally valid - and actually something which DRM as a subsystem
understands:

struct drm_connector_funcs {
        enum drm_connector_status (*detect)(struct drm_connector *connector,
                                            bool force);
};

struct drm_encoder_helper_funcs {
        enum drm_connector_status (*detect)(struct drm_encoder *encoder,
                                            struct drm_connector *connector);
};

although the original intention for the encoder detection method was for
DAC-style detection, such as found on Intel adapters (which regularly
pulse the R,G,B signals and measure any attached load.)  We also use
the encoder detection method for TDA998x on Dove (currently via the
slave encoder stuff.)

So, I'd say that there's scope for a HDMI connector having a hotplug
GPIO attached to it - and if it isn't there (and there's no other form
of connector-based detection), the connector should refer to it's
attached encoder for connect status.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
