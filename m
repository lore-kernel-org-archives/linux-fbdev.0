From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 15 May 2012 17:15:59 +0000
Subject: Re: ASoC: wm9712: Microphone doesn't work: Mux handling broken?
Message-Id: <20120515171553.GA4140@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120426213745.GA18260@opensource.wolfsonmicro.com>
	<1335513602.3504.4.camel@mars>
	<20120427134638.GI18260@opensource.wolfsonmicro.com>
	<20120504132845.GA24245@lovely.krouter>
	<20120507215506.GA5063@lovely.krouter>
	<20120508102947.GA8226@lovely.krouter>
	<20120512001556.GA26105@mars>
	<20120512115130.GI1781@opensource.wolfsonmicro.com>
	<20120513035652.GA3532@lovely.krouter>
	<20120515091541.GA4433@lovely.krouter>
In-Reply-To: <20120515091541.GA4433@lovely.krouter>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>, linux-fbdev@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 15, 2012 at 11:15:41AM +0200, Christoph Fritz wrote:
> On Sun, May 13, 2012 at 05:56:53AM +0200, Christoph Fritz wrote:

> > > Just filling in the appropriate mux value in the relevant route should
> > > do the trick.

> Do you mean filling in to wm9712_audio_map or wm9712_enum?

There will need to be routes in the audio map.  Don't know if there are
any fixes needed in the enum, it was the routing I noticed was missing.

> > > Looking at the code it looks like the widget isn't hooked
> > > into the audio routing map at all so I'm a little surprised.

> Does that mean that wm9712_dapm_widgets should be referred by a
> struct snd_kcontrol_new ?

No, that should never happen.

> > >I'm out of
> > > the office at the minute and so can't readily set up a test system
> > > myself.

> I'm not that into alsa and would greatly appreciate if you could have
> a look with your test system.

For personal reasons I don't really have an ETA for when I'll be in the
office, sorry.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPso9CAAoJEBus8iNuMP3dsxYP/iSMqepyHuLixXwK4EOGttZ4
PS9cIzhpFsFijqsnRhuGgbxPu3YAQLWEpxEIuFNyG/ff5T4Cot0u8zaLCll4or8x
BWdvWsisPVfUagh9LEP9pbnuO1WIDL5sTYK5DwFAx5mKtE0Izmy89VJzfVqCl2/C
Z+QNLSJPjiyBwdq/L9urmRv9VBn5pp4l0xyNsko+6ATqQKHSkA9Nilw1K4Qbq5X+
bYJ/aWOYUfywYoogHU6P+baEpoCJLVDHKOIU9qllzEyDihUm3oSsPgASxN/OP9A+
yOMzHh8qyIqMPO3/n/Ij2UPwf/e7lFXOnumUnx7hMYQFq/dHVfvPA6HRfU9JSlC7
ovdukiEe4R8tf1zMzzGP/qAVL/d/GVlH0g9OBZiUays0jM17Hf6VlFSAPuXVP/WM
2tCwoyeHItV3f/VrU3JUq9Sg8qgzUr2pKKVN0UTzsei0ZwvUZDaF+yCuF+98sPBf
Uq6iaGYiNw6GvsxPfi2H75RUQCngTpxb/PHVKlImH/+K5fbmEpUIWHZcLVv/cCr+
r5lQsbWAckZGM73oCRKTjRCJABYSdk0uTvh5ss5fQAswgqgnpoBhqhtV9rhToS8+
R8Jsyjq4f+zMavWWQyesphIcsYSzqdmLABvdjNHRBDPPSQfzS7/UrsqT5RB7FIn1
S0FQc/u+6c3/YqkrXxue
=jDUq
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
