From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 02 Oct 2014 08:30:14 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141002083012.GC30167@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="t0UkRYy7tHLRMCai"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo> <20141001171704.GG4273@sirena.org.uk>
 <CAMuHMdXQ8bWCyaLiyOBKQNhB4rJDHBUzHnNMCf7_sPBtR1AKVg@mail.gmail.com>
In-Reply-To: <CAMuHMdXQ8bWCyaLiyOBKQNhB4rJDHBUzHnNMCf7_sPBtR1AKVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 08:43:27PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 1, 2014 at 7:17 PM, Mark Brown <broonie@kernel.org> wrote:
> >> Well, I don't think it should because it describes the same resources
> >> that the device tree node for the real device already describes. But
> >> perhaps this is one of the cases where duplication isn't all that bad?
> >
> > If we were worried about this wecould also do it by referring to
> > those nodes and saying "get all the resources these things need" rather
> > than duplicating the references (this might make it easier to work out
> > when the system is ready to hand off to the real drivers).
>=20
> You can have a single node for both simplefb and the later "real" driver.
> DT describes the hardware, not the software ecosystem running on the
> hardware. Clock, regulators, etc. don't change from a hardware point of
> view.
>=20
> If the firmware initialized a suitable graphics mode, it just has to add
> "linux,simplefb" to the compatible property (and perhaps a few other
> simplefb-specific properties).

Unfortunately I don't think that's going to work. Especially on ARM SoCs
there is no single node for a display device. The display device is
typically composed of several subdevices.

Thierry

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJULQ0UAAoJEN0jrNd/PrOhsbYQAMJFlHEByRGReWSGo7wVlwBv
XGu8yPdBo00+AMe+SK0wlqUJ+S0mVxXpR7Lv2hbJK30aNUTZ2r7LTQiv7V2az/ba
MhdyhYEgTiQByBKDlm7Ffrm7ij6mtOQn/pwNF2yfQGmecsPpuSBNn/dZSeBUFZmq
k+aaMNCpkDtKfxdQrY4SPN7GVDyNqlmuU/FfaLBcAJyiqrvnYQFajQBzobmODaXV
or/yvnS/jYjvIbxsGoB94ZXC62OxchB+i0HO+SMm9CHN0MVGZtQMV5j7L6eKDePc
Mm6EDeJYeLQTe/Mw0bqcWNC0ExXb+dVvNbY3J4Il54gLo8lHlsodcTB+dBpAXMN/
dVpo296YiujjAOrO2hbAzltCQIoGswcNB4CzrgxLLECIwF8x/N19JAQA5vAkTIEL
6GT4w+ENMhrTzGWeP4o+DmzoVf2EnSUI/nFjnr3jJ8T4M5pOPomPDL+Z659QsvR5
oJjURSdp4ocUq78c+6dZV4Dzj4S07I18RgaWWIj7HvYJWhbHu9GrU6j8TZRXCNEf
1umcABGF8c2L9iq9Of4UxbU7biSMWvupn++C+Qwsbqjgh1Cjw5Ak8RmzMRTMS4MQ
KNAPIR6aavCIOVBnBjoP4VxPytCZMBpnIE8/iEifBKKskKZ2nGUyGzxN7iX1mdC3
vPvxpX+PdV+P7YGFwXEx
=DHsc
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
