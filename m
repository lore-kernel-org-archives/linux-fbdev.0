From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC] double buffering for atmel_lcdfb
Date: Wed, 6 Aug 2008 15:53:03 +0200
Message-ID: <200808061553.03706.stf_xl@wp.pl>
References: <200808061136.16783.stf_xl@wp.pl>
	<20080806141305.49e883a2@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1816464361=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQjS2-0004HZ-Bx for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 06:53:18 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQjS1-00073U-Gv
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 06:53:18 -0700
In-Reply-To: <20080806141305.49e883a2@hskinnemo-gx745.norway.atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============1816464361==
Content-Type: multipart/alternative; boundary="Boundary-01=_/yamIhQEB0tODqx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_/yamIhQEB0tODqx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Wednesday 06 August 2008 14:13:05 Haavard Skinnemoen napisa=C5=82(a):
> Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> > Below is patch I have already done. I also attached program which I used
> > for for tests - as far result are quite nice.
>
> I sent this patch a while ago, but I forgot to send Nicolas a test
> program when he asked for it :-(
>
> Could you give it a try? If it works for you, I think we can conclude
> that y-panning indeed works on AT91 so the patch can be applied.
Yes, it works with my program with ypanstep =3D=3D yres (I did not check wi=
th ypanstep =3D=3D 1 yet),=20

> Haavard
>
> From c1dc155e3c1a828faa4379a1f6f6de0bb58385cc Mon Sep 17 00:00:00 2001
> From: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Date: Sat, 23 Jun 2007 17:38:26 +0200
> Subject: [PATCH] atmel_lcdfb: Set ypanstep to 1 and enable y-panning on
> AT91
>
> Panning in the y-direction can be done by simply changing the DMA base
> address. This code is already in place, but FBIOPAN_DISPLAY will
> currently fail because ypanstep is 0.
>
> Set ypanstep to 1 to indicate that we do support y-panning and also
> set the necessary acceleration flags on AT91 (AVR32 already have
> them.)
>
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> ---
>  drivers/video/atmel_lcdfb.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index b004036..c0a0364 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -39,7 +39,9 @@
>  #endif
>
>  #if defined(CONFIG_ARCH_AT91)
> -#define	ATMEL_LCDFB_FBINFO_DEFAULT	FBINFO_DEFAULT
> +#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
> +					 | FBINFO_PARTIAL_PAN_OK \
> +					 | FBINFO_HWACCEL_YPAN)
>
>  static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info
> *sinfo, struct fb_var_screeninfo *var)
> @@ -177,7 +179,7 @@ static struct fb_fix_screeninfo atmel_lcdfb_fix
> __initdata =3D { .type		=3D FB_TYPE_PACKED_PIXELS,
>  	.visual		=3D FB_VISUAL_TRUECOLOR,
>  	.xpanstep	=3D 0,
> -	.ypanstep	=3D 0,
> +	.ypanstep	=3D 1,
>  	.ywrapstep	=3D 0,
>  	.accel		=3D FB_ACCEL_NONE,
>  };

I think some video memory allocation control is also needed for users which=
=20
want to have frame buffer in main memory (this is a must with bigger LCDs)
Currently I just increase smem_len just before dma_alloc_writecombine() is =
called. =20

@@ -241,7 +243,7 @@ static int atmel_lcdfb_alloc_video_memory(struct atmel_=
lcdfb_info *sinfo)
        struct fb_info *info =3D sinfo->info;
        struct fb_var_screeninfo *var =3D &info->var;

