From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 12:55:22 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017125521.GH10993@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPDwMsyfds7q4mrK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <3610893.n6xJ6DUJ0E@avalon>
 <20131017120646.GE10993@ulmo.nvidia.com>
 <2414405.blLIekLlE8@avalon>
In-Reply-To: <2414405.blLIekLlE8@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 02:23:32PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Thursday 17 October 2013 14:06:47 Thierry Reding wrote:
> > On Thu, Oct 17, 2013 at 01:15:22PM +0200, Laurent Pinchart wrote:
> > > On Thursday 17 October 2013 13:05:18 Thierry Reding wrote:
> > > > On Thu, Oct 17, 2013 at 01:22:21PM +0300, Tomi Valkeinen wrote:
> > > > > On 17/10/13 11:53, Thierry Reding wrote:
> > > > > > I keep wondering why we absolutely must have compatibility betw=
een
> > > > > > CDF and this simple panel binding. DT content is supposed to co=
ncern
> > > > > > itself with the description of hardware only. What about the
> > > > > > following isn't an accurate description of the panel hardware?
> > > > > >=20
> > > > > > 	panel: panel {
> > > > > > 		compatible =3D "cptt,claa101wb01";
> > > > > > 	=09
> > > > > > 		power-supply =3D <&vdd_pnl_reg>;
> > > > > > 		enable-gpios =3D <&gpio 90 0>;
> > > > > > 	=09
> > > > > > 		backlight =3D <&backlight>;
> > > > > > 	};
> > > > > > =09
> > > > > > 	dsi-controller {
> > > > > > 		panel =3D <&panel>;
> > > > > > 	};
> > > > >=20
> > > > > That's quite similar to how my current out-of-mainline OMAP DSS DT
> > > > > bindings work. The difference is that I have a reference from the
> > > > > panel node to the video source (dsi-controller), instead of the o=
ther
> > > > > way around. I just find it more natural. It works the same way as,
> > > > > say, regulators, gpios, etc.
> > > >=20
> > > > I suppose that depends on the way you look at it. In the above prop=
osal
> > > > I consider the output (DSI controller) to use the panel as a resour=
ce
> > > > that provides a certain set of services (query mode timings, provid=
e a
> > > > way to enable or disable the panel). Similarly the panel uses the
> > > > backlight as a resource that provides a certain set of services (su=
ch as
> > > > changing the brightness).
> > > >=20
> > > > The above also follows the natural order of control. The panel has =
no
> > > > way to control the DSI output. However, it is the output that contr=
ols
> > > > when a panel is required and turn it on as appropriate.
> > >=20
> > > I'm no DSI expert, but I know enough about it to be sure that Tomi wi=
ll
> > > disagree. DSI panels can have complex power sequences that require the
> > > input stream to be finely controlled (for instance it might require a
> > > clock without video frames for some time, switch a GPIO or regulator,
> > > send a command to the panel, and then only get video frames). For that
> > > reason all developers I've talked to who have an in-depth knowledge of
> > > DSI and DSI panels told me that the panel needs to control the video =
bus,
> > > and request the video source to start/stop the video stream.
> >=20
> > Oh, I'm very well aware of the various flavours of funkiness that DSI
> > panels come in. But it's wrong to say that the panel needs to control
> > the video bus. There's simply no way that a panel can actually do that.
> > It is true, however, that in order to make this work in a maintainable
> > fashion, the DSI panel *driver* may need to control the DSI bus. That's
> > an entirely different story.
>=20
> Sure, but I don't think that's really related to the DT bindings. We don'=
t=20
> have to model every electrical signal in a detailed way that matches the=
=20
> direction of the electrons flow :-) What we need to model is a connection=
=20
> between a display controller and a panel (possibly with a direction). Wha=
t I'd=20
> like to do is to express that link in a way that can also express more co=
mplex=20
> pipeline topologies. I don't want to make it overly complex, I had hoped =
that=20
> my DT bindings proposal would be a good approach as it's both generic and=
=20
> still pretty simple.

I get that, and for what it's worth I do think that your proposal looks
simple enough and if it can solve any of the problem you're facing with
CDF, then that's great.

But I don't think we should force inclusion of these properties on every
panel, even if it doesn't use any of the graph functionality. Is there
any problem with making them optional?

Thierry

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX945AAoJEN0jrNd/PrOh4RQP+wfzpN10V+BDTIaPv+E1BHxU
p4XEw0efQl8vY90KDiw/ZVDlgtn/kLzntWnIsVIAdMseNcI8sKgSmYZu6mq0dojQ
0BAu69wTca15ItXLiqXTgHQKtSwDk0emc5q515zoqzEaFW92DDvA2/Sfw26RUHRp
X82lwxsckA/0ZwrV20s2PiisKT3nEoWEWCFPqOlqads5m9CVeieRUhgJhUeWdTQQ
uwdlcwNVXk9WM+uvZtbuj1Wl4U0yiT6MbpewpjGMi4fjq5+N83QbpyQ6IZW2Uyp3
juqMdFJphPuIFyhItnG18x4PW6e1DO5GiPS0Ok8jlqP/aHOYCdNvWJMuvBv6b67d
DW29Vl/fFpeCV2nNcG6AIAmJ2sYbpqTiFa3xLeq1VatikDxm9vd6Zohr5/I6QPsY
U8CwzN+gJ0HMOXSrk6OaAM4fpmCDMbbIF4bqz/uDod+guv2NGrDX4dQob26fYCi5
SLiMb/mv1KmTPzjLDRM2BU33uPyMot7cB6M8M9egGwzrdTvhdK1wkzHlsGPuz/f6
sKhfnMW42ub/0XY6EVCdvR5cRqa9gEhIwKUdSAIqn+RqEKJ/LNwAi9zf+W0qdTil
zPMMBUq+3Lk5gswqU2m1BLKLPATMnymjVh5RL6RulgZl0sQoW+yCUuRBP8ikCJ3F
IX2zj1/vAKBPVciCuBpx
=Pyl2
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
