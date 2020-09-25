From: Jiri Slaby <jirislaby@kernel.org>
Date: Fri, 25 Sep 2020 06:46:04 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
In-Reply-To: <cover.1600953813.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peilin Ye <yepeilin.cs@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linuxfoundation.org

On 24. 09. 20, 15:38, Peilin Ye wrote:
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

Hi,

but you still can define struct kernel_console_font containing struct
console_font and the 4 more members you need in the kernel. See below.

> Fortunately, the framebuffer layer itself gives us a hint of how to
> resolve this issue without changing UAPI. When allocating a buffer for a
> user-provided font, fbcon_set_font() reserves four "extra words" at the
> beginning of the buffer:
> 
> (drivers/video/fbdev/core/fbcon.c)
> 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);

I might be missing something (like coffee in the morning), but why don't
you just:
1) declare struct font_data as
{
  unsigned sum, char_count, size, refcnt;
  const unsigned char data[];
}

Or maybe "struct console_font font" instead of "const unsigned char
data[]", if need be.

2) allocate by:
  kmalloc(struct_size(struct font_data, data, size));

3) use container_of wherever needed

That is you name the data on negative indexes using struct as you
already have to define one.

Then you don't need the ugly macros with negative indexes. And you can
pass this structure down e.g. to fbcon_do_set_font, avoiding potential
mistakes in accessing data[-1] and similar.

thanks,
-- 
js
