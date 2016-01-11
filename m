From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 11 Jan 2016 09:39:13 +0000
Subject: Re: [PATCH] backlight: pwm: free pwm requested by legacy API on error path
Message-Id: <20160111093913.GN14104@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20150921232338.GG11284@x1>
 <568A8DCA.6010301@mentor.com>
In-Reply-To: <568A8DCA.6010301@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 04 Jan 2016, Vladimir Zapolskiy wrote:
> On 22.09.2015 02:23, Lee Jones wrote:
> > On Sun, 14 Jun 2015, Vladimir Zapolskiy wrote:
> >=20
> >> If pwm is requested by legacy pwm_request() and if the following
> >> backlight_device_register() call fails, add pwm_free() clean-up.
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> ---
> >>  drivers/video/backlight/pwm_bl.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >=20
> > Applied, thanks.
> >=20
>=20
> I've just encountered that this change is not present in v4.4-rc, also it=
 is
> not in yours for-backlight-next branch, could you please double check the
> status of the change?

Looks like this slipped though the gaps.

Reapplied, thanks.

> >> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backligh=
t/pwm_bl.c
> >> index 9991cdb..a691247 100644
> >> --- a/drivers/video/backlight/pwm_bl.c
> >> +++ b/drivers/video/backlight/pwm_bl.c
> >> @@ -307,6 +307,8 @@ static int pwm_backlight_probe(struct platform_dev=
ice *pdev)
> >>  	if (IS_ERR(bl)) {
> >>  		dev_err(&pdev->dev, "failed to register backlight\n");
> >>  		ret =3D PTR_ERR(bl);
> >> +		if (pb->legacy)
> >> +			pwm_free(pb->pwm);
> >>  		goto err_alloc;
> >>  	}
> >> =20
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
