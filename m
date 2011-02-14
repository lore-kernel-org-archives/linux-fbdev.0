From: Kyungmin Park <kmpark@infradead.org>
Date: Mon, 14 Feb 2011 00:19:18 +0000
Subject: Re: [PATCH] video: s3c-fb: return proper error if clk_get fails
Message-Id: <AANLkTin14rCD1y8sLmSffA4Yhv5WZLXbn9nXPSEn=fCQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297414270.14046.1.camel@mola>
In-Reply-To: <1297414270.14046.1.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Feb 11, 2011 at 5:51 PM, Axel Lin <axel.lin@gmail.com> wrote:
> Return PTR_ERR(sfb->bus_clk) instead of 0 if clk_get fails.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0drivers/video/s3c-fb.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 83ce9a0..6817d18 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1340,6 +1340,7 @@ static int __devinit s3c_fb_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0sfb->bus_clk =3D clk_get(dev, "lcd");
> =A0 =A0 =A0 =A0if (IS_ERR(sfb->bus_clk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to get bus clock\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(sfb->bus_clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_sfb;
> =A0 =A0 =A0 =A0}
>
> --
> 1.7.2
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
