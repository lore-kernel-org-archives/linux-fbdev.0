From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Thu, 15 Mar 2012 22:28:11 +0000
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Enable predecimation
Message-Id: <20120315222811.GN17132@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331812108-9776-1-git-send-email-cmahapatra@ti.com>
In-Reply-To: <1331812108-9776-1-git-send-email-cmahapatra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Mar 15, 2012 at 05:18:28PM +0530, Chandrabhanu Mahapatra wrote:
> In OMAP3 and OMAP4, the DISPC Scaler can downscale an image up to 4 times=
, and
> up to 2 times in OMAP2. However, with predecimation, the image can be red=
uced
> to 16 times by fetching only the necessary pixels in memory. Then this
> predecimated image can be downscaled further by the DISPC scaler.

Now, where does that number 16 come from? IIRC the hardware can skip
basically any number of pixels/rows. I certainly didn't add any such
limit to the code in the harmattan kernel, and distinctly remember
being able to downscale the N9/N950 UI even down to 1 pixel size :)

> Based on the downscaling required, a prior calculation of predecimation v=
alues
> for width and height of an image is done. Since, Predecimation reduces qu=
ality
> of an image higher priorty is given to DISPC Scaler for downscaling.
>=20
> This code was successfully tested on OMAP2, OMAP3 and OMAP4. Horizontal a=
nd
> vertical predecimation worked fine except for some synclost errors due to
> undocumented errata in OMAP3 which are fixed later and skewed images were=
 seen
> on OMAP2 and OMAP3 during horizontal predecimation which will be addresse=
d in
> the future patches.

All the rotation offset calculations still look suspiciously different
to what is in the harmattan kernel. I remember that the original code
was quite broken, and I fixed a lot of things when I was implementing
pre-decimation and some rotation stuff for the N9/N950. Too bad I never
managed to push that stuff upstream...

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
