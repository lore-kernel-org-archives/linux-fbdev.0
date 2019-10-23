From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 23 Oct 2019 15:05:17 +0000
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <20191023150517.u4hmnd6m4qyshu6q@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo>
 <aa73b430-527c-8066-ad9c-edab62a05fc9@ysoft.com>
 <20191017151437.GA85210@ulmo>
 <CAHCN7xJduG9yxAhuW6D1_kpd5=p7LhO_YCWjVxcCoW5bmSEJGQ@mail.gmail.com>
 <20191017171326.GA531411@ulmo>
 <CAHCN7xJWco5gTdjmJZRbNqi1aO+ytor5XMJWQX8a38tfGbz+xg@mail.gmail.com>
 <f6d2427d-21fe-e89c-0bfe-572bc1d00863@ysoft.com>
 <CAHCN7xJJH12sdeLb97OutJqThv+TzMaNj-Y50_C9G7UgEQCbxg@mail.gmail.com>
 <CAOMZO5AgUjA8eSNVM_rKi-7NAX8hj039STcJ4Ov4w-0m4WTf8w@mail.gmail.com>
In-Reply-To: <CAOMZO5AgUjA8eSNVM_rKi-7NAX8hj039STcJ4Ov4w-0m4WTf8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Adam Ford <aford173@gmail.com>

On Wed, Oct 23, 2019 at 11:23:11AM -0300, Fabio Estevam wrote:
> On Wed, Oct 23, 2019 at 11:16 AM Adam Ford <aford173@gmail.com> wrote:
>=20
> > What is the plan to address the regression for 5.4?  I wasn't sure if
> > we're going to apply the i.mx fixes or temporarily revert the
> > offending patch, or something else. (or maybe nothing at all)
>=20
> Yes, I do see the regression on a imx53 board with 5.4-rc too and also
> interested on a fix.

Thierry already sent a revert of my change to the list. We only
discussed the wording shortly and I expect that this revert will make it
into 5.4.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
