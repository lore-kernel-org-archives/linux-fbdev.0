From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 25 Jul 2018 10:56:14 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <6583210.oaMISO8Dcr@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <alpine.LRH.2.02.1807031301290.22443@file01.intranet.prod.int.rdu2.redhat.com>
 <7861c063-6494-7cd8-683d-02c61f9faa1f@tronnes.org>
In-Reply-To: <7861c063-6494-7cd8-683d-02c61f9faa1f@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, Mikulas Patocka <mpatocka@redhat.com>, Dave Airlie <airlied@redhat.com>

On Wednesday, July 04, 2018 05:31:19 PM Noralf Tr=F8nnes wrote:
>=20
> Den 03.07.2018 19.18, skrev Mikulas Patocka:
> >
> > On Tue, 3 Jul 2018, Bartlomiej Zolnierkiewicz wrote:
> >
> >> Hi,
> >>
> >> On Sunday, June 03, 2018 11:46:29 AM Mikulas Patocka wrote:
> >>> I have a USB display adapter using the udlfb driver and I use it on a=
n ARM
> >>> board that doesn't have any graphics card. When I plug the adapter in=
, the
> >>> console is properly displayed, however when I unplug and re-plug the
> >>> adapter, the console is not displayed and I can't access it until I r=
eboot
> >>> the board.
> >>>
> >>> The reason is this:
> >>> When the adapter is unplugged, dlfb_usb_disconnect calls
> >>> unlink_framebuffer, then it waits until the reference count drops to =
zero
> >>> and then it deallocates the framebuffer. However, the console that is
> >>> attached to the framebuffer device keeps the reference count non-zero=
, so
> >>> the framebuffer device is never destroyed. When the USB adapter is pl=
ugged
> >>> again, it creates a new device /dev/fb1 and the console is not attach=
ed to
> >>> it.
> >>>
> >>> This patch fixes the bug by unbinding the console from unlink_framebu=
ffer.
> >>> The code to unbind the console is moved from do_unregister_framebuffe=
r to
> >>> a function unbind_console. When the console is unbound, the reference
> >>> count drops to zero and the udlfb driver frees the framebuffer. When =
the
> >>> adapter is plugged back, a new framebuffer is created and the console=
 is
> >>> attached to it.
> >>>
> >>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >>> Cc: stable@vger.kernel.org
> >> After this change unbind_console() will be called twice in the standard
> >> framebuffer unregister path:
> >>
> >> - first time, directly by do_unregister_framebuffer()
> >>
> >> - second time, indirectly by do_unregister_framebuffer()->unlink_frame=
buffer()
> >>
> >> This doesn't look correctly.
> > unbind_console calls the FB_EVENT_FB_UNBIND notifier, FB_EVENT_FB_UNBIND
> > goes to the function fbcon_fb_unbind and fbcon_fb_unbind checks if the
> > console is bound to the framebuffer for which unbind is requested. So a
> > double call won't cause any trouble.
> >
> >> Also why can't udlfb just use unregister_framebuffer() like all other
> >> drivers (it uses unlink_framebuffer() and it is the only user of this
> >> helper)?
> > It uses unregister_framebuffer() - but - unregister_framebuffer() may o=
nly
> > be called when the open count of the framebuffer is zero.
>=20
> AFAIU calling unregister_framebuffer() with open fd's is just fine as
> long as fb_info with buffers stay intact. All it does is to remove the
> fbX from userspace. Cleanup can be done in fb_ops->fb_destroy.
>=20
> I have been working on generic fbdev emulation for DRM [1] and I did a
> test now to see what would happen if I did unbind the driver from the
> device. It worked as expected if I didn't have another fbdev present,
> but if there is an fb0 and I remove fb1 with a console on it, I would
> sometimes get crashes, often with a call to cursor_timer_handler() in
> the traceback.
>=20
> I think there's index mixup in fbcon_fb_unbind(), at least this change
> seems to solve the immediate problem:
>=20
> diff --git a/drivers/video/fbdev/core/fbcon.c=20
> b/drivers/video/fbdev/core/fbcon.c
> index 5fb156bdcf4e..271b9b988b73 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3066,7 +3072,7 @@ static int fbcon_fb_unbind(int idx)
>          for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
>                  if (con2fb_map[i] !=3D idx &&
>                      con2fb_map[i] !=3D -1) {
> -                       new_idx =3D i;
> +                       new_idx =3D con2fb_map[i];
>                          break;
>                  }
>          }

Looks fine, could you please submit this as a proper patch
(with S-o-b tag and patch description)? Thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

