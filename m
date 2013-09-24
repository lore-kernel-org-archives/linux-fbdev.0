From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Sep 2013 07:34:03 +0000
Subject: Re: [PATCH] video: mmp: drop needless devm cleanup
Message-Id: <5241406B.8090106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VG8vDOhNxgGUt8a2J70ea2exnu8NFpG7k"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130923161944.GU12758@n2100.arm.linux.org.uk>
In-Reply-To: <20130923161944.GU12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--VG8vDOhNxgGUt8a2J70ea2exnu8NFpG7k
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/09/13 19:19, Russell King - ARM Linux wrote:
> On Mon, Sep 23, 2013 at 06:13:10PM +0200, Uwe Kleine-K=F6nig wrote:
>> The nice thing about devm_* is that the driver doesn't need to free th=
e
>> resources but the driver core takes care about that. This also
>> simplifies the error path quite a bit and removes the wrong check for =
a
>> clock pointer being NULL.
>>
>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>> ---
>>  drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
>>  1 file changed, 2 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mm=
p_ctrl.c
>> index 75dca19..6ac7552 100644
>> --- a/drivers/video/mmp/hw/mmp_ctrl.c
>> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
>> @@ -514,7 +514,7 @@ static int mmphw_probe(struct platform_device *pde=
v)
>>  	if (IS_ERR(ctrl->clk)) {
>>  		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
>>  		ret =3D -ENOENT;
>> -		goto failed_get_clk;
>> +		goto failed;
>>  	}
>>  	clk_prepare_enable(ctrl->clk);
>> =20
>> @@ -551,21 +551,8 @@ failed_path_init:
>>  		path_deinit(path_plat);
>>  	}
>> =20
>> -	if (ctrl->clk) {
>> -		devm_clk_put(ctrl->dev, ctrl->clk);
>> -		clk_disable_unprepare(ctrl->clk);
>=20
> And this patch also fixes the above: disabling/unpreparing _after_ putt=
ing
> the thing - which was quite silly... :)

Hmm, I wonder if that causes any issues... I.e. should this patch go for
3.12, or is 3.13 fine?

 Tomi



--VG8vDOhNxgGUt8a2J70ea2exnu8NFpG7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQUBrAAoJEPo9qoy8lh71tZwP/ibxUYssGE9OURMD1KgDpaxI
U1v5noiZxVLhUqujzzgbFlDToWb6asPhs4897jYNClluVtvZuqoiOgTEtQAgZ8YP
c5HBTXL/4xriD1zYCGgXfm7I6nUJs9dFEIzolxUcW2CTp3hm6EsIYMoibo2E5P33
mks1Cylxa8YO4edBsppG8WodGX6d3MspHn6K6ukN/N8mkYfcjGBb8vtVL3a0Dbw2
CG0D5H4SOPe6Jwm9adlRICQ7laFm/scfdCgY8m1HevbbjL/eYbbq4SJtkaBQlhco
iJTDnwOzNAfeY0QGLwHUl3aHtDRUXP722mYtVNThj2Ej/npfyT0iulKxeAD8zYgq
PgpR2KKGHJCpHbHRAp6DUzUn5Y512YfpWdolRclAXCSQ3k5lmdbxzmBLJ/nG1APC
lLRFIjB4eg2LMirTnA8GTJAP3QC639CILeoRU1E5R3oAeAQuoXSBaajdNjcw79/f
PS/kQ1UMyq64yfHF5+7C5SsrITElDdiSecDU2OFzYoioJK9BYYG5kabbS4AOhpPb
M1tbNHpMYe64rsOBbbPW36RhtSZFTSwDdv5rYxHkjDrnrzGqEBxgkKQG1Jn+REdI
gEbHcLm4fd7BDL8kFAYU3/I8qW4JlJQjlskDANRqKCG3BtuMgK8w9EqL8pzhM0d2
2xDPtkNOA87aV5an7Nwy
=rmnL
-----END PGP SIGNATURE-----

--VG8vDOhNxgGUt8a2J70ea2exnu8NFpG7k--
