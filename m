From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 16 Sep 2020 00:01:06 +0000
Subject: Re: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
Message-Id: <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <00000000000024be1505ad487cbb@google.com>
 <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
In-Reply-To: <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>, george.kennedy@oracle.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, syzkaller-bugs@googlegroups.com
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, natechancellor@gmail.com

Greg, will you pick up this patch?

It seems that finding the real cause of [3] and actually fixing [3] will be=
 difficult.
Since I can't reproduce [3] locally, I will have to try flood of "#syz test=
" requests
for debug printk() patches.

On 2020/09/11 7:57, Tetsuo Handa wrote:
> syzbot is reporting OOB read at fbcon_resize() [1], for
> commit 39b3cffb8cf31117 ("fbcon: prevent user font height or width change
>  from causing potential out-of-bounds access") is by error using
> registered_fb[con2fb_map[vc->vc_num]]->fbcon_par->p->userfont (which was
> set to non-zero) instead of fb_display[vc->vc_num].userfont (which remains
> zero for that display).
>=20
> We could remove tricky userfont flag [2], for we can determine it by
> comparing address of the font data and addresses of built-in font data.
> But since that commit is failing to fix the original OOB read [3], this
> patch keeps the change minimal in case we decide to revert altogether.
>=20
> [1] https://syzkaller.appspot.com/bug?id=EBcbbb6576958a496500fee9cf7aa83e=
a00b5920
> [2] https://syzkaller.appspot.com/text?tag=3DPatch&x=14030853900000
> [3] https://syzkaller.appspot.com/bug?idoba8c186d97cf1011ab17660e633b1cc4=
e080c9
>=20
> Reported-by: syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.co=
m>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 39b3cffb8cf31117 ("fbcon: prevent user font height or width change=
 from causing potential out-of-bounds access")
> Cc: George Kennedy <george.kennedy@oracle.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 66167830fefd..dae7ae7f225a 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2203,7 +2203,7 @@ static int fbcon_resize(struct vc_data *vc, unsigne=
d int width,
>  	struct fb_var_screeninfo var =3D info->var;
>  	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
> =20
> -	if (ops->p && ops->p->userfont && FNTSIZE(vc->vc_font.data)) {
> +	if (p->userfont && FNTSIZE(vc->vc_font.data)) {
>  		int size;
>  		int pitch =3D PITCH(vc->vc_font.width);
> =20
>=20
