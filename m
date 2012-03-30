From: Rabin Vincent <rabin@rab.in>
Date: Fri, 30 Mar 2012 15:57:13 +0000
Subject: Re: [PATCH v2] video: s3c-fb: Add device tree support
Message-Id: <CAH+eYFCrdtYC+v3tgqsaCS9-Y61JCwA1MLkkPtH14p=JWBbzBw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1333086797-1625-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1333086797-1625-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 30, 2012 at 11:23, Thomas Abraham <thomas.abraham@linaro.org> w=
rote:
> + =A0 =A0- samsung,fimd-display: The fimd controller is interfaced with t=
he a
> + =A0 =A0 =A0display device such as a lcd panel. This property should spe=
cify the
> + =A0 =A0 =A0phandle of the display device node. For a display device nod=
e that
> + =A0 =A0 =A0represents a RGB type display interface, it is expected to s=
pecify the
> + =A0 =A0 =A0video interface timing using the following properties.
> +
> + =A0 =A0 =A0- lcd-htiming: Specifies the horizontal timing for the overl=
ay. The
> + =A0 =A0 =A0 =A0horizontal timing includes four parameters in the follow=
ing order.
> +
> + =A0 =A0 =A0 =A0- horizontal back porch (in number of lcd clocks)
> + =A0 =A0 =A0 =A0- horizontal front porch (in number of lcd clocks)
> + =A0 =A0 =A0 =A0- hsync pulse width (in number of lcd clocks)
> + =A0 =A0 =A0 =A0- Display panels X resolution.
> +
> + =A0 =A0 =A0- lcd-vtiming: Specifies the vertical timing for the overlay=
. The
> + =A0 =A0 =A0 =A0vertical timing includes four parameters in the followin=
g order.
> +
> + =A0 =A0 =A0 =A0- vertical back porch (in number of lcd lines)
> + =A0 =A0 =A0 =A0- vertical front porch (in number of lcd lines)
> + =A0 =A0 =A0 =A0- vsync pulse width (in number of lcd clocks)
> + =A0 =A0 =A0 =A0- Y resolution.

In this old thread, it was suggested to use a raw EDID block to supply
timings, and since then a couple of drivers in mainline (sm501fb and
fsl-diu) are doing it that way:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/080683.html

Shouldn't this driver be doing the same thing?  If not, shouldn't
whatever interface this is adding be provided in a common helper (like
that old patch was trying to add) so it's standardized between drivers?