=2D       info->fix.smem_len =3D (var->xres_virtual * var->yres_virtual
+       info->fix.smem_len =3D (var->xres_virtual * var->yres_virtual * 2
                            * ((var->bits_per_pixel + 7) / 8));

        info->screen_base =3D dma_alloc_writecombine(info->device,=20

Ok I know that I could just add memory resource to at91_lcdc_device, but
main RAM memory is managed by linux and need to be somehow allocated.
So maybe worth to add smem_len hint in at91_lcdc_device like this:

=2D-- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -240,9 +242,11 @@ static int atmel_lcdfb_alloc_video_memory(struct atmel=
_lcdfb_info *sinfo)
 {
        struct fb_info *info =3D sinfo->info;
        struct fb_var_screeninfo *var =3D &info->var;
=2D
=2D       info->fix.smem_len =3D (var->xres_virtual * var->yres_virtual
+       unsigned int smem_len;
+
+       smem_len =3D (var->xres_virtual * var->yres_virtual
                            * ((var->bits_per_pixel + 7) / 8));
+       info->fix.smem_len =3D max(smem_len, sinfo->smem_len);

        info->screen_base =3D dma_alloc_writecombine(info->device, info->fi=
x.smem_len,
                                        (dma_addr_t *)&info->fix.smem_start=
, GFP_KERNEL);
diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index ed64862..7f3ff79 100644
=2D-- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -37,6 +37,7 @@ struct atmel_lcdfb_info {
        struct fb_info          *info;
        void __iomem            *mmio;
        unsigned long           irq_base;
+       unsigned int            smem_len;

        unsigned int            guard_time;
        struct platform_device  *pdev;


Regards
Stanislaw Gruszka
--Boundary-01=_/yamIhQEB0tODqx
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta name=3D"qrichtext" content=3D"1" /></head><body style=3D"=
font-size:9pt;font-family:Sans Serif">
<p>Wednesday 06 August 2008 14:13:05 Haavard Skinnemoen napisa=C5=82(a):</p>
<p>&gt; Stanislaw Gruszka &lt;stf_xl@wp.pl&gt; wrote:</p>
<p>&gt; &gt; Below is patch I have already done. I also attached program wh=
ich I used</p>
<p>&gt; &gt; for for tests - as far result are quite nice.</p>
<p>&gt;</p>
<p>&gt; I sent this patch a while ago, but I forgot to send Nicolas a test<=
/p>
<p>&gt; program when he asked for it :-(</p>
<p>&gt;</p>
<p>&gt; Could you give it a try? If it works for you, I think we can conclu=
de</p>
<p>&gt; that y-panning indeed works on AT91 so the patch can be applied.</p>
<p>Yes, it works with my program with ypanstep =3D=3D yres (I did not check=
 with ypanstep =3D=3D 1 yet), </p>
<p></p>
<p>&gt; Haavard</p>
<p>&gt;</p>
<p>&gt; From c1dc155e3c1a828faa4379a1f6f6de0bb58385cc Mon Sep 17 00:00:00 2=
001</p>
<p>&gt; From: Haavard Skinnemoen &lt;hskinnemoen@atmel.com&gt;</p>
<p>&gt; Date: Sat, 23 Jun 2007 17:38:26 +0200</p>
<p>&gt; Subject: [PATCH] atmel_lcdfb: Set ypanstep to 1 and enable y-pannin=
g on</p>
<p>&gt; AT91</p>
<p>&gt;</p>
<p>&gt; Panning in the y-direction can be done by simply changing the DMA b=
ase</p>
<p>&gt; address. This code is already in place, but FBIOPAN_DISPLAY will</p>
<p>&gt; currently fail because ypanstep is 0.</p>
<p>&gt;</p>
<p>&gt; Set ypanstep to 1 to indicate that we do support y-panning and also=
</p>
<p>&gt; set the necessary acceleration flags on AT91 (AVR32 already have</p>
<p>&gt; them.)</p>
<p>&gt;</p>
<p>&gt; Signed-off-by: Haavard Skinnemoen &lt;hskinnemoen@atmel.com&gt;</p>
<p>&gt; ---</p>
<p>&gt;  drivers/video/atmel_lcdfb.c |    6 ++++--</p>
<p>&gt;  1 files changed, 4 insertions(+), 2 deletions(-)</p>
<p>&gt;</p>
<p>&gt; diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdf=
b.c</p>
<p>&gt; index b004036..c0a0364 100644</p>
<p>&gt; --- a/drivers/video/atmel_lcdfb.c</p>
<p>&gt; +++ b/drivers/video/atmel_lcdfb.c</p>
<p>&gt; @@ -39,7 +39,9 @@</p>
<p>&gt;  #endif</p>
<p>&gt;</p>
<p>&gt;  #if defined(CONFIG_ARCH_AT91)</p>
<p>&gt; -#define	ATMEL_LCDFB_FBINFO_DEFAULT	FBINFO_DEFAULT</p>
<p>&gt; +#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \</p>
<p>&gt; +					 | FBINFO_PARTIAL_PAN_OK \</p>
<p>&gt; +					 | FBINFO_HWACCEL_YPAN)</p>
<p>&gt;</p>
<p>&gt;  static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_inf=
o</p>
<p>&gt; *sinfo, struct fb_var_screeninfo *var)</p>
<p>&gt; @@ -177,7 +179,7 @@ static struct fb_fix_screeninfo atmel_lcdfb_fix=
</p>
<p>&gt; __initdata =3D { .type		=3D FB_TYPE_PACKED_PIXELS,</p>
<p>&gt;  	.visual		=3D FB_VISUAL_TRUECOLOR,</p>
<p>&gt;  	.xpanstep	=3D 0,</p>
<p>&gt; -	.ypanstep	=3D 0,</p>
<p>&gt; +	.ypanstep	=3D 1,</p>
<p>&gt;  	.ywrapstep	=3D 0,</p>
<p>&gt;  	.accel		=3D FB_ACCEL_NONE,</p>
<p>&gt;  };</p>
<p></p>
<p>I think some video memory allocation control is also needed for users wh=
ich </p>
<p>want to have frame buffer in main memory (this is a must with bigger LCD=
s)</p>
<p>Currently I just increase smem_len just before dma_alloc_writecombine() =
is called.  </p>
<p></p>
<p>@@ -241,7 +243,7 @@ static int atmel_lcdfb_alloc_video_memory(struct atm=
el_lcdfb_info *sinfo)</p>
<p>        struct fb_info *info =3D sinfo-&gt;info;</p>
<p>        struct fb_var_screeninfo *var =3D &amp;info-&gt;var;</p>
<p></p>
<p>-       info-&gt;fix.smem_len =3D (var-&gt;xres_virtual * var-&gt;yres_v=
irtual</p>
<p>+       info-&gt;fix.smem_len =3D (var-&gt;xres_virtual * var-&gt;yres_v=
irtual * 2</p>
<p>                            * ((var-&gt;bits_per_pixel + 7) / 8));</p>
<p></p>
<p>        info-&gt;screen_base =3D dma_alloc_writecombine(info-&gt;device,=
 </p>
<p></p>
<p>Ok I know that I could just add memory resource to at91_lcdc_device, but=
</p>
<p>main RAM memory is managed by linux and need to be somehow allocated.</p>
<p>So maybe worth to add smem_len hint in at91_lcdc_device like this:</p>
<p></p>
<p>--- a/drivers/video/atmel_lcdfb.c</p>
<p>+++ b/drivers/video/atmel_lcdfb.c</p>
<p>@@ -240,9 +242,11 @@ static int atmel_lcdfb_alloc_video_memory(struct at=
mel_lcdfb_info *sinfo)</p>
<p> {</p>
<p>        struct fb_info *info =3D sinfo-&gt;info;</p>
<p>        struct fb_var_screeninfo *var =3D &amp;info-&gt;var;</p>
<p>-</p>
<p>-       info-&gt;fix.smem_len =3D (var-&gt;xres_virtual * var-&gt;yres_v=
irtual</p>
<p>+       unsigned int smem_len;</p>
<p>+</p>
<p>+       smem_len =3D (var-&gt;xres_virtual * var-&gt;yres_virtual</p>
<p>                            * ((var-&gt;bits_per_pixel + 7) / 8));</p>
<p>+       info-&gt;fix.smem_len =3D max(smem_len, sinfo-&gt;smem_len);</p>
<p></p>
<p>        info-&gt;screen_base =3D dma_alloc_writecombine(info-&gt;device,=
 info-&gt;fix.smem_len,</p>
<p>                                        (dma_addr_t *)&amp;info-&gt;fix.=
smem_start, GFP_KERNEL);</p>
<p>diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h</p>
<p>index ed64862..7f3ff79 100644</p>
<p>--- a/include/video/atmel_lcdc.h</p>
<p>+++ b/include/video/atmel_lcdc.h</p>
<p>@@ -37,6 +37,7 @@ struct atmel_lcdfb_info {</p>
<p>        struct fb_info          *info;</p>
<p>        void __iomem            *mmio;</p>
<p>        unsigned long           irq_base;</p>
<p>+       unsigned int            smem_len;</p>
<p></p>
<p>        unsigned int            guard_time;</p>
<p>        struct platform_device  *pdev;</p>
<p></p>
<p></p>
<p>Regards</p>
<p>Stanislaw Gruszka</p>
</body></html>
--Boundary-01=_/yamIhQEB0tODqx--


--===============1816464361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1816464361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1816464361==--
