From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 15 Jul 2020 09:48:36 +0000
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <20200715094836.GD2571@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On Wed, Jul 15, 2020 at 10:51:02AM +0900, Tetsuo Handa wrote:
> syzbot is reporting general protection fault in bitfill_aligned() [1]
> caused by integer underflow in bit_clear_margins(). The cause of this
> problem is when and how do_vc_resize() updates vc->vc_{cols,rows}.
>=20
> If vc_do_resize() fails (e.g. kzalloc() fails) when var.xres or var.yres
> is going to shrink, vc->vc_{cols,rows} will not be updated. This allows
> bit_clear_margins() to see info->var.xres < (vc->vc_cols * cw) or
> info->var.yres < (vc->vc_rows * ch). Unexpectedly large rw or bh will
> try to overrun the __iomem region and causes general protection fault.
>=20
> Also, vc_resize(vc, 0, 0) does not set vc->vc_{cols,rows} =3D 0 due to
>=20
>   new_cols =3D (cols ? cols : vc->vc_cols);
>   new_rows =3D (lines ? lines : vc->vc_rows);
>=20
> exception. Since cols and lines are calculated as
>=20
>   cols =3D FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
>   rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>   cols /=3D vc->vc_font.width;
>   rows /=3D vc->vc_font.height;
>   vc_resize(vc, cols, rows);
>=20
> in fbcon_modechanged(), var.xres < vc->vc_font.width makes cols =3D 0
> and var.yres < vc->vc_font.height makes rows =3D 0. This means that
>=20
>   const int fd =3D open("/dev/fb0", O_ACCMODE);
>   struct fb_var_screeninfo var =3D { };
>   ioctl(fd, FBIOGET_VSCREENINFO, &var);
>   var.xres =3D var.yres =3D 1;
>   ioctl(fd, FBIOPUT_VSCREENINFO, &var);
>=20
> easily reproduces integer underflow bug explained above.
>=20
> Of course, callers of vc_resize() are not handling vc_do_resize() failure
> is bad. But we can't avoid vc_resize(vc, 0, 0) which returns 0. Therefore,
> as a band-aid workaround, this patch checks integer underflow in
> "struct fbcon_ops"->clear_margins call, assuming that
> vc->vc_cols * vc->vc_font.width and vc->vc_rows * vc->vc_font.heigh do not
> cause integer overflow.
>=20
> [1] https://syzkaller.appspot.com/bug?id=A565882df74fa76f10d3a6fec4be3109=
8dbb37c6
>=20
> Reported-and-tested-by: syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.app=
spotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
                            ^^^^^^^^^^^^^^^^^^^^^^

If you choose a very high positive "rw" then this addition can overflow.
info->var.xoffset comes from the user and I don't think it's checked...

regards,
dan carpenter
