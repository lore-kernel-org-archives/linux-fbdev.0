From: "Dighe, Niranjan (N.)" <ndighe@visteon.com>
Date: Mon, 15 Jun 2015 03:34:25 +0000
Subject: Re: [PATCH] Staging: sm750fb: fix checkpatch.pl indentation warnings
Message-Id: <20150615033409.GA2277@siberianhusky>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150614174339.GA6105@codebox> <557DCBAE.8070109@mailbox.org>
In-Reply-To: <557DCBAE.8070109@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Markus_B=F6hme?= <markus.boehme@mailbox.org>
Cc: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Jun 14, 2015 at 08:45:02PM +0200, Markus B=F6hme wrote:
> >This patch fixes indentation issues by replacing spaces by tabs at
> >the start of line
> >
> >Signed-off-by: Niranjan Dighe <ndighe@visteon.com>
> >
> >diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm75=
0fb/ddk750_dvi.c
> >index b2bf7e6..c73b74a 100644
> >--- a/drivers/staging/sm750fb/ddk750_dvi.c
> >+++ b/drivers/staging/sm750fb/ddk750_dvi.c
>=20
> >-	if(pCurrentDviCtrl->pfnInit !=3D NULL)
> >+	if (pCurrentDviCtrl->pfnInit !=3D NULL)
>=20
> You are fixing a different type of warning here. Please make only one
> kind of change per patch.
>=20
> Regards,
> Markus
>=20

Hello Markus,

Thanks for your review. I will correct and resend a new patch. Please disre=
gard
this for the moment.

Thanks,
Niranjan Dighe