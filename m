From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 14 Jul 2020 07:22:28 +0000
Subject: Re: [PATCH] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
 <CGME20200714072231eucas1p17c53f0a661346ebfd316ebd5796ca346@eucas1p1.samsung.com>
In-Reply-To: <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>


[ Please Cc: fbdev Maintainer (happens to be me :) on fbdev patches, thanks=
. ]

Hi,

On 7/12/20 1:10 PM, Tetsuo Handa wrote:
> I found that
>=20
>   const int fd =3D open("/dev/fb0", O_ACCMODE);
>   struct fb_var_screeninfo var =3D { };
>   ioctl(fd, FBIOGET_VSCREENINFO, &var);
>   var.xres =3D var.yres =3D 1;
>   ioctl(fd, FBIOPUT_VSCREENINFO, &var);
>=20
> causes general protection fault in bitfill_aligned(), for vc_do_resize()
> updates vc->vc_{cols,rows} only when vc_do_resize() will return 0.
>=20
> [   20.102222] BUG: unable to handle page fault for address: ffffb80500d7=
b000
> [   20.102225] #PF: supervisor write access in kernel mode
> [   20.102226] #PF: error_code(0x0002) - not-present page
> [   20.102227] PGD 13a48c067 P4D 13a48c067 PUD 13a48d067 PMD 132525067 PT=
E 0
> [   20.102230] Oops: 0002 [#1] SMP
> [   20.102232] CPU: 3 PID: 2786 Comm: a.out Not tainted 5.8.0-rc4+ #749
> [   20.102233] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 02/27/2020
> [   20.102237] RIP: 0010:bitfill_aligned+0x87/0x120 [cfbfillrect]
> [   20.102277] Call Trace:
> [   20.102281]  cfb_fillrect+0x159/0x340 [cfbfillrect]
> [   20.102747]  vmw_fb_fillrect+0x12/0x30 [vmwgfx]
> [   20.102755]  bit_clear_margins+0x92/0xf0 [fb]
> [   20.102760]  fbcon_clear_margins+0x4c/0x50 [fb]
> [   20.102763]  fbcon_switch+0x321/0x570 [fb]
> [   20.102771]  redraw_screen+0xe0/0x250
> [   20.102775]  fbcon_modechanged+0x164/0x1b0 [fb]
> [   20.102779]  fbcon_update_vcs+0x15/0x20 [fb]
> [   20.102781]  fb_set_var+0x364/0x3c0 [fb]
> [   20.102817]  do_fb_ioctl+0x2ff/0x3f0 [fb]
> [   20.103139]  fb_ioctl+0x2e/0x40 [fb]
> [   20.103141]  ksys_ioctl+0x86/0xc0
> [   20.103146]  __x64_sys_ioctl+0x15/0x20
> [   20.103148]  do_syscall_64+0x54/0xa0
> [   20.103151]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> If vc_do_resize() fails (e.g. kzalloc() failure) when var.xres or var.yres
> is going to shrink, bit_clear_margins() hits integer underflow bug due to
> info->var.xres < (vc->vc_cols * cw) or info->var.yres < (vc->vc_rows * ch=
).
> Unexpectedly large rw or bh will try to overrun the __iomem region and
> causes general protection fault.
>=20
> This crash is easily reproducible by calling vc_do_resize(vc, 0, 0)
> which the reproducer above will do. Since fbcon_modechanged() is doing
>=20
>   cols =3D FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
>   rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>   cols /=3D vc->vc_font.width;
>   rows /=3D vc->vc_font.height;
>   vc_resize(vc, cols, rows);
>   (...snipped...)
>   update_screen(vc);
>=20
> , var.xres < vc->vc_font.width makes cols =3D 0 and var.yres < vc->vc_fon=
t.height
> makes rows =3D 0. But vc_do_resize() does not set vc->vc_cols =3D vc->vc_=
rows =3D 0
> due to
>=20
>   new_cols =3D (cols ? cols : vc->vc_cols);
>   new_rows =3D (lines ? lines : vc->vc_rows);
>=20
> exception.
>=20
> Of course, the root problem is that callers of do_vc_resize() are not
> handling vc_do_resize() failures, but it might not be easy to handle
> them under complicated dependency. Therefore, as a band-aid workaround,
> this patch checks integer underflow in "struct fbcon_ops"->clear_margins
> call, assuming that vc->vc_cols * vc->vc_font.width and
> vc->vc_rows * vc->vc_font.heigh do not cause integer overflow.
>=20
> I hope that we can survive even if info->var.{xres,yres} were increased
> but vc->vc_{cols,rows} were not increased due to kzalloc() failure, for
> the __iomem memory for cfb_fillrect() seems to be allocated upon driver
> load.
>=20
> By the way, syzbot has several reports which are stalling inside filling
> functions. Although reproducer for [1] is not found yet, it has tried
>=20
>   r0 =3D openat$fb0(0xffffffffffffff9c, &(0x7f0000000180)=3D'/dev/fb0\x00=
', 0x0, 0x0)
>   ioctl$FBIOPUT_VSCREENINFO(r0, 0x4601, &(0x7f0000000000)=3D{0x0, 0x0, 0x=
0, 0x500, 0x0, 0x0, 0x4})
>=20
> which corresponds to
>=20
>   const int fd =3D open("/dev/fb0", O_ACCMODE);
>   struct fb_var_screeninfo var =3D { };
>   var.yres_virtual =3D 0x500;
>   var.bits_per_pixel =3D 4;
>   ioctl(fd, FBIOPUT_VSCREENINFO, &var);
>=20
> and somehow hit unexpectedly long bit_clear_margins() loops. I don't know
> why syzbot does not hit general protection fault, but it would depend on
> environment because in my VMware environment ioctl(FBIOPUT_VSCREENINFO)
> returns -EINVAL if var.xres =3D var.yres =3D 0.
>=20
> [1] https://syzkaller.appspot.com/bug?id=91ecc3bf32ab1a551c33a39dab7fc0c8=
cd7b7e16
>=20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

How does this patch relate to:

	https://marc.info/?l=3Dlinux-fbdev&m=159415024816722&w=3D2

?

It seems to address the same issue, I've added George and Dan to Cc:.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/core/bitblit.c   | 4 ++--
>  drivers/video/fbdev/core/fbcon_ccw.c | 4 ++--
>  drivers/video/fbdev/core/fbcon_cw.c  | 4 ++--
>  drivers/video/fbdev/core/fbcon_ud.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/cor=
e/bitblit.c
> index ca935c09a261..35ebeeccde4d 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -216,7 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, str=
uct fb_info *info,
>  	region.color =3D color;
>  	region.rop =3D ROP_COPY;
> =20
> -	if (rw && !bottom_only) {
> +	if ((int) rw > 0 && !bottom_only) {
>  		region.dx =3D info->var.xoffset + rs;
>  		region.dy =3D 0;
>  		region.width =3D rw;
> @@ -224,7 +224,7 @@ static void bit_clear_margins(struct vc_data *vc, str=
uct fb_info *info,
>  		info->fbops->fb_fillrect(info, &region);
>  	}
> =20
> -	if (bh) {
> +	if ((int) bh > 0) {
>  		region.dx =3D info->var.xoffset;
>  		region.dy =3D info->var.yoffset + bs;
>  		region.width =3D rs;
> diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/c=
ore/fbcon_ccw.c
> index dfa9a8aa4509..78f3a5621478 100644
> --- a/drivers/video/fbdev/core/fbcon_ccw.c
> +++ b/drivers/video/fbdev/core/fbcon_ccw.c
> @@ -201,7 +201,7 @@ static void ccw_clear_margins(struct vc_data *vc, str=
uct fb_info *info,
>  	region.color =3D color;
>  	region.rop =3D ROP_COPY;
> =20
> -	if (rw && !bottom_only) {
> +	if ((int) rw > 0 && !bottom_only) {
>  		region.dx =3D 0;
>  		region.dy =3D info->var.yoffset;
>  		region.height =3D rw;
> @@ -209,7 +209,7 @@ static void ccw_clear_margins(struct vc_data *vc, str=
uct fb_info *info,
>  		info->fbops->fb_fillrect(info, &region);
>  	}
> =20
> -	if (bh) {
> +	if ((int) bh > 0) {
>  		region.dx =3D info->var.xoffset + bs;
>  		region.dy =3D 0;
>                  region.height =3D info->var.yres_virtual;
> diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/co=
re/fbcon_cw.c
> index ce08251bfd38..fd098ff17574 100644
> --- a/drivers/video/fbdev/core/fbcon_cw.c
> +++ b/drivers/video/fbdev/core/fbcon_cw.c
> @@ -184,7 +184,7 @@ static void cw_clear_margins(struct vc_data *vc, stru=
ct fb_info *info,
>  	region.color =3D color;
>  	region.rop =3D ROP_COPY;
> =20
> -	if (rw && !bottom_only) {
> +	if ((int) rw > 0 && !bottom_only) {
>  		region.dx =3D 0;
>  		region.dy =3D info->var.yoffset + rs;
>  		region.height =3D rw;
> @@ -192,7 +192,7 @@ static void cw_clear_margins(struct vc_data *vc, stru=
ct fb_info *info,
>  		info->fbops->fb_fillrect(info, &region);
>  	}
> =20
> -	if (bh) {
> +	if ((int) bh > 0) {
>  		region.dx =3D info->var.xoffset;
>  		region.dy =3D info->var.yoffset;
>                  region.height =3D info->var.yres;
> diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/co=
re/fbcon_ud.c
> index 1936afc78fec..e165a3fad29a 100644
> --- a/drivers/video/fbdev/core/fbcon_ud.c
> +++ b/drivers/video/fbdev/core/fbcon_ud.c
> @@ -231,7 +231,7 @@ static void ud_clear_margins(struct vc_data *vc, stru=
ct fb_info *info,
>  	region.color =3D color;
>  	region.rop =3D ROP_COPY;
> =20
> -	if (rw && !bottom_only) {
> +	if ((int) rw > 0 && !bottom_only) {
>  		region.dy =3D 0;
>  		region.dx =3D info->var.xoffset;
>  		region.width  =3D rw;
> @@ -239,7 +239,7 @@ static void ud_clear_margins(struct vc_data *vc, stru=
ct fb_info *info,
>  		info->fbops->fb_fillrect(info, &region);
>  	}
> =20
> -	if (bh) {
> +	if ((int) bh > 0) {
>  		region.dy =3D info->var.yoffset;
>  		region.dx =3D info->var.xoffset;
>                  region.height  =3D bh;
>=20
