From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Thu, 24 Sep 2020 14:25:25 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200924142525.GA879276@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <20200924140937.GA749208@kroah.com>
In-Reply-To: <20200924140937.GA749208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jirislaby@kernel.org>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linuxfoundation.org

On Thu, Sep 24, 2020 at 04:09:37PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2020 at 09:38:22AM -0400, Peilin Ye wrote:
> > Peilin Ye (3):
> >   fbdev, newport_con: Move FONT_EXTRA_WORDS macros into linux/font.h
> >   Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts
> >   fbcon: Fix global-out-of-bounds read in fbcon_get_font()
> > 
> >  drivers/video/console/newport_con.c     |  7 +------
> >  drivers/video/fbdev/core/fbcon.c        | 12 ++++++++++++
> >  drivers/video/fbdev/core/fbcon.h        |  7 -------
> >  drivers/video/fbdev/core/fbcon_rotate.c |  1 +
> >  drivers/video/fbdev/core/tileblit.c     |  1 +
> >  include/linux/font.h                    | 13 +++++++++++++
> >  lib/fonts/font_10x18.c                  |  9 ++++-----
> >  lib/fonts/font_6x10.c                   |  9 +++++----
> >  lib/fonts/font_6x11.c                   |  9 ++++-----
> >  lib/fonts/font_7x14.c                   |  9 ++++-----
> >  lib/fonts/font_8x16.c                   |  9 ++++-----
> >  lib/fonts/font_8x8.c                    |  9 ++++-----
> >  lib/fonts/font_acorn_8x8.c              |  9 ++++++---
> >  lib/fonts/font_mini_4x6.c               |  8 ++++----
> >  lib/fonts/font_pearl_8x8.c              |  9 ++++-----
> >  lib/fonts/font_sun12x22.c               |  9 ++++-----
> >  lib/fonts/font_sun8x16.c                |  7 ++++---
> >  lib/fonts/font_ter16x32.c               |  9 ++++-----
> >  18 files changed, 79 insertions(+), 67 deletions(-)
> 
> Gotta love going backwards in arrays :)
> 
> Nice work, whole series is:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for reviewing it!

Peilin Ye
