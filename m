From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 20 Apr 2016 21:22:52 +0000
Subject: Re: [PATCH 8/8] drm/udl: Use drm_fb_helper deferred_io support
Message-Id: <CAKMK7uGR_rC9K2TxRVJ_3_EMNZHD_WDbShXDsTrMX6kA7euj3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-9-git-send-email-noralf@tronnes.org>
 <20160420175903.GS2510@phenom.ffwll.local>
 <5717D679.5070809@tronnes.org>
In-Reply-To: <5717D679.5070809@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 20, 2016 at 9:20 PM, Noralf Tr=C3=B8nnes <noralf@tronnes.org> w=
rote:
>>> @@ -330,20 +203,20 @@ static int udl_fb_open(struct fb_info *info, int
>>> user)
>>>         ufbdev->fb_count++;
>>>   -     if (fb_defio && (info->fbdefio =3D NULL)) {
>>> -               /* enable defio at last moment if not disabled by client
>>> */
>>> +       if (!info->fbdefio) {
>>> +               /* enable defio at last moment */
>>>                 struct fb_deferred_io *fbdefio;
>>>                 fbdefio =3D kmalloc(sizeof(struct fb_deferred_io),
>>> GFP_KERNEL);
>>> -
>>>                 if (fbdefio) {
>>>                         fbdefio->delay =3D DL_DEFIO_WRITE_DELAY;
>>> -                       fbdefio->deferred_io =3D udlfb_dpy_deferred_io;
>>> +                       fbdefio->deferred_io =3D drm_fb_helper_deferred=
_io;
>>
>> Why all these changes here? I figured just exchanging the deferred_io
>> pointer should be all that's really needed in the setup code?
>
>
> Because we always need to initialize deferred_io since we use it's worker
> to handle fb_{fillrect,copyarea,imageblit} damage in drm_fb_helper.
>
> The previous code didn't use deferred_io to handle these, it just handled
> the damage directly unless it was running in atomic context, in which case
> it just recorded the damage and returned, leaving it to the next call to
> push the changes.

That kind of explanation needs to be added to the commit message. I
completely missed that udl doesn't have an async work item for defio
from atomic.

> And in the following code I fixed a null pointer problem as well, maybe I
> shouldn't have packed it in here. If fbdefio allocation fails =3D NULL,
> fb_deferred_io_init() will trigger a BUG().

Yeah, better to split that out into a separate bugfix I think.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
