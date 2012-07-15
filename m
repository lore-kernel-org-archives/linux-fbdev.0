From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 15 Jul 2012 21:40:34 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120715214033.GK4041@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9aCKuHbn5v2q3RVc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <4FFE4DD0.7020407@nvidia.com> <50006935.2080606@nvidia.com>
In-Reply-To: <50006935.2080606@nvidia.com>
To: linux-arm-kernel@lists.infradead.org


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 14, 2012 at 12:00:14AM +0530, Prashant Gaikwad wrote:
> On Thursday 12 July 2012 09:38 AM, Prashant Gaikwad wrote:

> >About repeating frequencies, operating voltage for a frequency
> >would be the highest one mapped in the table.

This sounds very surprising...  that would generally just result in
higher power consumption.

> >I know this makes reading difficult but it provides flexibility,

> Does this explanation help?

The loss of comprehensibility seems like a really major disadvantage for
very little practical gain here.  Big arrays in DT are already hard
enough to read without adding extra complexity on top of that.

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQAzjKAAoJEBus8iNuMP3dqncP/RmvCwSe+KiN+22X3SQdm3Rf
1MNvK1d78WF/Svu+hBZrWbSt+IyBPkHo+3RV0nMbOS90o2ir6kbopGk3CgJVZyjm
rI9cm+kauBt9fU6A+ephmqGJtq0Ilbuy25iR2T9Mq+PXu4JrGRm0M/qUb/x8b1v5
D1w9U55FjiGA+RXpUnnJiP4NI1gMuQu7fRtbQrYaFIlyeW+sS0hTu6ViEkBYRYCD
yl7auJBvvQw5pvXyBCfBbUGjL5NVh8k964+Jeq8iRpa9Vjll+W1I3qpBnc2pxrJz
kmbCy1jkKWQlM1k4IugK4jNnyGrmuZH6FZcnVtfHQQ9pFnwOc74XJg45EDlwHzAu
0ddjJNkJONoul/W+ipVJTpwVB3P+ywuZeKE4djHnRH+rhvhjACFkdQ5dHk9l3C4K
lNsEL2tVGvqU7kBAw6C3gLWlQqH2Y5RKS4t9NMVdz+Gqt1E0lh+kt7SMfjPMhHvQ
OX3W36RqPPB/WprcUF6jGiMTCdKeJ/dzNfT9PSLKixcKT2y7evYRxgZ9cL02yI3b
mCtz7RbyAGbIAYUjEr2t2bBHAKy3xzMLotV2baiWd961JZgghX81ZgEmk/QcELpL
KEthTpqwpikuxHbY3k0s6H8pAI9KUQ9XYxE6VIiTC1gSme5xFtLOYGu/Mb6ij0Jr
22nHz4L1TqN/5lJmrwyu
=U9PK
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
