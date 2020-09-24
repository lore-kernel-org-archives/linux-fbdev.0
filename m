From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Thu, 24 Sep 2020 16:59:19 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200924165919.GA880812@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <20200924140937.GA749208@kroah.com>
 <394733ab6fae47488d078cb22f22a85b@AcuMS.aculab.com>
 <20200924153035.GA879703@PWN> <20200924154516.GL4282@kadam>
In-Reply-To: <20200924154516.GL4282@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, David Laight <David.Laight@aculab.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, linux-kernel-mentees@lists.linuxfoundation.org

On Thu, Sep 24, 2020 at 06:45:16PM +0300, Dan Carpenter wrote:
> Smatch has a tool to show where struct members are set.
> 
> `~/smatch/smatch_data/db/smdb.py where console_font height`
> 
> It's not perfect and this output comes from allmodconfig on yesterday's
> linux-next.
> 
> regards,
> dan carpenter

Wow, thank you for the really interesting information!

> drivers/video/console/vgacon.c | vgacon_init                    | (struct console_font)->height | 0-32
> drivers/video/console/vgacon.c | vgacon_adjust_height           | (struct console_font)->height | 1-32
> drivers/video/fbdev/core/fbcon.c | fbcon_startup                  | (struct console_font)->height | 6,8,10-11,14,16,18,22,32
> drivers/video/fbdev/core/fbcon.c | fbcon_init                     | (struct console_font)->height | 6,8,10-11,14,16,18,22,32
> drivers/video/fbdev/core/fbcon.c | fbcon_do_set_font              | (struct console_font)->height | 0-u32max
> drivers/video/fbdev/core/fbcon.c | fbcon_set_def_font             | (struct console_font)->height | 6,8,10-11,14,16,18,22,32
> drivers/usb/misc/sisusbvga/sisusb_con.c | sisusbcon_init                 | (struct console_font)->height | 0-u32max

In looking at this one,
	c->vc_font.height = sisusb->current_font_height;

`sisusb->current_font_height` is only set in sisusbcon_do_font_op():
		sisusb->current_font_height = fh;

and...

> drivers/usb/misc/sisusbvga/sisusb_con.c | sisusbcon_do_font_op           | (struct console_font)->height | 1-32

...sisusbcon_do_font_op() is called in four places, with an `fh` of either
16, `sisusb->font_backup_height`, or `font->height`. The latter two cases
all come from sisusbcon_font_set(), whose dispatcher, con_font_set()
gurantees that `font->height` is less than or equal to 32, as shown by
Smatch here.

> drivers/tty/vt/vt_ioctl.c      | vt_k_ioctl                     | (struct console_font)->height | ignore
> drivers/tty/vt/vt_ioctl.c      | vt_resizex                     | (struct console_font)->height | 0-u32max
> drivers/tty/vt/vt_ioctl.c      | vt_ioctl                       | (struct console_font)->height | ignore
> drivers/tty/vt/vt_ioctl.c      | vt_compat_ioctl                | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | vc_allocate                    | (struct console_font)->height | 0
> drivers/tty/vt/vt.c            | vt_resize                      | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | do_con_write                   | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_unthrottle                 | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_flush_chars                | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_shutdown                   | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_cleanup                    | (struct console_font)->height | ignore
> drivers/tty/vt/vt.c            | con_init                       | (struct console_font)->height | 0
> drivers/tty/vt/vt.c            | con_font_set                   | (struct console_font)->height | 1-32
> drivers/tty/vt/vt.c            | con_font_default               | (struct console_font)->height | 0-u32max
> drivers/tty/vt/selection.c     | paste_selection                | (struct console_font)->height | ignore

I will go through the list starting from these "0-u32max" cases. Thanks
again!

Peilin Ye
