From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Sat, 26 Sep 2020 19:39:57 +0000
Subject: Re: KASAN: use-after-free Read in bit_putcs
Message-Id: <20200926193957.GA1033221@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
In-Reply-To: <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, deller@gmx.de, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, yepeilin.cs@gmail.com

On Sun, Sep 27, 2020 at 01:25:17AM +0900, Tetsuo Handa wrote:
> A simplified reproducer and debug printk() patch shown below reported that
> vc_font.height is increased to 9 via ioctl(VT_RESIZEX) after it was once
> decreased from 16 to 2 via ioctl(PIO_FONT).
> 
> 
> 
> Since vc_resize() with v.v_rows = 0 preserves current vc->vc_rows value,
> this reproducer is bypassing
> 
> 	if (v.v_clin) {
> 		int rows = v.v_vlin / v.v_clin;
> 		if (v.v_rows != rows) {
> 			if (v.v_rows) /* Parameters don't add up */
> 				return -EINVAL;
> 			v.v_rows = rows;
> 		}
> 	}
> 
> check by setting v.v_vlin = 1 and v.v_clin = 9.
> 
> If v.v_vcol > 0 and v.v_vcol != vc->vc_cols (though this reproducer is passing
> v.v_vcol = 0), tty_do_resize() from vc_do_resize() from vc_resize() can make
> "struct tty_struct"->winsize.ws_ypixel = 1 despite
> "struct tty_struct"->winsize.vc->vc_rows = vc->vc_rows (which is usually larger
> than 1). Does such winsize (a row has 1 / vc->vc_rows pixel) make sense?
> 
> 
> 
> Since I don't know the meaning of "struct vt_consize"->v_clin (which is commented
> with "/* number of pixel rows per character */" but does it mean font size ?),
> I don't know why we can assign that value to vcp->vc_font.height via
> 
> 	if (v.v_clin)
> 		vcp->vc_font.height = v.v_clin;
> 
> in vt_resizex(). While ioctl(PIO_FONT) needs to pass vc->vc_sw->con_font_set()
> check in con_font_set(), ioctl(VT_RESIZEX) does not pass it in vt_resizex()...
> 
> Since this problem does not happen if I remove
> 
> 	if (v.v_clin)
> 		vcp->vc_font.height = v.v_clin;

Hi Tetsuo!

>  from vt_resizex(), I guess that some variables are getting confused by change
> of vc->vc_font.height ...

Yes, see bit_putcs():

(drivers/video/fbdev/core/bitblit.c)
static void bit_putcs(struct vc_data *vc, struct fb_info *info,
		      const unsigned short *s, int count, int yy, int xx,
		      int fg, int bg)
{
	struct fb_image image;
	u32 width = DIV_ROUND_UP(vc->vc_font.width, 8);
	u32 cellsize = width * vc->vc_font.height;
	    ^^^^^^^^		   ^^^^^^^^^^^^^^

`cellsize` is now too large. Later, in bit_putcs_aligned():

	while (cnt--) {
		src = vc->vc_font.data + (scr_readw(s++)&
					  charmask)*cellsize;
						    ^^^^^^^^

`src` goes out of bounds of the data buffer. At first glance I guess
this is an out-of-bound read reported as a use-after-free read? The
crashlog says:

[  149.732103][ T6693] Allocated by task 6667:
[ 149.732115][ T6693] kasan_save_stack (mm/kasan/common.c:48)
[ 149.732121][ T6693] __kasan_kmalloc.constprop.0 (mm/kasan/common.c:56 mm/kasan/common.c:461)
[ 149.732126][ T6693] __kmalloc (mm/slab.c:3656 mm/slab.c:3664)
[ 149.732133][ T6693] alloc_pipe_info (fs/pipe.c:810)
[ 149.732139][ T6693] create_pipe_files (fs/pipe.c:883 fs/pipe.c:914)
[ 149.732145][ T6693] do_pipe2 (fs/pipe.c:965 fs/pipe.c:1012)

I'm not sure, but I don't think a buffer allocated in fs/pipe.c is
related here. Maybe they just live near each other on the heap?

To resolve this out-of-bound issue for now, I think the easiest way
is to add a range check in bit_putcs(), or bit_putcs_aligned().

...but yeah, that `VT_RESIZEX` ioctl looks really buggy, and is already
causing more issues:

KASAN: global-out-of-bounds Read in fbcon_get_font
Link: https://syzkaller.appspot.com/bug?idb8be45afea11888776f897895aef9ad1c3ecfd

This was also caused by `VT_RESIZEX`...

Thank you,
Peilin Ye
