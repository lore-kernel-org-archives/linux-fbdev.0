From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 17 Sep 2012 06:04:44 +0000
Subject: Re: [PATCH] pwm-backlight: Use devm_pwm_get in pwm_bl.c
Message-Id: <20120917060444.GA848@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2012 at 09:55:48AM +0900, Jingoo Han wrote:
> On Tuesday, September 11, 2012 5:42 PM Sachin Kamat wrote
> >=20
> > This file already makes use of device managed functions.
> > Convert pwm_get() too to use it.
> >=20
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>=20
> CC'ed Thierry Reding.
>=20
> Acked-by: Jingoo Han <jg1.han@samsung.com>

Hi Sachin,

As discussed elsewhere I'm taking over maintenance of the pwm-backlight
driver as part of the PWM subsystem. I hadn't been Cc'ed on your first
send and I'm not subscribed to linux-fbdev so I didn't receive a copy of
the patch.

Thanks,
Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVr18AAoJEN0jrNd/PrOhpJEQAILIxyRD3aKZ5C/FcAkk/z6i
nSOAW2gwf39O+OqrZHJxPnpVE5m2qTzYHQycD7YLDmqdo9m5VZXokzhZZh6ah8Yv
w+KcJSV2EXUetLZnWLQKirJccjx7xxBk9EZbrTXG5cN3TiMm7FCS2QzNt+abci6y
C3cZKsj0H/xFk5wOUIR1y8/Oz831A5lfUD16J6I/Dgf7CmXn0wIUO5kV9+VicljX
ruOpQghiQ3SMZIoXJ4nMjg53VW755mzih6c7dwxbzu1ENxJ+dgX4mpwBOBRTFe+v
Eba70ieaOH/TINo9VIMAzNgY0DbXJ0vtZ41n/VrF5UUI8p2G/8n9UuIiyfJD+9DV
frlasSl3n4HpNi6EJ3zY9gvBdqjttmzxTNI+mX6/wwLIP+iVKjHqC6IL1fEPppOB
Y+t9eT6QQS8/ZRLwQXWTOCdkP/boFWbT9qlDjk3DD9WINwIo3cLAA5Fb+OFYz+Pm
zlWSIq+nc8+ehsUuSjskVChoRjVe4QN6iHvQURQK/8MnmzrFedEGrze4rvygBYkK
/w6qNZ+gKkHcd0z+c6ICD0v1uwcadtzg/WAbE6bxH5uwqJryBdWgGjuhIdy+am48
bH6/iFyeTT1mrbe1rJOx8ScZr0wb3cVwTdqkyOPAQZ7YuV7+IlIiMC3zKkHH2vyB
YqxQGIMVrz6DAHnk/9UZ
=xwtc
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
