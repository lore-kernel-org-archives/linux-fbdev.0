From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 14 Feb 2013 06:58:30 +0000
Subject: Re: [PATCH 16/33] OMAPDSS: acx565akm panel: handle gpios in panel driver
Message-Id: <511C8B16.5060605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigD5926CF0DD951EA0EEB106FD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-17-git-send-email-archit@ti.com> <20130213172913.GD21750@blackmetal.musicnaut.iki.fi> <511C896C.10007@ti.com>
In-Reply-To: <511C896C.10007@ti.com>
To: Archit Taneja <archit@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigD5926CF0DD951EA0EEB106FD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-14 08:51, Archit Taneja wrote:
> On Wednesday 13 February 2013 10:59 PM, Aaro Koskinen wrote:
>> Hi,
>>
>> On Wed, Feb 13, 2013 at 07:52:08PM +0530, Archit Taneja wrote:
>>> +static struct panel_acx565akm_data *get_panel_data(struct
>>> omap_dss_device *dssdev)
>>> +{
>>> +    return (struct panel_acx565akm_data *) dssdev->data;
>>> +}
>>> +
>>>   static int acx_panel_probe(struct omap_dss_device *dssdev)
>>>   {
>>>       int r;
>>>       struct acx565akm_device *md =3D &acx_dev;
>>> +    struct panel_acx565akm_data *panel_data =3D get_panel_data(dssde=
v);
>>
>> Why the get_panel_data function is needed, isn't the cast unnecessary?=

>=20
> the 'data' member of omap_dss_device has the type 'void *', we need to
> cast it to access the panel_acx565akm_data struct pointer.

You don't need an explicit cast to assign a void pointer to a pointer to
something else (or vice versa, I think).

I remember us having similar constructs in some other panel drivers
also. I think they are unnecessary also.

 Tomi



--------------enigD5926CF0DD951EA0EEB106FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHIsaAAoJEPo9qoy8lh71DagP/2AWmFobedsJxjjUF7CpEsw9
ddqFIuI/fuHo5PXLCsjRbsspUOX7PSlly3f8VQYzVdFu1zdAVfczGHwR3EFFgh/v
Tjq1tIpWxDktI0lpIArfIZTpG0YtNRB/y+NxbU8rNkrvDZ0y+t+ju9ChDRt64Eqc
jmO/CDGwf5kKf5+qVHVCm+0QtdC31dlWwNkmdM+a3/yUuA7XGshJuaiX5JNw5a0w
uXcYjOR8ELLDQwNw5sifk8rMnqGjeKMH83lAaScpp/Zpej6VZhtAbc9Lw7djqhd4
yCpc847mB/ZSIn82UUJR5r/M/w/VVxf6X7J9DU9duiTaGqur8suNMffin+gbch76
PorBR4PU3Tv7KFp7uDVs5KgEfkRQjjkkWFgJR32uKjrccA19U/sM5MiWMZ9sDF37
O+x54c3UApDDkqkPjLokLzanIopwdGVtgzo/ysKYQhh2GBFFev8NfnAQCpSf7AA3
fXSPWhY4aLYQL4ZSlt9BlALsGslLkF8cTqXEIbAzIhFHlMKo6cfQpwRlfGkfhhSh
CZ7L0MzaaUg61ZwBi6dnho0PRaCTy2Yur63KRhStk6HMSmncCRmdefv3ZBNtVZp9
6QR+J5GuGiR5RcA4bSUL0DEbZKyuPwZVJbJDM9PQHDSilc6+FVexvY6Ga4HNCOB0
YSqwexyB1m8kkama+THL
=Q0li
-----END PGP SIGNATURE-----

--------------enigD5926CF0DD951EA0EEB106FD--
