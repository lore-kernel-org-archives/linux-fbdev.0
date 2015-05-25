From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Mon, 25 May 2015 07:34:32 +0000
Subject: Re: fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150525093432.4b7a528b@hans.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150523173245.GA31663@mwanda>
In-Reply-To: <20150523173245.GA31663@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Am Sat, 23 May 2015 20:32:45 +0300
schrieb Dan Carpenter <dan.carpenter@oracle.com>:

> Hello Thomas Niederpr=C3=BCm,
>=20
> The patch a3998fe03e87: "fbdev: ssd1307fb: Unify init code and obtain
> hw specific bits from DT" from Mar 31, 2015, leads to the following
> static checker warning:
>=20
> 	drivers/video/fbdev/ssd1307fb.c:371 ssd1307fb_init()
> 	warn: add some parenthesis here?
>=20
> drivers/video/fbdev/ssd1307fb.c
>    366          /* Set COM pins configuration */
>    367          ret =3D ssd1307fb_write_cmd(par->client,
> SSD1307FB_SET_COM_PINS_CONFIG); 368          if (ret < 0)
>    369                  return ret;
>    370 =20
>    371          compins =3D 0x02 | (!par->com_seq & 0x1) << 4
>    372                                     | (par->com_lrremap & 0x1)
> << 5;
>=20
> Smatch is complaining because it's normally  "!par->com_seq & 0x1" is
> a bug and "!(par->com_seq & 0x1)" is intended.  I don't know what was
> intended here though.  If the current code is correct, you can silence
> the static checker warning by writing it as "(!par->com_seq) & 0x1".

Indeed "!(par->com_seq & 0x1)" is what I intended. Thanks for spotting
this.=20
What is the best way to handle this now? Will you send a fixup
patch as for the backlight code or will this be my task?

>=20
> But I also have a hard time remembering if | or << is higher
> precedence so that might be clearer with parenthesis as well even
> though the code is clearly correct when I google for "order of
> operations" in C.
>=20
>    373          ret =3D ssd1307fb_write_cmd(par->client, compins);
>    374          if (ret < 0)
>    375                  return ret;
>=20

Thanks!

Thomas

