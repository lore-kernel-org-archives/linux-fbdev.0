From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 22 Apr 2016 17:36:03 +0000
Subject: Re: [PATCH 4/8] drm/fb-helper: Add fb_deferred_io support
Message-Id: <CAKMK7uFP7GBVXAjSvxeTqypE4gOcsE69Asj2n6bPqGN=N2aX1A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-5-git-send-email-noralf@tronnes.org>
 <571921F5.2080007@tronnes.org>
 <20160422082719.GH2510@phenom.ffwll.local>
 <571A326A.9070407@tronnes.org>
 <20160422170501.GE2510@phenom.ffwll.local>
 <571A5F31.8050301@tronnes.org>
In-Reply-To: <571A5F31.8050301@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Apr 22, 2016 at 7:28 PM, Noralf Tr=C3=B8nnes <noralf@tronnes.org> w=
rote:
> This patch extend the use of the fbdev deferred_io worker to also handle
> the fbdev drawing operations, which can happen in atomic context.
> The qxl driver adds an extra worker (struct qxl_device).fb_work which is
> used to flush the framebuffer. Both the mmap deferred_io (qxl_deferred_io=
())
> code which is run by the deferred io worker and the fbdev drawing operati=
ons
> (qxl_fb_fillrect() etc.) schedule this fb_work worker.
>
> So this patch uses 1 worker, qxl uses 2 workers.

Oh, I didn't realize that you're reusing the same worker for both
things. 2 workers indeed make sense, since the mmap one must have a
built-in delay (to coalesce a bunch of writes), whereas the other one
probably should be run right away, after each op.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
