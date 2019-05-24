From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 24 May 2019 15:28:55 +0000
Subject: Re: [PATCH 24/33] Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
Message-Id: <CAKMK7uHWOY97FqyJ6FU1SYTgegKxm2A+R+X6Vjs0_zn1QGN3KQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-25-daniel.vetter@ffwll.ch> <20190524131453.e6mefygqyg46jeuf@holly.lan>
In-Reply-To: <20190524131453.e6mefygqyg46jeuf@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, Richard Purdie <rpurdie@rpsys.net>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

Hi Daniel,

On Fri, May 24, 2019 at 3:14 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, May 24, 2019 at 10:53:45AM +0200, Daniel Vetter wrote:
> > This reverts commit 994efacdf9a087b52f71e620b58dfa526b0cf928.
> >
> > The justification is that if hw blanking fails (i.e. fbops->fb_blank)
> > fails, then we still want to shut down the backlight. Which is exactly
> > _not_ what fb_blank() does and so rather inconsistent if we end up
> > with different behaviour between fbcon and direct fbdev usage. Given
> > that the entire notifier maze is getting in the way anyway I figured
> > it's simplest to revert this not well justified commit.
> >
> > v2: Add static inline to the dummy version.
> >
> > Cc: Richard Purdie <rpurdie@rpsys.net>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Yisheng Xie <ysxie@foxmail.com>
> > Cc: linux-fbdev@vger.kernel.org
>
> Hi Daniel
>
> When this goes round again could you add me to the covering letter?
>
> I looked at all three of the patches and no objections on my side but
> I'm reluctant to send out acks because I'm not sure I understood the
> wider picture well enough.

It's one of these patch series with some many different subsystems and
people you can't cc the cover to all of them or mailing lists start
rejecting you because too many recipients. I tried to spam sufficient
mailng lists, but I guess not enough.

Cover letter of version one, which tries to explain the full big picture:

https://lists.freedesktop.org/archives/dri-devel/2019-May/218362.html

tldr; I have a multi-year plan to improve fbcon locking, because the
current thing is a bit a mess.

Cover letter of this version, where I detail a bit more the details
fixed in this one here:

https://lists.freedesktop.org/archives/dri-devel/2019-May/218984.html

I can also bounce these to you if you want.

Thanks, Daniel

>
>
> Daniel.
>
>
> > ---
> >  drivers/video/backlight/backlight.c |  2 +-
> >  drivers/video/fbdev/core/fbcon.c    | 14 +-------------
> >  drivers/video/fbdev/core/fbmem.c    |  1 +
> >  include/linux/fb.h                  |  4 +---
> >  include/linux/fbcon.h               |  2 ++
> >  5 files changed, 6 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> > index deb824bef6e2..c55590ec0057 100644
> > --- a/drivers/video/backlight/backlight.c
> > +++ b/drivers/video/backlight/backlight.c
> > @@ -46,7 +46,7 @@ static int fb_notifier_callback(struct notifier_block *self,
> >       int fb_blank = 0;
> >
> >       /* If we aren't interested in this event, skip it immediately ... */
> > -     if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
> > +     if (event != FB_EVENT_BLANK)
> >               return 0;
> >
> >       bd = container_of(self, struct backlight_device, fb_notif);
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index 259cdd118475..d9f545f1a81b 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2350,8 +2350,6 @@ static int fbcon_switch(struct vc_data *vc)
> >  static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
> >                               int blank)
> >  {
> > -     struct fb_event event;
> > -
> >       if (blank) {
> >               unsigned short charmask = vc->vc_hi_font_mask ?
> >                       0x1ff : 0xff;
> > @@ -2362,13 +2360,6 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
> >               fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
> >               vc->vc_video_erase_char = oldc;
> >       }
> > -
> > -
> > -     lock_fb_info(info);
> > -     event.info = info;
> > -     event.data = &blank;
> > -     fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
> > -     unlock_fb_info(info);
> >  }
> >
> >  static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
> > @@ -3240,7 +3231,7 @@ int fbcon_fb_registered(struct fb_info *info)
> >       return ret;
> >  }
> >
> > -static void fbcon_fb_blanked(struct fb_info *info, int blank)
> > +void fbcon_fb_blanked(struct fb_info *info, int blank)
> >  {
> >       struct fbcon_ops *ops = info->fbcon_par;
> >       struct vc_data *vc;
> > @@ -3344,9 +3335,6 @@ static int fbcon_event_notify(struct notifier_block *self,
> >               con2fb = event->data;
> >               con2fb->framebuffer = con2fb_map[con2fb->console - 1];
> >               break;
> > -     case FB_EVENT_BLANK:
> > -             fbcon_fb_blanked(info, *(int *)event->data);
> > -             break;
> >       case FB_EVENT_REMAP_ALL_CONSOLE:
> >               idx = info->node;
> >               fbcon_remap_all(idx);
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index ddc0c16b8bbf..9366fbe99a58 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1068,6 +1068,7 @@ fb_blank(struct fb_info *info, int blank)
> >       event.data = &blank;
> >
> >       early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
> > +     fbcon_fb_blanked(info, blank);
> >
> >       if (info->fbops->fb_blank)
> >               ret = info->fbops->fb_blank(blank, info);
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 0d86aa31bf8d..1e66fac3124f 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -137,12 +137,10 @@ struct fb_cursor_user {
> >  #define FB_EVENT_GET_CONSOLE_MAP        0x07
> >  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
> >  #define FB_EVENT_SET_CONSOLE_MAP        0x08
> > -/*      A hardware display blank change occurred */
> > +/*      A display blank is requested       */
> >  #define FB_EVENT_BLANK                  0x09
> >  /*      Private modelist is to be replaced */
> >  #define FB_EVENT_MODE_CHANGE_ALL     0x0B
> > -/*   A software display blank change occurred */
> > -#define FB_EVENT_CONBLANK               0x0C
> >  /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
> >  #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
> >  /*      A hardware display blank early change occurred */
> > diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> > index 305e4f2eddac..d67d7ec51ef9 100644
> > --- a/include/linux/fbcon.h
> > +++ b/include/linux/fbcon.h
> > @@ -14,6 +14,7 @@ int fbcon_mode_deleted(struct fb_info *info,
> >  void fbcon_new_modelist(struct fb_info *info);
> >  void fbcon_get_requirement(struct fb_info *info,
> >                          struct fb_blit_caps *caps);
> > +void fbcon_fb_blanked(struct fb_info *info, int blank);
> >  #else
> >  static inline void fb_console_init(void) {}
> >  static inline void fb_console_exit(void) {}
> > @@ -27,6 +28,7 @@ static inline int fbcon_mode_deleted(struct fb_info *info,
> >  static inline void fbcon_new_modelist(struct fb_info *info) {}
> >  static inline void fbcon_get_requirement(struct fb_info *info,
> >                                        struct fb_blit_caps *caps) {}
> > +static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
> >  #endif
> >
> >  #endif /* _LINUX_FBCON_H */
> > --
> > 2.20.1
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
