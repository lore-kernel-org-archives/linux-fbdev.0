From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Tue, 03 Mar 2020 13:59:40 +0000
Subject: Re: [PATCH] vgacon: Fix a UAF in vgacon_invert_region
Message-Id: <20200303135940.GS13686@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200303032036.40560-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20200303032036.40560-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc: akpm@osdl.org, pmladek@suse.com, wangkefeng.wang@huawei.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, sergey.senozhatsky@gmail.com

On Tue, Mar 03, 2020 at 11:20:36AM +0800, Zhang Xiaoxu wrote:
> When syzkaller tests, there is a UAF:
>   BUG: KASan: use after free in vgacon_invert_region+0x9d/0x110 at addr
>     ffff880000100000
>   Read of size 2 by task syz-executor.1/16489
>   page:ffffea0000004000 count:0 mapcount:-127 mapping:          (null)
>   index:0x0
>   page flags: 0xfffff00000000()
>   page dumped because: kasan: bad access detected
>   CPU: 1 PID: 16489 Comm: syz-executor.1 Not tainted
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
>   Call Trace:
>     [<ffffffffb119f309>] dump_stack+0x1e/0x20
>     [<ffffffffb04af957>] kasan_report+0x577/0x950
>     [<ffffffffb04ae652>] __asan_load2+0x62/0x80
>     [<ffffffffb090f26d>] vgacon_invert_region+0x9d/0x110
>     [<ffffffffb0a39d95>] invert_screen+0xe5/0x470
>     [<ffffffffb0a21dcb>] set_selection+0x44b/0x12f0
>     [<ffffffffb0a3bfae>] tioclinux+0xee/0x490
>     [<ffffffffb0a1d114>] vt_ioctl+0xff4/0x2670
>     [<ffffffffb0a0089a>] tty_ioctl+0x46a/0x1a10
>     [<ffffffffb052db3d>] do_vfs_ioctl+0x5bd/0xc40
>     [<ffffffffb052e2f2>] SyS_ioctl+0x132/0x170
>     [<ffffffffb11c9b1b>] system_call_fastpath+0x22/0x27
>     Memory state around the buggy address:
>      ffff8800000fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      00 00
>      ffff8800000fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00
>      00 00 00
>     >ffff880000100000: ff ff ff ff ff ff ff ff ff ff ff ff ff
>      ff ff ff
>=20
> It can be reproduce in the linux mainline by the program:
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <fcntl.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <sys/ioctl.h>
>   #include <linux/vt.h>
>=20
>   struct tiocl_selection {
>     unsigned short xs;      /* X start */
>     unsigned short ys;      /* Y start */
>     unsigned short xe;      /* X end */
>     unsigned short ye;      /* Y end */
>     unsigned short sel_mode; /* selection mode */
>   };
>=20
>   #define TIOCL_SETSEL    2
>   struct tiocl {
>     unsigned char type;
>     unsigned char pad;
>     struct tiocl_selection sel;
>   };
>=20
>   int main()
>   {
>     int fd =3D 0;
>     const char *dev =3D "/dev/char/4:1";
>=20
>     struct vt_consize v =3D {0};
>     struct tiocl tioc =3D {0};
>=20
>     fd =3D open(dev, O_RDWR, 0);
>=20
>     v.v_rows =3D 3346;
>     ioctl(fd, VT_RESIZEX, &v);
>=20
>     tioc.type =3D TIOCL_SETSEL;
>     ioctl(fd, TIOCLINUX, &tioc);
>=20
>     return 0;
>   }
>=20
> When resize the screen, update the 'vc->vc_size_row' to the new_row_size,
> but when 'set_origin' in 'vgacon_set_origin', vgacon use 'vga_vram_base'
> for 'vc_origin' and 'vc_visible_origin', not 'vc_screenbuf'. It maybe
> smaller than 'vc_screenbuf'. When TIOCLINUX, use the new_row_size to calc
> the offset, it maybe larger than the vga_vram_base in vgacon driver, then
> bad access.
>=20
> So, If the screen size larger than vga_vram, resize screen should be
> failed. This alse fix CVE-2020-8649
>=20
> Fixes: 0aec4867dca14 ("[PATCH] SVGATextMode fix")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  drivers/video/console/vgacon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index de7b8382aba9..9c216f707629 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -1316,7 +1316,10 @@ static int vgacon_font_get(struct vc_data *c, stru=
ct console_font *font)
>  static int vgacon_resize(struct vc_data *c, unsigned int width,
>  			 unsigned int height, unsigned int user)
>  {
> -	if (width % 2 || width > screen_info.orig_video_cols ||
> +	if (width % 2 || width * height > vga_vram_size)

That doesn't match how vc_screenbuf_size is computed elsewhere. Also
a lot of places seem to assume that the screenbuf can be larger than
vga_vram_size (eg. all the memcpy()s pick the smaller size of the
two).

And you're changing the behaviour of the code when
'width % 2 && user' is true.

> +		return -EINVAL;
> +
> +	if (width > screen_info.orig_video_cols ||
>  	    height > (screen_info.orig_video_lines * vga_default_font_height)/
>  	    c->vc_font.height)
>  		/* let svgatextmode tinker with video timings and
> --=20
> 2.17.2
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Ville Syrj=E4l=E4
Intel
