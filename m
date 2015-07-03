From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 03 Jul 2015 12:32:48 +0000
Subject: Re: [RFC 1/6] drm: Add top level Kconfig option for DRM fbdev emulation
Message-Id: <20150703123246.GA29257@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <54FFFAEE.3020301@codeaurora.org>
 <20150311151731.GJ3800@phenom.ffwll.local>
 <550282C3.10903@codeaurora.org>
 <20150313090651.GZ3800@phenom.ffwll.local>
 <55126F32.90404@codeaurora.org>
 <20150325092111.GT1349@phenom.ffwll.local>
 <CAKMK7uESo7hF1h2PbcteLOUqiubXv0c7nqR=etOp6gH8=+EDjQ@mail.gmail.com>
 <55924BA6.4050309@codeaurora.org>
 <CA+M3ks4vtDfA3rxBhEoiuZ8Tv_k15ddHRvAWP+MNgLkOMArTaw@mail.gmail.com>
 <CAKMK7uF=VY54wGEkq6r6Dt9fhSfhT8zYnsf0sPmQstDfUuRdrg@mail.gmail.com>
In-Reply-To: <CAKMK7uF=VY54wGEkq6r6Dt9fhSfhT8zYnsf0sPmQstDfUuRdrg@mail.gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Thierry Reding <treding@nvidia.com>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2015 at 11:04:45AM +0200, Daniel Vetter wrote:
> On Tue, Jun 30, 2015 at 10:31 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
> > I think that what have been done by Rob with module_param is also a goo=
d idea:
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit=
/drivers/gpu/drm/msm/msm_drv.c?id=3De90dfec78ec288d6c89a7b508a5c5d4ae8b7f934
> >
> > Can you mix compilation flag and module param ?
>=20
> Hm, the point of the kconfig is to not require all the legacy baggage
> from fbdev. But I guess a module option could be added later on too.
> bochs has it too.

I think the option would primarily be useful for testing. I've often
needed to test modesetting code without fbdev getting in the way and the
only way to currently do that is by recompiling with legacy fbdev
disabled. The option would allow an fbdev-enabled kernel to be used but
disable the fbdev code if desired.

Thierry

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVloDoAAoJEN0jrNd/PrOhmrQP/RVOD086DKojEHpjbFEMERa0
oQh3Yl4Xq/8ub7TGpViDnxU2pOU1NNbPUjMsu4MDy/JLnarN3bHf09DiFkz9JZ0d
G2iHVVmRxAX6RRbDXzeBkf4DSK6y2IsxSbQ+pTcd5ZAVBS8HsALmOsikDcXlXOf/
U4km1ikEYbTcwyoRA1+kdCVrOXKaXOCZgIWc9dD2eKIcoo0ffeos+Vpxh2aIk1dP
avCl49qeGKZlArUoGahB5P8AOTPaqKte6NAlCZy4G2Y9F8RYtv+rx8Cs5JuYQs+h
c1Ua9KuQu9zgi40qzWyMlFA9Q7KsXyOgMTSYtqOlucqIggbCHdjRrSFJ8I+7KAbg
igVGGrjNdqP+mGs/mW6zDAd2q4QRoBXzR/Uf049ShQEv8Ti7xLo16xIcnfsXTi8y
86wWwFhMUdwUuOnoiumiK71YqMOrVnq+OJSdx/zopJHZjXtu/ySYupbwnTlB24ld
eOUPgCooCUb7etmsXH4UBYHzzbf2bRqbyR1HnPj45wvfIph88MeRXy/EvspKpkli
bkEoaun2iAphM7M6RksxAxxTVW1I+3H4KyX92PUAd70RD8J1T1RNljvJVgH0zQ58
6wzWpTTbGVm2EfgUWAq/EK/yOYmZF9fsDiAf8w/23ypaVFzhJPYJAwWAT4TKjUmj
rp9DTZxyevAbdI+ndu2k
=Dbke
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
