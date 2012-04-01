From: Shawn Guo <shawn.guo@linaro.org>
Date: Sun, 01 Apr 2012 06:41:24 +0000
Subject: Re: [PATCH v2] video: s3c-fb: Add device tree support
Message-Id: <20120401064121.GC2395@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1333086797-1625-1-git-send-email-thomas.abraham@linaro.org>
 <CAH+eYFCrdtYC+v3tgqsaCS9-Y61JCwA1MLkkPtH14p=JWBbzBw@mail.gmail.com>
In-Reply-To: <CAH+eYFCrdtYC+v3tgqsaCS9-Y61JCwA1MLkkPtH14p=JWBbzBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 30, 2012 at 09:25:14PM +0530, Rabin Vincent wrote:
> On Fri, Mar 30, 2012 at 11:23, Thomas Abraham <thomas.abraham@linaro.org>=
 wrote:
> > + =A0 =A0- samsung,fimd-display: The fimd controller is interfaced with=
 the a
> > + =A0 =A0 =A0display device such as a lcd panel. This property should s=
pecify the
> > + =A0 =A0 =A0phandle of the display device node. For a display device n=
ode that
> > + =A0 =A0 =A0represents a RGB type display interface, it is expected to=
 specify the
> > + =A0 =A0 =A0video interface timing using the following properties.
> > +
> > + =A0 =A0 =A0- lcd-htiming: Specifies the horizontal timing for the ove=
rlay. The
> > + =A0 =A0 =A0 =A0horizontal timing includes four parameters in the foll=
owing order.
> > +
> > + =A0 =A0 =A0 =A0- horizontal back porch (in number of lcd clocks)
> > + =A0 =A0 =A0 =A0- horizontal front porch (in number of lcd clocks)
> > + =A0 =A0 =A0 =A0- hsync pulse width (in number of lcd clocks)
> > + =A0 =A0 =A0 =A0- Display panels X resolution.
> > +
> > + =A0 =A0 =A0- lcd-vtiming: Specifies the vertical timing for the overl=
ay. The
> > + =A0 =A0 =A0 =A0vertical timing includes four parameters in the follow=
ing order.
> > +
> > + =A0 =A0 =A0 =A0- vertical back porch (in number of lcd lines)
> > + =A0 =A0 =A0 =A0- vertical front porch (in number of lcd lines)
> > + =A0 =A0 =A0 =A0- vsync pulse width (in number of lcd clocks)
> > + =A0 =A0 =A0 =A0- Y resolution.
>=20
> In this old thread, it was suggested to use a raw EDID block to supply
> timings, and since then a couple of drivers in mainline (sm501fb and
> fsl-diu) are doing it that way:
>=20
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/080683.html
>=20
> Shouldn't this driver be doing the same thing?  If not, shouldn't
> whatever interface this is adding be provided in a common helper (like
> that old patch was trying to add) so it's standardized between drivers?

+1

We need a generic binding for the data defined in "struct fb_videomode"
and a generic helper function to retrieve the data from device tree,
so that individual display driver does not have to invent their owns.

--=20
Regards,
Shawn
