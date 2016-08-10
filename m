From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Aug 2016 10:44:42 +0000
Subject: Re: [PATCH] omapfb: panel-dsi-cm: Remove deprecated create_singlethread_workqueue
Message-Id: <9378ac72-7bc2-fcc8-66f0-9f34f9a302eb@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aPtrrsCKs5IGTkrQdOMmVX13wwrTVFLpd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160702082540.GA26570@Karyakshetra>
In-Reply-To: <20160702082540.GA26570@Karyakshetra>
To: linux-fbdev@vger.kernel.org

--aPtrrsCKs5IGTkrQdOMmVX13wwrTVFLpd
Content-Type: multipart/mixed; boundary="9TcBbw6F0LX2C04kt4c5ctw1E7UXev2fO"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Dave Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>
Cc: tj@kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-ID: <9378ac72-7bc2-fcc8-66f0-9f34f9a302eb@ti.com>
Subject: Re: [PATCH] omapfb: panel-dsi-cm: Remove deprecated
 create_singlethread_workqueue
References: <20160702082540.GA26570@Karyakshetra>
In-Reply-To: <20160702082540.GA26570@Karyakshetra>

--9TcBbw6F0LX2C04kt4c5ctw1E7UXev2fO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/07/16 11:25, Bhaktipriya Shridhar wrote:
> The workqueue "workqueue" has only a single workitem(&ddata->ulps_work)=

> and hence doesn't require ordering. Also, it is not being used on a
> memory reclaim path. Hence, the singlethreaded workqueue has been
> replaced with the use of system_wq.
>=20
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreade=
d
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueu=
e
> created with create_singlethread_workqueue(), system_wq allows multiple=

> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
>=20
> dsicm_remove() calls dsicm_cancel_ulps_work which uses
> cancel_delayed_work() to ensure that there are no pending tasks while
> disconnecting the driver.
>=20
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 14 ++------=
------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Thanks, queued for v4.9.

 Tomi


--9TcBbw6F0LX2C04kt4c5ctw1E7UXev2fO--

--aPtrrsCKs5IGTkrQdOMmVX13wwrTVFLpd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwWaAAoJEPo9qoy8lh71K7AQAI3bukCejBo/mLCHMji7IbZH
5xnOxQUjg0sCMSW9UOSLnkkkFGY5DNIpqAY5mLrHYeS9SxKEDT7Q+c/XI4XZWQHT
02EhP2P5AMuWK4Jr58Wcr4ldqmaBSyOCCGRnd/kP9Einl/EeNmixu4JfjUvM4r01
ZrrzFoxKBaAKhptelYlBTnSyuuVQzUpw8huuAPZhsrasY4+RZzWCyyKdXB75OS/E
ODl/+ZKHw55IvVZuUt6IR4hj3pC912/Bi6D6JoTTudgiHAyln0G7gjq9pR38aMn/
054rS2BLsexh22nZ0PRhnAtAEvwLwyKrS03A1rk3Rp9ePm2r6e4H+p0K/XoWWdpP
VyEfVmcJ6FTqQy1krs6qSJu646rWJ4FYN+7SXyEsR+V/SOCsFFcuIExOMP+YnKDX
dxPe5Zx7NHrokMoJozXwkx7VvmR2uMk/Zm8NfL+Rn/qxCgtQfkhKoGKiv/17DYB1
8jPS9oE0eZv/Ol6eNcpv70aRwNcrbV3Yp/ED6vdeNUCd9395Vnb5a8phOqi/fnON
xQeH4Z/X7BjXZBDkAOtU7KQRQ3oLBuEZ3+s09bZNe3RC7KoZ6c8i1qRZ5rSjIqhM
PdV/t6Msa2iAR9hVTDSXgLSEnqUL0eVHYahT2vXBwyagnPxr0+6GiVE6xVGd6Ziy
1ZfV4CbEV/9l4ivJQ5bf
=Oodn
-----END PGP SIGNATURE-----

--aPtrrsCKs5IGTkrQdOMmVX13wwrTVFLpd--
