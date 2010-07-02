From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Jul 2010 08:17:09 +0000
Subject: Re: [PATCH 2/6] sh: add a reparent function to DIV6 clocks
Message-Id: <AANLkTimOUjFadAxidYGQ2UyL6kewKXOdb1iX3jJHvh7K@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Add support for reparenting of div6 clocks on SuperH and SH-Mobile SoCs.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/sh/clk-cpg.c =A0 | =A0 58 ++++++++++++++++++++++++++++++++++++=
++++++++++-
> =A0include/linux/sh_clk.h | =A0 19 +++++++++++----
> =A02 files changed, 70 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/sh/clk-cpg.c b/drivers/sh/clk-cpg.c
> index f5c80ba..7e247ae 100644
> --- a/drivers/sh/clk-cpg.c
> +++ b/drivers/sh/clk-cpg.c
> @@ -68,6 +68,39 @@ static unsigned long sh_clk_div6_recalc(struct clk *cl=
k)
> =A0 =A0 =A0 =A0return clk->freq_table[idx].frequency;
> =A0}
>
> +static int sh_clk_div6_set_parent(struct clk *clk, struct clk *parent)
> +{
> + =A0 =A0 =A0 struct clk_div_mult_table *table =3D &sh_clk_div6_table;
> + =A0 =A0 =A0 u32 value;
> + =A0 =A0 =A0 int ret, i;
> +
> + =A0 =A0 =A0 if (!clk->parent_table || !clk->parent_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* Search the parent */
> + =A0 =A0 =A0 for (i =3D 0; i < clk->parent_num; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk->parent_table[i] =3D parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 if (i =3D clk->parent_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 ret =3D clk_reparent(clk, parent);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 value =3D __raw_readl(clk->enable_reg) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(((1 << clk->src_width) - 1) << clk->src_s=
hift);
> +
> + =A0 =A0 =A0 __raw_writel(value | (i << clk->src_shift), clk->enable_reg=
);
> +
> + =A0 =A0 =A0 /* Rebiuld the frequency table */

Nit: Typo in the comment above.

Looks ok apart from that.

Cheers,

/ magnus
