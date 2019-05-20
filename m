From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 17:25:28 +0000
Subject: Re: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
Message-Id: <CAKMK7uHQo83UZmkV=gd3hHCMpusSdK_6O_UQnnHdSm+kLMgmmA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-11-daniel.vetter@ffwll.ch> <20190520170820.GA27230@ravnborg.org>
In-Reply-To: <20190520170820.GA27230@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@intel.com>, Peter Rosin <peda@axentia.se>

On Mon, May 20, 2019 at 7:08 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Daniel.
>
> While browsing this nice patch series I stumbled upon a detail.
>
> On Mon, May 20, 2019 at 10:21:53AM +0200, Daniel Vetter wrote:
> > With
> >
> > commit 6104c37094e729f3d4ce65797002112735d49cd1
> > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Date:   Tue Aug 1 17:32:07 2017 +0200
> >
> >     fbcon: Make fbcon a built-time depency for fbdev
> >
> > we have a static dependency between fbcon and fbdev, and we can
> > replace the indirection through the notifier chain with a function
> > call.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Noralf Trønnes" <noralf@tronnes.org>
> > Cc: Yisheng Xie <ysxie@foxmail.com>
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index f52ef0ad6781..701abaf79c87 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -136,10 +136,6 @@ struct fb_cursor_user {
> >  #define FB_EVENT_RESUME                      0x03
> >  /*      An entry from the modelist was removed */
> >  #define FB_EVENT_MODE_DELETE            0x04
> > -/*      A driver registered itself */
> > -#define FB_EVENT_FB_REGISTERED          0x05
> > -/*      A driver unregistered itself */
> > -#define FB_EVENT_FB_UNREGISTERED        0x06
> >  /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
> >  #define FB_EVENT_GET_CONSOLE_MAP        0x07
> >  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
>
> This breaks build of arch/arm/mach-pxa/am200epd.c thats uses
> FB_EVENT_FB_*REGISTERED:
>
>
>        if (event == FB_EVENT_FB_REGISTERED)
>                 return am200_share_video_mem(info);
>         else if (event == FB_EVENT_FB_UNREGISTERED)
>                 return am200_unshare_video_mem(info);
>
>
> Found while grepping for "FB_EVENT" so this is not a build
> error I triggered.

Oh this is glorious :-/

Thanks a lot for spotting this, I guess I need to hack around on
metronomefb a bit ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
