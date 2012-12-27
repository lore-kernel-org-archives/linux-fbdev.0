From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 27 Dec 2012 19:19:05 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <20121227191905.GR24458@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1671267.x0lxGrFjjV@avalon>
 <87pq26ay2z.fsf@intel.com>
 <2286035.iP368aB6Vk@avalon>
 <CAF6AEGth+rriTf7X3AXytN+YXxjx4XqMB1ow6ZE2QUro-hqYgw@mail.gmail.com>
In-Reply-To: <CAF6AEGth+rriTf7X3AXytN+YXxjx4XqMB1ow6ZE2QUro-hqYgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Clark <rob.clark@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jani Nikula <jani.nikula@linux.intel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <ragesh.r@linaro.org>, dri-devel@lists.freedesktop.org, Kyungmin Park <kyungmin.park@samsung.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org

On Thu, Dec 27, 2012 at 10:04:22AM -0600, Rob Clark wrote:
> On Mon, Dec 24, 2012 at 11:27 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Wednesday 19 December 2012 16:57:56 Jani Nikula wrote:
> >> It just seems to me that, at least from a DRM/KMS perspective, adding
> >> another layer (=CDF) for HDMI or DP (or legacy outputs) would be
> >> overengineering it. They are pretty well standardized, and I don't see=
 there
> >> would be a need to write multiple display drivers for them. Each displ=
ay
> >> controller has one, and can easily handle any chip specific requiremen=
ts
> >> right there. It's my gut feeling that an additional framework would ju=
st get
> >> in the way. Perhaps there could be more common HDMI/DP helper style co=
de in
> >> DRM to reduce overlap across KMS drivers, but that's another thing.
> >>
> >> So is the HDMI/DP drivers using CDF a more interesting idea from a non=
-DRM
> >> perspective? Or, put another way, is it more of an alternative to usin=
g DRM?
> >> Please enlighten me if there's some real benefit here that I fail to s=
ee!
> >
> > As Rob pointed out, you can have external HDMI/DP encoders, and even in=
ternal
> > HDMI/DP encoder IPs can be shared between SoCs and SoC vendors. CDF aim=
s at
> > sharing a single driver between SoCs and boards for a given HDMI/DP enc=
oder.
>=20
> just fwiw, drm already has something a bit like this.. the i2c
> encoder-slave.  With support for a couple external i2c encoders which
> could in theory be shared between devices.

The problem with this code is that it only works when the i2c device is
registered by a master driver. Once the i2c device comes from the
devicetree there is no possibility to find it.

Sascha

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
