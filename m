From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 12 Jul 2017 12:42:14 +0000
Subject: Re: [PATCH] fbdev: Nuke FBINFO_MODULE
Message-Id: <20170712124214.t2i2ldlrwc5gf5aw@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-3-daniel.vetter@ffwll.ch>
 <CGME20170711145229epcas3p169b5dd002290cfb76c539d05733c971a@epcas3p1.samsung.com>
 <20170711145219.22410-1-daniel.vetter@ffwll.ch>
 <1903695.PIoOfWhuj9@amdc3058>
In-Reply-To: <1903695.PIoOfWhuj9@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>

On Wed, Jul 12, 2017 at 12:41:34PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday, July 11, 2017 04:52:19 PM Daniel Vetter wrote:
> > Instead check info->ops->owner, which amounts to the same.
> > 
> > Spotted because I want to remove the pile of broken and cargo-culted
> > fb_info->flags assignments in drm drivers.
> > 
> > v2: Fixup matrox (reported by kbuild). Also nuke FBINFO_FLAG_* defines
> > that I've failed to spot.
> > 
> > v3: Don't nuke FBINFO_FLAG_DEFAULT, that's used all over the place.
> > 
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Do you plan to pick these two patches up yourself, or do you expect me to
merge them?

I'm always confused when the official maintainer acks something without
saying anything else ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
