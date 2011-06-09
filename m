From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jun 2011 04:56:37 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: reduce scope of a variable
Message-Id: <BANLkTikeFuUALDffAVq7MB19JgB5L6RT=A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1105051831270.29735@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105051831270.29735@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Morimoto-san,

This is already fixed in linux-2.6 git by:

commit 554cc1028603587e28ae49e9594b1508df5f29aa
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Thu May 26 15:01:22 2011 +0900

    fbdev: sh_mobile_lcdcfb: Fix up fallout from MERAM changes.

/ magnus

On Thu, Jun 9, 2011 at 1:28 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Dear Paul, Guennadi
>
> I cannot compile on current paul/master.
> below patch seems breaks compile.
> "ret" is still needed.
>
> Can you revert it or apply attached patch ?
>
> At Thu, 05 May 2011 18:32:36 +0200 (CEST),
> Guennadi wrote:
>>
>> The "ret" variable in sh_mobile_lcdc_start() is only used at one
>> location, move its definition to the inner-most scope.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>> =A0drivers/video/sh_mobile_lcdcfb.c | =A0 12 ++++++------
>> =A01 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_=
lcdcfb.c
>> index 9bcc61b..466834c 100644
>> --- a/drivers/video/sh_mobile_lcdcfb.c
>> +++ b/drivers/video/sh_mobile_lcdcfb.c
>> @@ -469,7 +469,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcd=
c_priv *priv)
>> =A0 =A0 =A0 int bpp =3D 0;
>> =A0 =A0 =A0 unsigned long ldddsr;
>> =A0 =A0 =A0 int k, m;
>> - =A0 =A0 int ret =3D 0;
>>
>> =A0 =A0 =A0 /* enable clocks before accessing the hardware */
>> =A0 =A0 =A0 for (k =3D 0; k < ARRAY_SIZE(priv->ch); k++) {
>> @@ -538,11 +537,12 @@ static int sh_mobile_lcdc_start(struct sh_mobile_l=
cdc_priv *priv)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcdc_write_chan(ch, LDPMR, 0);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 board_cfg =3D &ch->cfg.board_cfg;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (board_cfg->setup_sys)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D board_cfg->setup_sys(b=
oard_cfg->board_data, ch,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0&sh_mobile_lcdc_sys_bus_ops);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (board_cfg->setup_sys) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D board_cfg->setup_s=
ys(board_cfg->board_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 ch, &sh_mobile_lcdc_sys_bus_ops);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* word and long word swap */
>> --
>> 1.7.2.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> ---
> =A0drivers/video/sh_mobile_lcdcfb.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_l=
cdcfb.c
> index 404c03b..d0a03ef 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -617,6 +617,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc=
_priv *priv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long icb_addr_y, =
icb_addr_c;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int icb_pitch;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int pf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cfg =3D ch->cfg.meram_cfg;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mdev =3D priv->meram_dev;
> --
>
>
>
> Best regards
> --
> Kuninori Morimoto
>
>
