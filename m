From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 10:24:21 +0000
Subject: Re: [PATCH 1/2] video: jz4740-fb: Fix LCD_CMD bit definitions
Message-Id: <52440B55.5070703@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sj7ullQsD6t5uBv6ctokSCEm4TA5056Eb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379844109-10513-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1379844109-10513-1-git-send-email-lars@metafoo.de>
To: linux-fbdev@vger.kernel.org

--Sj7ullQsD6t5uBv6ctokSCEm4TA5056Eb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22/09/13 13:01, Lars-Peter Clausen wrote:
> Fix the bit offsets for the LCD_CMD definitions.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/video/jz4740_fb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
> index 2c49112..23aa475 100644
> --- a/drivers/video/jz4740_fb.c
> +++ b/drivers/video/jz4740_fb.c
> @@ -99,9 +99,9 @@
>  #define JZ_LCD_CTRL_BPP_15_16		0x4
>  #define JZ_LCD_CTRL_BPP_18_24		0x5
> =20
> -#define JZ_LCD_CMD_SOF_IRQ BIT(15)
> -#define JZ_LCD_CMD_EOF_IRQ BIT(16)
> -#define JZ_LCD_CMD_ENABLE_PAL BIT(12)
> +#define JZ_LCD_CMD_SOF_IRQ BIT(31)
> +#define JZ_LCD_CMD_EOF_IRQ BIT(30)
> +#define JZ_LCD_CMD_ENABLE_PAL BIT(28)
> =20
>  #define JZ_LCD_SYNC_MASK 0x3ff
> =20
>=20

Thanks, queuing this and the second patch for 3.13.

 Tomi



--Sj7ullQsD6t5uBv6ctokSCEm4TA5056Eb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRAtVAAoJEPo9qoy8lh71DGYP/jQjqwc6kxBqgwxihnUKKV+u
xKPoVR7yIsNUxss4zSYSOBFAkl8UBcde2P0D7uq2cMoEYbNB9yue9y1zvrszv+iS
8IGrikeizhS/4HeH6R8hWBxmgq9gv+/SYjPoWiwYWZOewFE48W3ysqGEG6szaTg4
MwfpHsghuz+DX+MBErTmg7DWXkSbilQPzCXnMhFU5ZLibIanBeim6vqAFRgl8tsD
eTCvSegVCtJfHHaZuDSwPdNJIKLw1EFeTL11k34jKT7eDb/+/5QJ3PecDJ/opDkz
IodOYKmieNvUP0BbmdjlJ5uGnkhHQH/ifVT5qGBnQFrSvx856m+7v6b0bXgQ6bY9
28PujnjKjkg5w34l0RlefzX3KFVvWCu4GIBOobRcNVrAu4TG36t4uiLNz2Rg90eo
0tl4uobcX0i06zaDakSFuxWMpFNQCiz6xWl1710dVZSJVbn4b8qyWLfHdZ8sj+Ql
ekKN7RSAnxR1jdbaB0ypzefJZkPTyUpgtoQjEMnt41e1qUyfFUhrJ8ZqJ2SxEc0L
5CI0wqNFudLrH86JR58cGvoqDBP4qvQ/AUd4mNL7026iyC4KIeLVvL4rNBrqObY9
vw35wCNC0LOk9JssryFQ45twtQcwv1JFX55fXlwXD9T2a9wq7cPYNnX7jtMKpGhO
NubveCYMImwWHU/3UTJD
=UHfH
-----END PGP SIGNATURE-----

--Sj7ullQsD6t5uBv6ctokSCEm4TA5056Eb--
