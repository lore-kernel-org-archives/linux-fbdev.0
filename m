From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Fri, 25 Sep 2020 10:13:00 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200925101300.GA890211@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
In-Reply-To: <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jirislaby@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linuxfoundation.org

Hi all!

On Fri, Sep 25, 2020 at 08:46:04AM +0200, Jiri Slaby wrote:
> > In order to perform a reliable range check, fbcon_get_font() needs to know
> > `FONTDATAMAX` for each built-in font under lib/fonts/. Unfortunately, we
> > do not keep that information in our font descriptor,
> > `struct console_font`:
> > 
> > (include/uapi/linux/kd.h)
> > struct console_font {
> > 	unsigned int width, height;	/* font size */
> > 	unsigned int charcount;
> > 	unsigned char *data;	/* font data with height fixed to 32 */
> > };
> > 
> > To make things worse, `struct console_font` is part of the UAPI, so we
> > cannot add a new field to keep track of `FONTDATAMAX`.
> 
> Hi,
> 
> but you still can define struct kernel_console_font containing struct
> console_font and the 4 more members you need in the kernel. See below.
> 
> > Fortunately, the framebuffer layer itself gives us a hint of how to
> > resolve this issue without changing UAPI. When allocating a buffer for a
> > user-provided font, fbcon_set_font() reserves four "extra words" at the
> > beginning of the buffer:
> > 
> > (drivers/video/fbdev/core/fbcon.c)
> > 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
> 
> I might be missing something (like coffee in the morning), but why don't
> you just:
> 1) declare struct font_data as
> {
>   unsigned sum, char_count, size, refcnt;
>   const unsigned char data[];
> }
> 
> Or maybe "struct console_font font" instead of "const unsigned char
> data[]", if need be.
> 
> 2) allocate by:
>   kmalloc(struct_size(struct font_data, data, size));
> 
> 3) use container_of wherever needed
> 
> That is you name the data on negative indexes using struct as you
> already have to define one.
> 
> Then you don't need the ugly macros with negative indexes. And you can
> pass this structure down e.g. to fbcon_do_set_font, avoiding potential
> mistakes in accessing data[-1] and similar.

Sorry that I didn't mention it in the cover letter, but yes, I've tried
this - a new `kernel_console_font` would be much cleaner than negative
array indexing.

The reason I ended up giving it up was, frankly speaking, these macros
are being used at about 30 places, and I am not familiar enough with the
framebuffer and newport_con code, so I wasn't confident how to clean
them up and plug in `kernel_console_font` properly...

Another reason was that, functions like fbcon_get_font() handle both user
fonts and built-in fonts, so I wanted a single solution for both of
them. I think we can't really introduce `kernel_console_font` while
keeping these macros, that would make the error handling logics etc.
very messy.

I'm not very sure what to do now. Should I give it another try cleaning
up all the macros?

And thank you for reviewing this!

Peilin Ye
