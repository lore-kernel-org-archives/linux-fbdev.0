From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 02 Dec 2011 10:05:43 +0000
Subject: Re: backlight/ld9040.c: regulator control in the lcd driver
Message-Id: <CACRpkdan-zKk6TN15MkbEuNk5C949SL-jniK98vReFTzfvGC4w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
 <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
 <CAH9JG2XdDn26ziceug6-Dc8g3+z3AUuzL34-oHRy10qL2RjF2w@mail.gmail.com>
In-Reply-To: <CAH9JG2XdDn26ziceug6-Dc8g3+z3AUuzL34-oHRy10qL2RjF2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 2, 2011 at 9:57 AM, Kyungmin Park <kyungmin.park@samsung.com> w=
rote:
>>[leedonghwa]
> [Me]
>>> + =A0 =A0 =A0 =A0 lcd->reg_vdd3 =3D regulator_get(lcd->dev, "vdd");
>>> + =A0 =A0 =A0 =A0 if (IS_ERR(lcd->reg_vdd3)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(lcd->dev, "no %s regulat=
or found\n", "vdd");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd->reg_vdd3 =3D NULL;
>>> + =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 lcd->reg_vci =3D regulator_get(lcd->dev, "vci");
>>> + =A0 =A0 =A0 =A0 if (IS_ERR(lcd->reg_vci)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(lcd->dev, "no %s regulat=
or found\n", "vci");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd->reg_vci =3D NULL;
>>> + =A0 =A0 =A0 =A0 }
>>
>> As explained in earlier discussion with Mark regarding the SMSC911x
>> driver regulator, treat these as errors and do not fail
>> "gracefully" like this.
>>
>> Reference:
>> http://marc.info/?l=3Dlinux-netdev&m=131914562120725&w=3D2
>
> As mentioned at commit message, the lcd regulator is optional part and
> refer the mmc codes
>
> =A0 =A0 =A0 =A0host->vmmc =3D regulator_get(mmc_dev(mmc), "vmmc");
> =A0 =A0 =A0 =A0if (IS_ERR(host->vmmc)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_info("%s: no vmmc regulator found\n", m=
mc_hostname(mmc));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->vmmc =3D NULL;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_enable(host->vmmc);
> =A0 =A0 =A0 =A0}
>
> Previous time, these codes are located at board file, but more boards
> are used, it has same codes for all boards. so move it to drivers.

I know. This was brought up in the aforementioned discussion,
but the above is also wrong, simply. See:
http://marc.info/?l=3Dlinux-netdev&m=131914562120667&w=3D2
http://marc.info/?l=3Dlinux-netdev&m=131914562120690&w=3D2
http://marc.info/?l=3Dlinux-netdev&m=131914562120725&w=3D2
http://marc.info/?l=3Dlinux-netdev&m=131963332527416&w=3D2

> In our case, it has the regulator but some boards don't.
>
> Umm then how to handle the regulator gracefully?

Mark suggest using a fixed-voltage regulator for boards
where the power is always on. The voltage level itself
is optional. See:
http://marc.info/?l=3Dlinux-netdev&m=131963332527416&w=3D2

Other approaches is to use dummy regulators, or not
call regulator_has_full_constraints(), which means the
regulator core will provide dummy regulators anyways.
See:
http://marc.info/?l=3Dlinux-netdev&m=131973043527112&w=3D2
http://marc.info/?l=3Dlinux-netdev&m=131975178703166&w=3D2

Whole thread of discussion:
http://marc.info/?l=3Dlinux-netdev&w=3D2&r=3D1&s=3Dsmsc911x&q=3Db

Yours,
Linus Walleij
