From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 25 Apr 2014 10:28:07 +0000
Subject: Re: [PATCH 01/23] OMAPDSS: HDMI: lane config support
Message-Id: <535A38B7.9050009@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1eWDfs5vImUaj7WJbRNsQigxjTnCAHcL7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-2-git-send-email-tomi.valkeinen@ti.com>
 <535A3395.4050106@ti.com>
In-Reply-To: <535A3395.4050106@ti.com>
To: linux-arm-kernel@lists.infradead.org

--1eWDfs5vImUaj7WJbRNsQigxjTnCAHcL7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/04/14 13:06, Archit Taneja wrote:

> I spent some time to see if we could get create lane_cfg_val without
> having the table above, looks like there is no pattern at all in the
> register field.

There is a pattern, but I wasn't able to figure out a formula to model
it. And as the array was not very long, and was easy to create with copy
paste and search-replace from the TRM, I thought it's just simplest way
to do it.

>> +
>> +    REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, lane_cfg_val, 26,=

>> 22);
>> +    REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, pol_val, 30, 27);=

>> +}
>> +
>>   int hdmi_phy_enable(struct hdmi_phy_data *phy, struct hdmi_wp_data *=
wp,
>>               struct hdmi_config *cfg)
>>   {
>> @@ -92,8 +183,7 @@ int hdmi_phy_enable(struct hdmi_phy_data *phy,
>> struct hdmi_wp_data *wp,
>>       /* Setup max LDO voltage */
>>       REG_FLD_MOD(phy->base, HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
>>
>> -    /* Write to phy address 3 to change the polarity control */
>> -    REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
>=20
> wow, didn't realize it was hardcoded like this.
>=20
> Reviewed-by: Archit Taneja <archit@ti.com?

Thanks!

 Tomi



--1eWDfs5vImUaj7WJbRNsQigxjTnCAHcL7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWji3AAoJEPo9qoy8lh71KfwP/AlpMwMX/dM4/S8a3IvaqXIV
3gDuuP3CpBlJ/pPANQuDljHFM5y8arptmWH82MvMb6eQeNE/Tyfkt3SDx2ny3GRT
WpwHNbgZMFZGi9VWvhkELamVJ57zdrtG1VyJO8ZLfvsQinx1oPGh3Scj3FxZt7sp
sl9Qgkgkzb8FK91ZJqn6iNnQlHcd3VKAE/wdjM/1T1DTh6XiTlVf82FDfBN7LV12
gGVFabPL4daAHnFwHORemrFVeacd87TDlqDrP0VEEUdp7H/VtJdOmJMsPhaThYhU
2e+rBtHxgsKNXEPduv71+0e2XOOxKQAce4K4ey1xoiEzmKpmqI1LkVy2ZZ2ih46e
5vAcZ/zUprn7dof2C09kDEqGsNcclsaIEqm05V2sYYIOeMPfMgqo61dSABZjnSxQ
JvvIy1HlHefv1P/1/fHq/xaMWWGwxbW5OweRFe/dtVbINT2gN4G8alJrLqp92eSZ
qH3Uz7KFwClBMlN7otHBbBwHUUL/hUupcNBGGVxE1QgiVkMbeYexw8n+lqdP6Z6n
rdMpwbnsXviC9/jvqdqYwiol+jk7w0nk8SXhN6eNx0YKH+QJeo2b34wH8DbbabmA
ZNqwAptZfCuO4w/ehhk7M7Te8OUWlPpwYt0bGlbXMXO1ERO4rhW0jJaWTCxkmAgS
Didh/qmus3+3kNh455X2
=9pfF
-----END PGP SIGNATURE-----

--1eWDfs5vImUaj7WJbRNsQigxjTnCAHcL7--
