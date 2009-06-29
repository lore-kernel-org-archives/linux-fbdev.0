From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: 
	[linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Mon, 29 Jun 2009 13:39:37 +0300
Message-ID: <20090629103936.GJ9980@sci.fi>
References: <4A4839CB.8020801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MLEH4-0000T2-2s
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 10:39:46 +0000
Received: from smtp4.welho.com ([213.243.153.38])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLEH2-0006cE-0E for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 10:39:46 +0000
Content-Disposition: inline
In-Reply-To: <4A4839CB.8020801@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kai Jiang <b18973@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Jun 29, 2009 at 11:49:31AM +0800, Kai Jiang wrote:
>

> >From a01ede69772634b30a83b44eada5a8db66f8463a Mon Sep 17 00:00:00 2001
> From: Kai Jiang <Kai.Jiang@freescale.com>
> Date: Mon, 29 Jun 2009 11:25:58 +0800
> Subject: [PATCH] When moving virtual space straight to one side in the sc=
reen(ex.
>  straight to the left),finally the virtual space will move outside
>  of the real screen. Then the xoffset or yoffset will be nagative
>  value(transfered from user application) to indicate that the virtual
>  space is beyond the screen boundary. In the function fb_pan_disaplay,
>  xoffset and yoffset should be checked to ensure that, when they are
>  negative, the virtual space will not move any more,and the function
>  will return an error. However, xoffset and yoffset in the structure
>  fb_var_screeninfo are "__u32" type, here need to transfer them to
>  "int" type for comparing.
> =

> Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
> ---
>  drivers/video/fbmem.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index d412a1d..27628de 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -855,6 +855,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_sc=
reeninfo *var)
>  {
>  	struct fb_fix_screeninfo *fix =3D &info->fix;
>  	unsigned int yres =3D info->var.yres;
> +	int xoffset =3D var->xoffset;
> +	int yoffset =3D var->yoffset;
>  	int err =3D 0;
>  =

>  	if (var->yoffset > 0) {
> @@ -873,7 +875,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_sc=
reeninfo *var)
>  =

>  	if (err || !info->fbops->fb_pan_display ||
>  	    var->yoffset + yres > info->var.yres_virtual ||
> -	    var->xoffset + info->var.xres > info->var.xres_virtual)
> +	    var->xoffset + info->var.xres > info->var.xres_virtual ||
> +	    xoffset < 0 || yoffset < 0)

Well negative xoffset/yoffset don't really exist so what you're
essentially checking is whether offset+res overflows. Your check will
not catch all overflows though. xres/yres would have to be huge
(> 2^31) to cause such overflows though so your check should catch all
cases that can happen in practice. However I think it would be better
to make the overflow check clearer (eg. 'offset + res < res').

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
