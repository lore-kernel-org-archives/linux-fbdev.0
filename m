From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 15 Jul 2020 14:02:58 +0000
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
 <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
In-Reply-To: <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On 2020/07/15 20:17, Tetsuo Handa wrote:
> On 2020/07/15 18:48, Dan Carpenter wrote:
>>> @@ -216,7 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, s=
truct fb_info *info,
>>>  	region.color =3D color;
>>>  	region.rop =3D ROP_COPY;
>>> =20
>>> -	if (rw && !bottom_only) {
>>> +	if ((int) rw > 0 && !bottom_only) {
>>>  		region.dx =3D info->var.xoffset + rs;
>>                             ^^^^^^^^^^^^^^^^^^^^^^
>>
>> If you choose a very high positive "rw" then this addition can overflow.
>> info->var.xoffset comes from the user and I don't think it's checked...
>=20
> Well, I think it would be checked by "struct fb_ops"->check_var hook.
> For example, vmw_fb_check_var() has
>=20
> 	if ((var->xoffset + var->xres) > par->max_width ||
> 	    (var->yoffset + var->yres) > par->max_height) {
> 		DRM_ERROR("Requested geom can not fit in framebuffer\n");
> 		return -EINVAL;
> 	}
>=20
> check. Of course, there might be integer overflow in that check...
> Having sanity check at caller of "struct fb_ops"->check_var might be nice.
>=20

Well, while

        const int fd =3D open("/dev/fb0", O_ACCMODE);
        struct fb_var_screeninfo var =3D { };
        ioctl(fd, FBIOGET_VSCREENINFO, &var);
        var.xres =3D var.yres =3D 4;
        var.xoffset =3D 4294967292U;
        ioctl(fd, FBIOPUT_VSCREENINFO, &var);

bypassed

  (var->xoffset + var->xres) > par->max_width

check in vmw_fb_check_var(),

----------
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -216,6 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, struc=
t fb_info *info,
        region.color =3D color;
        region.rop =3D ROP_COPY;

+       printk(KERN_INFO "%s info->var.xoffset=3D%u rs=3D%u info->var.yoffs=
et=3D%u bs=3D%u\n", __func__, info->var.xoffset, rs, info->var.yoffset, bs);
        if ((int) rw > 0 && !bottom_only) {
                region.dx =3D info->var.xoffset + rs;
                region.dy =3D 0;
----------

says that info->var.xoffset does not come from the user.

----------
 bit_clear_margins info->var.xoffset=3D0 rs=1024 info->var.yoffset=3D0 bs=
=800
----------
