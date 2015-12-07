From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 16:20:29 +0000
Subject: Re: [PATCH] fbdev: auo_k190x: avoid unused function warnings
Message-Id: <5665B1CD.2020206@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WXNqhGMH6PfRNT69XfqUJBcJwIbG6jw96"
List-Id: <linux-fbdev.vger.kernel.org>
References: <3917686.rD8ezhD468@wuerfel> <5665AF5C.4060801@ti.com>
 <1678174.Yl1Wo71dkn@wuerfel>
In-Reply-To: <1678174.Yl1Wo71dkn@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--WXNqhGMH6PfRNT69XfqUJBcJwIbG6jw96
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/12/15 18:16, Arnd Bergmann wrote:
> On Monday 07 December 2015 18:10:04 Tomi Valkeinen wrote:
>> On 20/11/15 23:47, Arnd Bergmann wrote:
>>> The auo_k190x framebuffer driver encloses the power-management
>>> functions in #ifdef CONFIG_PM, but the auok190x_suspend/resume
>>> functions are only really used when CONFIG_PM_SLEEP is also
>>> set, as a frequent gcc warning shows:
>>>
>>> drivers/video/fbdev/auo_k190x.c:859:12: warning: 'auok190x_suspend' d=
efined but not used
>>> drivers/video/fbdev/auo_k190x.c:899:12: warning: 'auok190x_resume' de=
fined but not used
>>>
>>> This changes the driver to remove the #ifdef and instead mark
>>> the functions as __maybe_unused, which is a nicer anyway, as it
>>> provides build testing for all the code in all configurations
>>> and is harder to get wrong.
>>
>> Applied for 4.5.
>>
>> Btw, do you know if the linker will optimize the __maybe_unused funcs
>> away if they are not used? I presume so.
>>
>=20
> The compiler does it correctly when built with -O1 or higher (we don't
> support -O0), and the linker is not involved here.

Ah, right, they were static. I was thinking of non-static functions. But
__maybe_unused is not even needed for non-static, so... Never mind =3D)

 Tomi


--WXNqhGMH6PfRNT69XfqUJBcJwIbG6jw96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZbHNAAoJEPo9qoy8lh71HScP/3IwDlJfZ+RRflrKN7ia6aBO
a3wt36pfMtcsOj+oeoD9TAiv8O939bQVSgAgV7Z/SER38sivcpaiJgHgAevZeMN8
w++CXlAK/LeAi6Vz/Nfp6WLk+oPknYE+XaioJU/LOdL3fKqk/oQpVEvS1L6S8AWR
mVqJQbMloDnNtTDbuojt62qYohOPm3aNLsOfkkk3CD1dZmEs/6Tf7Ajq1DZpX6mn
7w+Pt+nDFXZaSxtl4TUDt/V79lNFgYwXmF8kr22VephBGP13E4eD6j1IhZqydWEy
8a97WV2dZjC81gNfF3tVg+EUgY+zzdchdilwtNBLCyIVk333fgoF7DhDmJhLrxGN
UiLrbvdP7H1YYIUM+AGUCf/qXKdBHSspkFueRfY48EfvNBOxEQphn0ZaxkBZGF1r
LzVCxjhAWWDzg0ZaIWYbS8YRA9UmZZXKxXAlvNebrAZyJtcaWqTpMMvfY3sZ0HDY
qP8mbjFZzSFi2UUlkwM/buU5onOvZKsJ+OIxcVzPQs44TQfJnelypstbdWc4VW1v
T3heFS7HTclVhdKi48o+pNYu7ypDVi1HjaGAxPPc8BR/iHzcJ19xcU5oYjXDQKP6
G1ZgUadiItkGCj7JEX/4oMidIHfqYQtNybkS6InbwwG5C0NSO0jovDr9fKX9dmyo
qVecFuYm8eh3q89DYmjG
=9Sho
-----END PGP SIGNATURE-----

--WXNqhGMH6PfRNT69XfqUJBcJwIbG6jw96--
