From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 13 Jul 2017 18:49:48 +0000
Subject: Re: [PATCH 1/4] fbcon: Make fbcon a built-time depency for fbdev
Message-Id: <CAKMK7uFKMJeQZFA4DuMu0fE7yNbS-tOXNWEL80UPKL6qJm6CrQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
 <20170706125735.28299-2-daniel.vetter@ffwll.ch>
 <20170713144753.n344ilasywtsqfxi@art_vandelay>
In-Reply-To: <20170713144753.n344ilasywtsqfxi@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sean Paul <seanpaul@chromium.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Steven Rostedt <rostedt@goodmis.org>, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, Jul 13, 2017 at 4:47 PM, Sean Paul <seanpaul@chromium.org> wrote:
> On Thu, Jul 06, 2017 at 02:57:32PM +0200, Daniel Vetter wrote:
>
> <snip>
>
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>
> Just 2 nits, code looks good.
>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>
>> ---
>> v2: Switch to building fbcon code into fb.ko right away because the
>> cheap trick leads to a module depency loop.
>> ---
>>  drivers/video/console/Kconfig                        |  2 +-
>>  drivers/video/console/Makefile                       |  8 --------
>>  drivers/video/fbdev/core/Makefile                    | 11 +++++++++++
>>  drivers/video/{console => fbdev/core}/bitblit.c      |  4 ----
>>  drivers/video/{console => fbdev/core}/fbcon.c        | 13 +++----------
>>  drivers/video/{console => fbdev/core}/fbcon.h        |  0
>>  drivers/video/{console => fbdev/core}/fbcon_ccw.c    |  4 ----
>>  drivers/video/{console => fbdev/core}/fbcon_cw.c     |  4 ----
>>  drivers/video/{console => fbdev/core}/fbcon_rotate.c |  4 ----
>>  drivers/video/{console => fbdev/core}/fbcon_rotate.h |  0
>>  drivers/video/{console => fbdev/core}/fbcon_ud.c     |  4 ----
>>  drivers/video/fbdev/core/fbmem.c                     |  6 ++++++
>>  drivers/video/{console => fbdev/core}/softcursor.c   |  4 ----
>>  drivers/video/{console => fbdev/core}/tileblit.c     |  5 -----
>>  include/linux/fbcon.h                                | 12 ++++++++++++
>>  15 files changed, 33 insertions(+), 48 deletions(-)
>>  rename drivers/video/{console => fbdev/core}/bitblit.c (98%)
>>  rename drivers/video/{console => fbdev/core}/fbcon.c (99%)
>>  rename drivers/video/{console => fbdev/core}/fbcon.h (100%)
>>  rename drivers/video/{console => fbdev/core}/fbcon_ccw.c (98%)
>>  rename drivers/video/{console => fbdev/core}/fbcon_cw.c (98%)
>>  rename drivers/video/{console => fbdev/core}/fbcon_rotate.c (95%)
>>  rename drivers/video/{console => fbdev/core}/fbcon_rotate.h (100%)
>>  rename drivers/video/{console => fbdev/core}/fbcon_ud.c (98%)
>>  rename drivers/video/{console => fbdev/core}/softcursor.c (93%)
>>  rename drivers/video/{console => fbdev/core}/tileblit.c (96%)
>>  create mode 100644 include/linux/fbcon.h
>>
>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
>> index 2111d06f8c81..7f1f1fbcef9e 100644
>> --- a/drivers/video/console/Kconfig
>> +++ b/drivers/video/console/Kconfig
>> @@ -117,7 +117,7 @@ config DUMMY_CONSOLE_ROWS
>>            Select 25 if you use a 640x480 resolution by default.
>>
>>  config FRAMEBUFFER_CONSOLE
>> -     tristate "Framebuffer Console support"
>> +     bool "Framebuffer Console support"
>>       depends on FB && !UML
>>       select VT_HW_CONSOLE_BINDING
>>       select CRC32
>> diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
>> index 43bfa485db96..eb2cbec52643 100644
>> --- a/drivers/video/console/Makefile
>> +++ b/drivers/video/console/Makefile
>> @@ -7,13 +7,5 @@ obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
>>  obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
>>  obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
>>  obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
>> -obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o softcursor.o
>> -ifeq ($(CONFIG_FB_TILEBLITTING),y)
>> -obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += tileblit.o
>> -endif
>> -ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
>> -obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
>> -                                         fbcon_ccw.o
>> -endif
>>
>>  obj-$(CONFIG_FB_STI)              += sticore.o
>> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
>> index 9e3ddf225393..0214b863ac3f 100644
>> --- a/drivers/video/fbdev/core/Makefile
>> +++ b/drivers/video/fbdev/core/Makefile
>> @@ -4,6 +4,17 @@ obj-$(CONFIG_FB)                  += fb.o
>>  fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
>>                                       modedb.o fbcvt.o
>>  fb-$(CONFIG_FB_DEFERRED_IO)       += fb_defio.o
>> +
>> +ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE),y)
>> +fb-y                           += fbcon.o bitblit.o softcursor.o
>
> fb-$(CONFIG_FRAMEBUFFER_CONSOLE) ?

The ifeq is longer than just this line ...

>> +ifeq ($(CONFIG_FB_TILEBLITTING),y)
>> +fb-y                           += tileblit.o
>> +endif
>> +ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
>> +fb-y                           += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
>> +                                  fbcon_ccw.oli
>> +endif
>> +endif
>>  fb-objs                           := $(fb-y)
>>
>>  obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
>
> <snip>
>
>> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
>> new file mode 100644
>> index 000000000000..0fac6305d51c
>> --- /dev/null
>> +++ b/include/linux/fbcon.h
>
> IANAL, but it seems like you're missing some GPL legalese here?

There's a pile of headers which don't have the GPL header (like
linux/fb.h), I went with the local style ... not strictly necessary I
think.
-Daniel

>
> Sean
>
>> @@ -0,0 +1,12 @@
>> +#ifndef _LINUX_FBCON_H
>> +#define _LINUX_FBCON_H
>> +
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE
>> +void __init fb_console_init(void);
>> +void __exit fb_console_exit(void);
>> +#else
>> +static void fb_console_init(void) {}
>> +static void fb_console_exit(void) {}
>> +#endif
>> +
>> +#endif /* _LINUX_FBCON_H */
>> --
>> 2.13.2
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
