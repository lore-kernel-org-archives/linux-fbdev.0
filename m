From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 12 May 2012 11:51:31 +0000
Subject: Re: ASoC: wm9712: Microphone doesn't work: Mux handling broken?
Message-Id: <20120512115130.GI1781@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Encpt1P6Mxii2VuT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<1335513602.3504.4.camel@mars>
	<20120427134638.GI18260@opensource.wolfsonmicro.com>
	<20120504132845.GA24245@lovely.krouter>
	<20120507215506.GA5063@lovely.krouter>
	<20120508102947.GA8226@lovely.krouter>
	<20120512001556.GA26105@mars>
In-Reply-To: <20120512001556.GA26105@mars>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>, linux-fbdev@vger.kernel.org


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 12, 2012 at 02:15:56AM +0200, Christoph Fritz wrote:

> They refuse to change their Item0 because they are defined as
> SND_SOC_DAPM_MUX without a correlating path->name so that
> snd_soc_dapm_mux_update_power() (in sound/soc/soc-dapmc) doesn't
> change anything.

A route into a mux without a path name (other than a supply) just isn't
meaningful and I'm surprised it ever worked.

> It works in 2.6.33, but current kernel has different mux handling and
> it seems that no one since cared that much about microphone support.

It's nothing to do with microphones really, it's more that AC'97 CODECs
are rarely used with modern kernels as the boards that use AC'97 are
mostly quite old and suffer performance issues with modern software
stacks so newer kernels haven't been getting much testing with them.

> Mark, can you confirm this, purpose a fix or even come up with
> a patch?

Just filling in the appropriate mux value in the relevant route should
do the trick.  Looking at the code it looks like the widget isn't hooked
into the audio routing map at all so I'm a little surprised.  I'm out of
the office at the minute and so can't readily set up a test system
myself.

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrk6hAAoJEBus8iNuMP3d5HYP/3BZucAGeyZlfgbmQMviFVk1
Pw4ZsGIZuAdjRw4LuM5MWL90XJg8OMURRB6wwESF+xmWHjfLdVROB/DngXMun9eR
XsaV/CXzs02eIiZJbf/65TlHjAeCM5e8oqth/b1gci1FU42UqoCKtf+XlYrWM3y8
A0yGqro6qU6cyA1HRBP+oIK9YdiPsMpwGEFqK6h7RtEwwrcz7f62mkX12mv22Ymb
pqk35TpDAVO2eGxWzFXgmHx0WgbmRZ1bcVwCx//gfQk5/392dtrt+jqdvq81CpmU
wnHF/hkqi/srG7m80kTni5jQtoYObostYpf3XgxF4DvOTX+F5oLyvR9GcAQggaVH
b2oeKo0CV0VOIDmggk7Ttj9iC5E03RRahZizLcNu1akrzkeIKr2SVJSZC5MNMMEn
zyf1I1F2Wfqp4wwWRe2k9k1Q7AvId3MNZuo7s8Hl6aORKz+vbRSNEL9Qm0cG2aYw
ShLbdZJ5HVNQrYgf3r04ahvGF4H6u/hQCfKO1PlNhxtl0xBhG8ekgY1cJiV9pH70
V204pHkekFJixhRdpmXGfriNP3g32F5zKRdE8pAKov550ETNJ74q6ZdgA+yO9oFK
5bHKYsJr+JbHDHV0nmKJfeMLQTLGGUR3km/odoCSt3nM914VSHwIdBiVMMQ6Ud6L
8XvpX9USiRVY2ZG4WX6u
=Z58H
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
