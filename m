From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [PATCH 10/16] viafb: fix sparse warning: Using plain integer as 
	NULL pointer
Date: Fri, 27 Feb 2009 02:07:29 +0100
Message-ID: <154e089b0902261707j4e22787boecedaa097b2777b2@mail.gmail.com>
References: <20090221235706.17557.97714.stgit@vmbox.hanneseder.net>
	 <20090222000441.17557.22989.stgit@vmbox.hanneseder.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758222AbZB0BHo@vger.kernel.org>
In-Reply-To: <20090222000441.17557.22989.stgit@vmbox.hanneseder.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: trivial@kernel.org, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

[Added To, Cc]

On Sun, Feb 22, 2009 at 1:04 AM, Hannes Eder <hannes@hanneseder.net> wr=
ote:
> Fix this sparse warning:
> =A0drivers/video/via/hw.c:2020:46: warning: Using plain integer as NU=
LL pointer
>
> Signed-off-by: Hannes Eder <hannes@hanneseder.net>
> ---
> =A0drivers/video/via/hw.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index fcd53ce..70d6b6c 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -2017,7 +2017,7 @@ static void init_gfx_chip_info(void)
> =A0 =A0 =A0 =A0/* Indentify GFX Chip Name */
> =A0 =A0 =A0 =A0for (i =3D 0; pciidlist[i].vendor !=3D 0; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev =3D pci_get_device(pciidlist[i].v=
endor,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pciidlist[i].device, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pciidlist[i].device, NU=
LL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
>
