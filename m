From: Ajay kumar <ajaynumb@gmail.com>
Date: Fri, 26 Aug 2011 05:33:50 +0000
Subject: Re: [PATCH 2/2] video: s3c-fb: Modify s3c-fb driver to support window positioning
Message-Id: <CAEC9eQMuqEO1uRnQOjZBFAxtH0qRnKu+Jvjo_xo2P5TJK=UpYg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <14401983.184721314319448396.JavaMail.weblogic@epv6ml01>
In-Reply-To: <14401983.184721314319448396.JavaMail.weblogic@epv6ml01>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Jingoo,

2011/8/26 JinGoo Han <jg1.han@samsung.com>:
> Hi, Ajay.
>> -----Original Message-----
>> From: Ajay Kumar [mailto:ajaykumar.rs@samsung.com]
>> Sent: Friday, August 26, 2011 4:52 AM
>> To: linux-samsung-soc@vger.kernel.org; linux-fbdev@vger.kernel.org; linu=
x-
>> arm-kernel@lists.infradead.org
>> Cc: FlorianSchandinat@gmx.de; lethal@linux-sh.org; jg1.han@samsung.com;
>> m.szyprowski@samsung.com; ben-linux@fluff.org; banajit.g@samsung.com
>> Subject: [PATCH 2/2] video: s3c-fb: Modify s3c-fb driver to support wind=
ow
>> positioning
>>
>> This patch modifies the existing s3c-fb driver to provide
>> flexibility to the user to reposition the framebuffer windows.
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
>> ---
>> =A0drivers/video/s3c-fb.c | =A0 37 ++++++++++++++++++++++++++++++++-----
>> =A01 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
>> index 0fda252..41179d7 100644
>> --- a/drivers/video/s3c-fb.c
>> +++ b/drivers/video/s3c-fb.c
>> @@ -442,6 +442,7 @@ static int s3c_fb_set_par(struct fb_info *info)
>> =A0 =A0 =A0 struct fb_var_screeninfo *var =3D &info->var;
>> =A0 =A0 =A0 struct s3c_fb_win *win =3D info->par;
>> =A0 =A0 =A0 struct s3c_fb *sfb =3D win->parent;
>> + =A0 =A0 struct s3cfb_window_pos *winpos =3D &win->windata->winpos;
>> =A0 =A0 =A0 void __iomem *regs =3D sfb->regs;
>> =A0 =A0 =A0 void __iomem *buf =3D regs;
>> =A0 =A0 =A0 int win_no =3D win->index;
>> @@ -539,12 +540,13 @@ static int s3c_fb_set_par(struct fb_info *info)
>>
>> =A0 =A0 =A0 /* write 'OSD' registers to control position of framebuffer =
*/
>>
>> - =A0 =A0 data =3D VIDOSDxA_TOPLEFT_X(0) | VIDOSDxA_TOPLEFT_Y(0);
>> + =A0 =A0 data =3D VIDOSDxA_TOPLEFT_X(winpos->win_pos_x) |
>> + =A0 =A0 =A0 =A0 =A0 =A0VIDOSDxA_TOPLEFT_Y(winpos->win_pos_y);
>> =A0 =A0 =A0 writel(data, regs + VIDOSD_A(win_no, sfb->variant));
>>
>> - =A0 =A0 data =3D VIDOSDxB_BOTRIGHT_X(s3c_fb_align_word(var->bits_per_p=
ixel,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0var->xres - 1)) |
>> - =A0 =A0 =A0 =A0 =A0 =A0VIDOSDxB_BOTRIGHT_Y(var->yres - 1);
>> + =A0 =A0 data =3D VIDOSDxB_BOTRIGHT_X((s3c_fb_align_word(var->bits_per_=
pixel,
>> + =A0 =A0 =A0 =A0 =A0 =A0(winpos->win_pos_x + var->xres - 1)))) |
>> + =A0 =A0 =A0 =A0 =A0 =A0VIDOSDxB_BOTRIGHT_Y((winpos->win_pos_y + var->y=
res - 1));
>>
>> =A0 =A0 =A0 writel(data, regs + VIDOSD_B(win_no, sfb->variant));
>>
>> @@ -999,8 +1001,10 @@ static int s3c_fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>> =A0{
>> =A0 =A0 =A0 struct s3c_fb_win *win =3D info->par;
>> =A0 =A0 =A0 struct s3c_fb *sfb =3D win->parent;
>> - =A0 =A0 int ret;
>> + =A0 =A0 struct s3cfb_window_pos *winpos =3D &win->windata->winpos;
>> + =A0 =A0 int ret =3D 0;
>> =A0 =A0 =A0 u32 crtc;
>> + =A0 =A0 u32 data;
>>
>> =A0 =A0 =A0 switch (cmd) {
>> =A0 =A0 =A0 case FBIO_WAITFORVSYNC:
>> @@ -1011,6 +1015,29 @@ static int s3c_fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D s3c_fb_wait_for_vsync(sfb, crtc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case S3CFB_WIN_POSITION:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(winpos, (u32 __user *)arg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sizeof(struct s3cfb_window_pos))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 shadow_protect_win(win, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* write 'OSD' registers to set position of th=
e window */
>> + =A0 =A0 =A0 =A0 =A0 =A0 data =3D VIDOSDxA_TOPLEFT_X(winpos->win_pos_x)=
 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0VIDOSDxA_TOPLEFT_Y(winpos->win_=
pos_y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(data, sfb->regs + VIDOSD_A(win->index, =
sfb->variant));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 data =3D VIDOSDxB_BOTRIGHT_X(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_fb_align_w=
ord(info->var.bits_per_pixel,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (winpos->win_p=
os_x + info->var.xres - 1)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 data |=3D VIDOSDxB_BOTRIGHT_Y(winpos->win_pos_=
y +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->var.yres=
 - 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(data, sfb->regs + VIDOSD_B(win->index, =
sfb->variant));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 shadow_protect_win(win, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> Can you move this to separate function?
> In my opinion, it would be better for readability and consistency.
> Also, FBIO_WAITFORVSYNC has been implemented in this way.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D s3c_fb_wait_for_vsync(sfb, crtc);
> How about adding a function 's3c_fb_set_window_position' for this as belo=
ws?
> +int s3c_fb_set_window_position(struct fb_info *info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct s3cf=
b_window_pos winpos)

Thanks for your suggestion.
I have considered it, and now I have written a separate function for this.
I will be sending it in V2 version.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0........
> + =A0 =A0 =A0 case S3CFB_WIN_POSITION:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(winpos, (u32 __user *)ar=
g,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sizeof(struct s3cfb_window_pos))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D s3c_fb_set_window_position(info, wi=
npos);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOTTY;
>> =A0 =A0 =A0 }
>> --
>> 1.7.0.4
>
>
>
