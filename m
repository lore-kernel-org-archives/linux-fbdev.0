From: Joe Perches <joe@perches.com>
Date: Mon, 25 Jul 2016 16:04:29 +0000
Subject: Re: [PATCH 3/3] mdacon: replace MDA_ADDR macro by inline function
Message-Id: <1469462669.1900.181.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160725152440.6734-1-jslaby@suse.cz>
	 <20160725152440.6734-3-jslaby@suse.cz>
In-Reply-To: <20160725152440.6734-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Slaby <jslaby@suse.cz>, tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Mon, 2016-07-25 at 17:24 +0200, Jiri Slaby wrote:
> MDA_ADDR is one of those macros which could be an inline function. So
> convert MDA_ADDR to mda_addr.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> =A0drivers/video/console/mdacon.c | 19 +++++++++++--------
> =A01 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdaco=
n.c
> index 814606bd26d1..24fe55134eb5 100644
> --- a/drivers/video/console/mdacon.c
> +++ b/drivers/video/console/mdacon.c
> @@ -420,17 +420,20 @@ static void mdacon_invert_region(struct vc_data *c,=
 u16 *p, int count)
> =A0	}
> =A0}
> =A0
> -#define MDA_ADDR(x, y)=A0=A0(mda_vram_base + (y)*mda_num_columns + (x))
> +static inline u16 *mda_addr(unsigned int x, unsigned int y)

Are you sure about the unsigned?
All of the changed use are taking int

> +{
> +	return mda_vram_base + y * mda_num_columns + x;
> +}
> =A0
> =A0static void mdacon_putc(struct vc_data *c, int ch, int y, int x)
> =A0{
> -	scr_writew(mda_convert_attr(ch), MDA_ADDR(x, y));
> +	scr_writew(mda_convert_attr(ch), mda_addr(x, y));
> =A0}
> =A0
> =A0static void mdacon_putcs(struct vc_data *c, const unsigned short *s,
> =A0		=A0=A0=A0=A0=A0=A0=A0=A0=A0int count, int y, int x)
> =A0{
> -	u16 *dest =3D MDA_ADDR(x, y);
> +	u16 *dest =3D mda_addr(x, y);
> =A0
> =A0	for (; count > 0; count--) {
> =A0		scr_writew(mda_convert_attr(scr_readw(s++)), dest++);
> @@ -440,7 +443,7 @@ static void mdacon_putcs(struct vc_data *c, const uns=
igned short *s,
> =A0static void mdacon_clear(struct vc_data *c, int y, int x,=A0
> =A0			=A0=A0int height, int width)
> =A0{
> -	u16 *dest =3D MDA_ADDR(x, y);
> +	u16 *dest =3D mda_addr(x, y);
> =A0	u16 eattr =3D mda_convert_attr(c->vc_video_erase_char);
> =A0
> =A0	if (width <=3D 0 || height <=3D 0)
> @@ -511,16 +514,16 @@ static int mdacon_scroll(struct vc_data *c, int t, =
int b, int dir, int lines)
> =A0	switch (dir) {
> =A0
> =A0	case SM_UP:
> -		scr_memmovew(MDA_ADDR(0,t), MDA_ADDR(0,t+lines),
> +		scr_memmovew(mda_addr(0, t), mda_addr(0, t + lines),
> =A0				(b-t-lines)*mda_num_columns*2);
> -		scr_memsetw(MDA_ADDR(0,b-lines), eattr,
> +		scr_memsetw(mda_addr(0, b - lines), eattr,
> =A0				lines*mda_num_columns*2);
> =A0		break;
> =A0
> =A0	case SM_DOWN:
> -		scr_memmovew(MDA_ADDR(0,t+lines), MDA_ADDR(0,t),
> +		scr_memmovew(mda_addr(0, t + lines), mda_addr(0, t),
> =A0				(b-t-lines)*mda_num_columns*2);
> -		scr_memsetw(MDA_ADDR(0,t), eattr, lines*mda_num_columns*2);
> +		scr_memsetw(mda_addr(0, t), eattr, lines*mda_num_columns*2);
> =A0		break;
> =A0	}
> =A0
