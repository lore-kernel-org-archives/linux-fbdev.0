From: Yang Hongyang <yanghy@cn.fujitsu.com>
Subject: =?windows-1252?Q?Re=3A_=5BPATCH=5Datyfb=3Aremove__unused_?=
 =?windows-1252?Q?variable_=91pwr=5Fcommand=92?=
Date: Fri, 20 Feb 2009 10:29:03 +0800
Message-ID: <499E156F.7020101@cn.fujitsu.com>
References: <49953E90.8030306@cn.fujitsu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754248AbZBTC1y@vger.kernel.org>
In-Reply-To: <49953E90.8030306@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, rui.zhang@intel.com, brad@neruo.com, Andrew Morton <akpm@linux-foundation.org>

+CC:brad@neruo.com
+CC:Andrew Morton <akpm@linux-foundation.org>

Yang Hongyang wrote:
> remove  unused variable =91pwr_command=92=20
>=20
> Signed-off-by: Yang Hongyang<yanghy@cn.fujitsu.com>
>=20
> ---
>  drivers/video/aty/aty128fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128f=
b.c
> index e6e299f..2181ce4 100644
> --- a/drivers/video/aty/aty128fb.c
> +++ b/drivers/video/aty/aty128fb.c
> @@ -2365,7 +2365,6 @@ static void fbcon_aty128_bmove(struct display *=
p, int sy, int sx, int dy, int dx
>  static void aty128_set_suspend(struct aty128fb_par *par, int suspend=
)
>  {
>  	u32	pmgt;
> -	u16	pwr_command;
>  	struct pci_dev *pdev =3D par->pdev;
> =20
>  	if (!par->pm_reg)


--=20
Regards
Yang Hongyang
