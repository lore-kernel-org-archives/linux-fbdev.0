From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 14 Nov 2012 12:03:20 +0000
Subject: Re: [PATCH v9 1/6] video: add display_timing and videomode
Message-Id: <20121114120320.GB2803@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352893403-21168-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352893403-21168-2-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1352893403-21168-2-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 12:43:18PM +0100, Steffen Trumtrar wrote:
[...]
> diff --git a/include/linux/videomode.h b/include/linux/videomode.h
[...]
> +int videomode_from_timing(struct display_timings *disp, struct videomode *vm,
> +			  unsigned int index);
> +#endif

Nit: should have a blank line before the #endif.

Thierry

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQo4iIAAoJEN0jrNd/PrOht+gQAJkiyHXQntl61lfk0YIlIdgV
NRt7JONL/qNvqUqj0fXaQTcZIRP9R8IiNzjqw5o0niiC1YDAYDETksyy+ipm0dIp
41KyzS0pRScWzJL3YBM8elMHTRiKD8vHT/3q5t5a9FeVPdIVk91Y0FXMx/14D90v
aSu99wY7FfARdMEzkEdy4EhTKRd7TUTnFsSds69dd4XK62hUMtemKcm7T3ekK75k
WbHAr8hYj/+b3IuR0EmdWf6QAIWPEol67IdBH3HI5MH7HlLmD1JSrtgwL+EGNh2U
BtFAieO7P6/3RybRmQXj0/LIHg2ylfdHSaT7qf13xn4m0ZS66A8+Y0BXJD1CRG+0
qQAB/ypKX/6opMCNS4s4XCr7Q1G7o/Hd5/tqSXx/JFP8U29hZlqZ3tLpLsJnsSwB
rmBhNOStY8Y77tdVmXeG/Q+se4QE5kt6Fg0zcGCREGipCZkIwFqqkFlqNrXhZ/t4
es5pJ8GcboyZAGDUqNxhPqCdA7GmsQ8n3KU2rPG5PLL1/j+DD5FcHfReSjifLlai
FcD9qHUF7erGmQP9whnD5x4I/LoYBsWasKugKDXuF+axc1BRHS37GNjYsVNn9iuK
dAUSC+9rBYGIP7LMPLKw7W+BdHLKs2J1zkAM/8UecfPQ+MXt4w4k8yy+zc1xxgXJ
KdFK4l73br9LAWx8Qh8w
=NCno
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
