From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 24 Sep 2020 14:09:37 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200924140937.GA749208@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
In-Reply-To: <cover.1600953813.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peilin Ye <yepeilin.cs@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jirislaby@kernel.org>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linuxfoundation.org

On Thu, Sep 24, 2020 at 09:38:22AM -0400, Peilin Ye wrote:
> Hi all,
> 
> syzbot has reported [1] a global out-of-bounds read issue in
> fbcon_get_font(). A malicious user may resize `vc_font.height` to a large
> value in vt_ioctl(), causing fbcon_get_font() to overflow our built-in
> font data buffers, declared in lib/fonts/font_*.c:
> 
> (e.g. lib/fonts/font_8x8.c)
> #define FONTDATAMAX 2048
> 
> static const unsigned char fontdata_8x8[FONTDATAMAX] = {
> 
>         /* 0 0x00 '^@' */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         [...]
> 
> In order to perform a reliable range check, fbcon_get_font() needs to know
> `FONTDATAMAX` for each built-in font under lib/fonts/. Unfortunately, we
> do not keep that information in our font descriptor,
> `struct console_font`:
> 
> (include/uapi/linux/kd.h)
> struct console_font {
> 	unsigned int width, height;	/* font size */
> 	unsigned int charcount;
> 	unsigned char *data;	/* font data with height fixed to 32 */
> };
> 
> To make things worse, `struct console_font` is part of the UAPI, so we
> cannot add a new field to keep track of `FONTDATAMAX`.
> 
> Fortunately, the framebuffer layer itself gives us a hint of how to
> resolve this issue without changing UAPI. When allocating a buffer for a
> user-provided font, fbcon_set_font() reserves four "extra words" at the
> beginning of the buffer:
> 
> (drivers/video/fbdev/core/fbcon.c)
> 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
>         [...]
> 	new_data += FONT_EXTRA_WORDS * sizeof(int);
> 	FNTSIZE(new_data) = size;
> 	FNTCHARCNT(new_data) = charcount;
> 	REFCOUNT(new_data) = 0;	/* usage counter */
>         [...]
> 	FNTSUM(new_data) = csum;
> 
> Later, to get the size of a data buffer, the framebuffer layer simply
> calls FNTSIZE() on it:
> 
> (drivers/video/fbdev/core/fbcon.h)
> 	/* Font */
> 	#define REFCOUNT(fd)	(((int *)(fd))[-1])
> 	#define FNTSIZE(fd)	(((int *)(fd))[-2])
> 	#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
> 	#define FNTSUM(fd)	(((int *)(fd))[-4])
> 	#define FONT_EXTRA_WORDS 4
> 
> Currently, this is only done for user-provided fonts. Let us do the same
> thing for built-in fonts, prepend these "extra words" (including
> `FONTDATAMAX`) to their data buffers, so that other subsystems, like the
> framebuffer layer, can use these macros on all fonts, no matter built-in
> or user-provided. As an example, this series fixes the syzbot issue in
> fbcon_get_font():
> 
> (drivers/video/fbdev/core/fbcon.c)
>  	if (font->width <= 8) {
>  		j = vc->vc_font.height;
> +		if (font->charcount * j > FNTSIZE(fontdata))
> +			return -EINVAL;
> 	[...]
> 
> Similarly, newport_con also use these macros. It only uses three of them:
> 
> (drivers/video/console/newport_con.c)
> 	/* borrowed from fbcon.c */
> 	#define REFCOUNT(fd)	(((int *)(fd))[-1])
> 	#define FNTSIZE(fd)	(((int *)(fd))[-2])
> 	#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
> 	#define FONT_EXTRA_WORDS 3
> 
> To keep things simple, move all these macro definitions to <linux/font.h>,
> use four words instead of three, and initialize the fourth word in
> newport_set_font() properly.
> 
> Many thanks to Greg Kroah-Hartman <gregkh@linuxfoundation.org>, who
> reviewed and improved this series!
> 
> [1]: KASAN: global-out-of-bounds Read in fbcon_get_font
>      https://syzkaller.appspot.com/bug?idb8be45afea11888776f897895aef9ad1c3ecfd
> 
> Peilin Ye (3):
>   fbdev, newport_con: Move FONT_EXTRA_WORDS macros into linux/font.h
>   Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts
>   fbcon: Fix global-out-of-bounds read in fbcon_get_font()
> 
>  drivers/video/console/newport_con.c     |  7 +------
>  drivers/video/fbdev/core/fbcon.c        | 12 ++++++++++++
>  drivers/video/fbdev/core/fbcon.h        |  7 -------
>  drivers/video/fbdev/core/fbcon_rotate.c |  1 +
>  drivers/video/fbdev/core/tileblit.c     |  1 +
>  include/linux/font.h                    | 13 +++++++++++++
>  lib/fonts/font_10x18.c                  |  9 ++++-----
>  lib/fonts/font_6x10.c                   |  9 +++++----
>  lib/fonts/font_6x11.c                   |  9 ++++-----
>  lib/fonts/font_7x14.c                   |  9 ++++-----
>  lib/fonts/font_8x16.c                   |  9 ++++-----
>  lib/fonts/font_8x8.c                    |  9 ++++-----
>  lib/fonts/font_acorn_8x8.c              |  9 ++++++---
>  lib/fonts/font_mini_4x6.c               |  8 ++++----
>  lib/fonts/font_pearl_8x8.c              |  9 ++++-----
>  lib/fonts/font_sun12x22.c               |  9 ++++-----
>  lib/fonts/font_sun8x16.c                |  7 ++++---
>  lib/fonts/font_ter16x32.c               |  9 ++++-----
>  18 files changed, 79 insertions(+), 67 deletions(-)

Gotta love going backwards in arrays :)

Nice work, whole series is:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Daniel, can you take this through your tree?

thanks,

greg k-h
