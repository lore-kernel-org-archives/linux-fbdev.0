From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] fbcmap: non working tests on unsigned 
	cmap->start
Date: Mon, 27 Apr 2009 14:21:47 +0200
Message-ID: <10f740e80904270521n48b687c5y5b7e2e7bddbad027@mail.gmail.com>
References: <49EDD799.8060607@gmail.com>
	 <20090423134110.51ea8df2.akpm@linux-foundation.org>
	 <20090423214738.GF7134@sci.fi> <49F4519F.4090003@gmail.com>
	 <20090426131505.GG7134@sci.fi> <49F59DD9.6010903@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754579AbZD0MWB@vger.kernel.org>
In-Reply-To: <49F59DD9.6010903@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Mon, Apr 27, 2009 at 13:58, Roel Kluin <roel.kluin@gmail.com> wrote:
> Ville Syrj=C3=A4l=C3=A4 wrote:
>> On Sun, Apr 26, 2009 at 02:20:47PM +0200, Roel Kluin wrote:
>>> cmap->start is unsigned,
>
>>>> On Thu, Apr 23, 2009 at 01:41:10PM -0700, Andrew Morton wrote:
>>>>> argh.
>>>>>
>>>>> - Perhaps userspace can kill the kernel by sending a "negative"
>>>>> =C2=A0 `start'. =C2=A0Removing the test will make it even less li=
kely that we'll
>>>>> =C2=A0 fix this bug.
>>>> Shouldn't happen. 'start' is used as the starting index for the ha=
rdware
>>>> palette, 'start+len-1' is the last index. All drivers should alrea=
dy check
>>>> the passed values since the maximum index depends on the display m=
ode.
>>>> And I suppose the worst thing that could happen if the driver fail=
s to
>>>> check the values would be incorrect colors.
>
>> You would rather need something like
>> 'if (start+len > 1 << max(red.len, green.len, blue.len, transp.len))=
'
>
> what do you mean with `red.len'? is that `info->var.red.length'?

That's correct.

>> and a check to make sure that start+len doesn't overflow.
>>
>> Oh and I guess it should also check that the visual is pseudocolor o=
r
>> directcolor.
>
> I am fairly new so please review carefully.
>
> Not yet signed off-by: Roel Kluin <roel.kluin@gmail.com>

Looks OK, thx!

> ---
> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> index f53b9f1..b34e74e 100644
> --- a/drivers/video/fbcmap.c
> +++ b/drivers/video/fbcmap.c
> @@ -249,6 +249,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, s=
truct fb_info *info)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc, size =3D cmap->len * sizeof(u16);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct fb_cmap umap;
> + =C2=A0 =C2=A0 =C2=A0 __u32 rgba_max =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&umap, 0, sizeof(struct fb_cmap));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D fb_alloc_cmap(&umap, cmap->len, cma=
p->transp !=3D NULL);
> @@ -261,13 +262,27 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap,=
 struct fb_info *info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -EFAULT=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cmap->start + cmap->len < cmap->start) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0umap.start =3D cmap->start;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!lock_fb_info(info)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -ENODEV=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 if (cmap->start < 0 || (!info->fbops->fb_setco=
lreg &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !info->fbops->fb_setcmap)) {
> +
> + =C2=A0 =C2=A0 =C2=A0 rgba_max =3D max(info->var.red.length, info->v=
ar.green.length);
> + =C2=A0 =C2=A0 =C2=A0 rgba_max =3D max(rgba_max, info->var.blue.leng=
th);
> + =C2=A0 =C2=A0 =C2=A0 rgba_max =3D max(rgba_max, info->var.transp.le=
ngth);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cmap->start + cmap->len > 1 << rgba_max ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 !(info->fbops->fb_setcolreg ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info->fbops->fb_setcmap) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 !(info->fix.visual =3D=3D FB_VISUAL_PSEUDOCOLOR ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info->fix.visual =3D=3D FB_VISUAL_T=
RUECOLOR)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -EINVAL=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> ---------------------------------------------------------------------=
---------
> Crystal Reports &#45; New Free Runtime and 30 Day Trial
> Check out the new simplified licensign option that enables unlimited
> royalty&#45;free distribution of the report engine for externally fac=
ing
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>



--=20
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
