From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Tue, 29 Sep 2020 12:34:20 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200929123420.GA1143575@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
In-Reply-To: <20200925132551.GF438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jiri Slaby <jirislaby@kernel.org>, linux-kernel-mentees@lists.linuxfoundation.org

On Fri, Sep 25, 2020 at 03:25:51PM +0200, Daniel Vetter wrote:
> I think the only way to make this work is that we have one place which
> takes in the userspace uapi struct, and then converts it once into a
> kernel_console_font. With all the error checking.

Hi Daniel,

It seems that users don't use `console_font` directly, they use
`console_font_op`. Then, in TTY:

(drivers/tty/vt/vt.c)
int con_font_op(struct vc_data *vc, struct console_font_op *op)
{
	switch (op->op) {
	case KD_FONT_OP_SET:
		return con_font_set(vc, op);
	case KD_FONT_OP_GET:
		return con_font_get(vc, op);
	case KD_FONT_OP_SET_DEFAULT:
		return con_font_default(vc, op);
	case KD_FONT_OP_COPY:
		return con_font_copy(vc, op);
	}
	return -ENOSYS;
}

These 4 functions allocate `console_font`. We can replace them with our
`kernel_console_font`. So, ...

$ vgrep "\.con_font_set"
Index File                                    Line Content
    0 drivers/usb/misc/sisusbvga/sisusb_con.c 1294 .con_font_set =              sisusbcon_font_set,
    1 drivers/usb/misc/sisusbvga/sisusb_con.c 1378 .con_font_set =              sisusbdummycon_font_set,
    2 drivers/video/console/dummycon.c         162 .con_font_set =      dummycon_font_set,
    3 drivers/video/console/newport_con.c      693 .con_font_set          = newport_font_set,
    4 drivers/video/console/vgacon.c          1226 .con_font_set = vgacon_font_set,
    5 drivers/video/fbdev/core/fbcon.c        3120 .con_font_set                = fbcon_set_font,
$
$ vgrep "\.con_font_get"
Index File                                    Line Content
    0 drivers/usb/misc/sisusbvga/sisusb_con.c 1295 .con_font_get =              sisusbcon_font_get,
    1 drivers/video/console/vgacon.c          1227 .con_font_get = vgacon_font_get,
    2 drivers/video/fbdev/core/fbcon.c        3121 .con_font_get                = fbcon_get_font,
$
$ vgrep "\.con_font_default"
Index File                                    Line Content
    0 drivers/usb/misc/sisusbvga/sisusb_con.c 1379 .con_font_default =  sisusbdummycon_font_default,
    1 drivers/video/console/dummycon.c         163 .con_font_default =  dummycon_font_default,
    2 drivers/video/console/newport_con.c      694 .con_font_default = newport_font_default,
    3 drivers/video/fbdev/core/fbcon.c        3122 .con_font_default    = fbcon_set_def_font,
$
$ vgrep "\.con_font_copy"
Index File                                    Line Content
    0 drivers/usb/misc/sisusbvga/sisusb_con.c 1380 .con_font_copy =     sisusbdummycon_font_copy,
    1 drivers/video/console/dummycon.c         164 .con_font_copy =     dummycon_font_copy,
    2 drivers/video/fbdev/core/fbcon.c        3123 .con_font_copy               = fbcon_copy_font,
$ _

... are these all the callbacks we need to take care of? What about
other console drivers that don't register these callbacks? ...

$ vgrep "\.con_init"
Index File                                    Line Content
[...]
    3 drivers/usb/misc/sisusbvga/sisusb_con.c 1285 .con_init =          sisusbcon_init,
    4 drivers/usb/misc/sisusbvga/sisusb_con.c 1369 .con_init =          sisusbdummycon_init,
    5 drivers/video/console/dummycon.c         153 .con_init =          dummycon_init,
    6 drivers/video/console/mdacon.c           544 .con_init =          mdacon_init,
    7 drivers/video/console/newport_con.c      684 .con_init      = newport_init,
    8 drivers/video/console/sticon.c           328 .con_init            = sticon_init,
    9 drivers/video/console/vgacon.c          1217 .con_init = vgacon_init,
   10 drivers/video/fbdev/core/fbcon.c        3111 .con_init             = fbcon_init,
[...]

... for example, mdacon.c? What font does mdacon.c use? I know that
/lib/fonts/ exports two functions, find_font() and get_default_font(),
but I don't see them being used in mdacon.c.

Ah, and speaking of built-in fonts, see fbcon_startup():

	/* Setup default font */
		[...]
		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
			    ^^^^^^^^^^^^^^^

This is because find_font() and get_default_font() return a `struct
font_desc *`, but `struct font_desc` doesn't contain `charcount`. I
think we also need to add a `charcount` field to `struct font_desc`.

> Then all internal code deals in terms of kernel_console_font, with
> properly typed and named struct members and helper functions and
> everything. And we might need a gradual conversion for this, so that first
> we can convert over invidual console drivers, then subsystems, until at
> the end we've pushed the conversion from uapi array to kernel_console_font
> all the way to the ioctl entry points.

Currently `struct vc_data` contains a `struct console_font vc_font`, and
I think this is making gradual conversion very hard. As an example, in
fbcon_do_set_font(), we update `vc->vc_font`. We lose all the extra
information we want in `kernel_console_font`, as long as `struct
vc_data` still uses `console_font`...

However, if we let `struct vc_data` use `kernel_console_font` instead,
we'll have to handle a lot of things in one go:

$ vgrep --no-less --no-header ".vc_font" | wc -l
296
$ echo ":("
:(

The good news is, I've tried cleaning up all the macros in fbcon.c in my
playground, and things seem to work. For example, currently we have:

	if (userfont)
		cnt = FNTCHARCNT(data);
	else
		cnt = 256;

After introducing `kernel_console_font` (and adding `charcount` to
`struct font_desc` etc.), this should look like:

#define to_font(_data) container_of(_data, struct kernel_console_font, data)
	[...]
	cnt = to_font(data)->charcount;

No more `if` and `else`, and the framebuffer layer will be able to
support new bulit-in fonts that have more than 256 characters. This
seems really nice, so I'd like to spend some time working on it.

However before I start working on real patches, do you have suggestions
about which console driver I should start with, or how should I split up
the work in general? I couldn't think of how do we clean up subsystems
one by one, while keeping a `console_font` in `struct vc_data`.

Thank you!
Peilin Ye
