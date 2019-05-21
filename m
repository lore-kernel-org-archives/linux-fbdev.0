From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 21 May 2019 15:09:39 +0000
Subject: Re: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
Message-Id: <20190521150939.GQ21222@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-11-daniel.vetter@ffwll.ch>
 <423eba4b-15e1-f10b-ae2d-855b8a585688@suse.de>
 <8aecc0d8-83a3-8144-a266-441a5c1d5db5@suse.de>
In-Reply-To: <8aecc0d8-83a3-8144-a266-441a5c1d5db5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Yisheng Xie <ysxie@foxmail.com>, Peter Rosin <peda@axentia.se>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Mikulas Patocka <mpatocka@redhat.com>, linux-fbdev@vger.kernel.org

On Mon, May 20, 2019 at 10:37:53AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 20.05.19 um 10:33 schrieb Thomas Zimmermann:
> > Hi
> >=20
> > Am 20.05.19 um 10:21 schrieb Daniel Vetter:
> > ...
> >> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/co=
re/fbmem.c
> >> index fc3d34a8ea5b..ae2db31eeba7 100644
> >> --- a/drivers/video/fbdev/core/fbmem.c
> >> +++ b/drivers/video/fbdev/core/fbmem.c
> >> @@ -1660,7 +1660,6 @@ MODULE_PARM_DESC(lockless_register_fb,
> >>  static int do_register_framebuffer(struct fb_info *fb_info)
> >>  {
> >>  	int i, ret;
> >> -	struct fb_event event;
> >>  	struct fb_videomode mode;
> >> =20
> >>  	if (fb_check_foreignness(fb_info))
> >> @@ -1723,7 +1722,6 @@ static int do_register_framebuffer(struct fb_inf=
o *fb_info)
> >>  	fb_add_videomode(&mode, &fb_info->modelist);
> >>  	registered_fb[i] =3D fb_info;
> >> =20
> >> -	event.info =3D fb_info;
> >>  	if (!lockless_register_fb)
> >>  		console_lock();
> >>  	else
> >> @@ -1732,9 +1730,8 @@ static int do_register_framebuffer(struct fb_inf=
o *fb_info)
> >>  		ret =3D -ENODEV;
> >>  		goto unlock_console;
> >>  	}
> >> -	ret =3D 0;
> >> =20
> >> -	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
> >> +	ret =3D fbcon_fb_registered(fb_info);
> >=20
> > What about backlight drivers? [1] Apparently these also use the
> > notifiers. [2] From my understanding, backlight drivers would stop
> > working with this change.
>=20
> I just saw that backlight drivers only care about blanking and
> unblanking. Never mind then.

I did screw this up for one event for the mode changes. But should be
fixed in the next series.

I also added a patch to simplify the backlight/lcd notifier, since it
doesn't need to filter events anymore after this series - the only events
left are the ones backlight cares about.

Cheers, Daniel

>=20
> Best regards
> Thomas
>=20
> >=20
> > Best regards
> > Thomas
> >=20
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/video/backlight
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/video/backlight/backlight.c#n40
> >=20
> >>  	unlock_fb_info(fb_info);
> >>  unlock_console:
> >>  	if (!lockless_register_fb)
> >> @@ -1771,7 +1768,6 @@ static int __unlink_framebuffer(struct fb_info *=
fb_info);
> >> =20
> >>  static int do_unregister_framebuffer(struct fb_info *fb_info)
> >>  {
> >> -	struct fb_event event;
> >>  	int ret;
> >> =20
> >>  	ret =3D unbind_console(fb_info);
> >> @@ -1789,9 +1785,8 @@ static int do_unregister_framebuffer(struct fb_i=
nfo *fb_info)
> >>  	registered_fb[fb_info->node] =3D NULL;
> >>  	num_registered_fb--;
> >>  	fb_cleanup_device(fb_info);
> >> -	event.info =3D fb_info;
> >>  	console_lock();
> >> -	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
> >> +	fbcon_fb_unregistered(fb_info);
> >>  	console_unlock();
> >> =20
> >>  	/* this may free fb info */
> >> diff --git a/include/linux/fb.h b/include/linux/fb.h
> >> index f52ef0ad6781..701abaf79c87 100644
> >> --- a/include/linux/fb.h
> >> +++ b/include/linux/fb.h
> >> @@ -136,10 +136,6 @@ struct fb_cursor_user {
> >>  #define FB_EVENT_RESUME			0x03
> >>  /*      An entry from the modelist was removed */
> >>  #define FB_EVENT_MODE_DELETE            0x04
> >> -/*      A driver registered itself */
> >> -#define FB_EVENT_FB_REGISTERED          0x05
> >> -/*      A driver unregistered itself */
> >> -#define FB_EVENT_FB_UNREGISTERED        0x06
> >>  /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
> >>  #define FB_EVENT_GET_CONSOLE_MAP        0x07
> >>  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
> >> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> >> index f68a7db14165..94a71e9e1257 100644
> >> --- a/include/linux/fbcon.h
> >> +++ b/include/linux/fbcon.h
> >> @@ -4,9 +4,13 @@
> >>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE
> >>  void __init fb_console_init(void);
> >>  void __exit fb_console_exit(void);
> >> +int fbcon_fb_registered(struct fb_info *info);
> >> +void fbcon_fb_unregistered(struct fb_info *info);
> >>  #else
> >>  static inline void fb_console_init(void) {}
> >>  static inline void fb_console_exit(void) {}
> >> +static inline int fbcon_fb_registered(struct fb_info *info) { return =
0; }
> >> +static inline void fbcon_fb_unregistered(struct fb_info *info) {}
> >>  #endif
> >> =20
> >>  #endif /* _LINUX_FBCON_H */
> >>
> >=20
>=20
> --=20
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imend=F6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=FCrnberg)
>=20




--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
