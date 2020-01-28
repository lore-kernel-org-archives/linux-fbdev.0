From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 28 Jan 2020 16:44:03 +0000
Subject: Re: [PATCH] fbdev: wait for references go away
Message-Id: <CAKMK7uFgGQdd1V3-ux6dGhUXFNvsFJvCiA8eNW9RK=nNdsK3OA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200120100014.23488-1-kraxel@redhat.com>
 <CAKMK7uGMTLoyMnfLmx3r9+qf6sMXcrKT_EgO78f=Gw0Oi51kWQ@mail.gmail.com>
In-Reply-To: <CAKMK7uGMTLoyMnfLmx3r9+qf6sMXcrKT_EgO78f=Gw0Oi51kWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: marmarek@invisiblethingslab.com, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Tue, Jan 28, 2020 at 5:39 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Jan 20, 2020 at 11:00 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Problem: do_unregister_framebuffer() might return before the device is
> > fully cleaned up, due to userspace having a file handle for /dev/fb0
> > open.  Which can result in drm driver not being able to grab resources
> > (and fail initialization) because the firmware framebuffer still holds
> > them.  Reportedly plymouth can trigger this.
> >
> > Fix this by trying to wait until all references are gone.  Don't wait
> > forever though given that userspace might keep the file handle open.
> >
> > Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> (Missed this because lca, so a bit late)
>
> This isn't really how driver unload is supposed to happen. Instead:
>
> - Driver unload starts
> - Driver calls the foo_unregister function, which stops new userspace
> from getting at the driver. If you're subsystem is good (i.e. drm
> since Noralf fixed it) this will also sufficiently synchronize with
> any pending ioctl.
> - Important: This does _not_ wait until userspace closes all
> references. You can't force that.
> - Driver releases all hw structures and mappings and everything else.
> With fbdev this is currently not fully race free because no one is
> synchronizing with userspace everywhere correctly.
>
> ... much time can pass ...
>
> - Userspace releases the last references, which triggers the final
> destroy stuff and which releases the memory occupied by various
> structures still (but not anything releated to hw or anything else
> really).
>
> So there's two bits:
>
> 1. Synchronizing with pending ioctls. This is mostly there already
> with lock_fb_info/unlock_fb_info. From a quick look the missing bit
> seems to be that the unregister code is not taking that lock, and so
> not sufficiently synchronizing against concurrent ioctl calls and
> other stuff. Plus would need to audit all entry points.

Correction: The check here is file_fb_info(), which checks for
unregister. Except it's totally racy and misses the end marker (unlike
drm_dev_enter/exit in drm). So bunch of work to do here too. The
lock_fb_info is purely locking, not lifetime (and I think in a bunch
of places way too late).

> 1a. fbcon works differently. Don't look too closely, but this is also
> not the problem your facing here.
>
> 2. Refcounting of the fb structure and hw teardown. That's what's
> tracked in fb_info->count. Most likely the fbdev driver you have has a
> wrong split between the hw teardown code and what's in fb_destroy. If
> you have any hw cleanup code in fb_destroy that driver is buggy. efifb
> is very buggy in that area :-) Same for offb, simplefb, vesafb and
> vesa16fb.
>
> We might need a new fb_unregister callback for these drivers to be
> able to fix this properly. Because the unregister comes from the fbdev
> core, and not the driver as usual, so the usual driver unload sequence
> doesnt work:
>
> drm_dev_unregister();
> ... release all hw resource ...
>
> drm_dev_put();
>
> Or in terms of fbdev:
>
> unregister_framebuffer(info);
> ... release all hw resources ... <- everyone gets this wrong
> framebuffer_release(info); <- also wrong because not refcounted,
> hooray, this should be moved to to end of the ->fb_destroy callback
>
> So we need a callback to put the "release all hw resources" step into
> the flow at the right place. Another option (slightly less midlayer)
> would be to add a fb_takeover hook, for these platforms drivers, which
> would then do the above sequence (like at driver unload).
>
> Also adding Noralf, since he's fixed up all the drm stuff in this area
> in the past.
>
> Cheers, Daniel
>
> > ---
> >  drivers/video/fbdev/core/fbmem.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/cor=
e/fbmem.c
> > index d04554959ea7..2ea8ac05b065 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/fbcon.h>
> >  #include <linux/mem_encrypt.h>
> >  #include <linux/pci.h>
> > +#include <linux/delay.h>
> >
> >  #include <asm/fb.h>
> >
> > @@ -1707,6 +1708,8 @@ static void unlink_framebuffer(struct fb_info *fb=
_info)
> >
> >  static void do_unregister_framebuffer(struct fb_info *fb_info)
> >  {
> > +       int limit =3D 100;
> > +
> >         unlink_framebuffer(fb_info);
> >         if (fb_info->pixmap.addr &&
> >             (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
> > @@ -1726,6 +1729,10 @@ static void do_unregister_framebuffer(struct fb_=
info *fb_info)
> >         fbcon_fb_unregistered(fb_info);
> >         console_unlock();
> >
> > +       /* try wait until all references are gone */
> > +       while (atomic_read(&fb_info->count) > 1 && --limit > 0)
> > +               msleep(10);
> > +
> >         /* this may free fb info */
> >         put_fb_info(fb_info);
> >  }
> > --
> > 2.18.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
