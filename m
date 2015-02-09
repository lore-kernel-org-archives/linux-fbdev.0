From: <harald@ccbib.org>
Date: Mon, 09 Feb 2015 11:38:38 +0000
Subject: fbdev: =?UTF-8?Q?fb=5Fdefio=20not=20buildable=20as=20module?=
Message-Id: <73d569a4689073b80531b2f4e98f96bc@imap.cosmopool.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi *,

in drivers/video/fbdev/Kconfig we have

| menuconfig FB
|        tristate "Support for frame buffer devices"
|        select FB_CMDLINE
|        ---help---

and

| config FB_DEFERRED_IO
|        bool
|        depends on FB

but in drivers/video/fbdev/core/Makefile we have the line
| obj-$(CONFIG_FB_DEFERRED_IO)   += fb_defio.o

AFAICS the combination of this leads to fb_defio always
linked into the kernel image, even if the framebuffer core
is only built as a module. This doesn't make much sense and
I couldn't find any reason why this would be necessary.

The above code is there in one way or the other since the
initial version of fb_defio.c - I wonder what was the
intended behaviour or actually what is considered the right
way today?

TIA,
Harald
