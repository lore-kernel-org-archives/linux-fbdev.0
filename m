From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 12 Jul 2017 12:54:11 +0000
Subject: Re: [PATCH] fbdev: Nuke FBINFO_MODULE
Message-Id: <1734271.ijK3T0ECI9@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-3-daniel.vetter@ffwll.ch>
 <1903695.PIoOfWhuj9@amdc3058>
 <20170712124214.t2i2ldlrwc5gf5aw@phenom.ffwll.local>
 <CGME20170712125413epcas5p31b162be09cc3f0a27f84ad14b2938921@epcas5p3.samsung.com>
In-Reply-To: <20170712124214.t2i2ldlrwc5gf5aw@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>

On Wednesday, July 12, 2017 02:42:14 PM Daniel Vetter wrote:
> On Wed, Jul 12, 2017 at 12:41:34PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday, July 11, 2017 04:52:19 PM Daniel Vetter wrote:
> > > Instead check info->ops->owner, which amounts to the same.
> > > 
> > > Spotted because I want to remove the pile of broken and cargo-culted
> > > fb_info->flags assignments in drm drivers.
> > > 
> > > v2: Fixup matrox (reported by kbuild). Also nuke FBINFO_FLAG_* defines
> > > that I've failed to spot.
> > > 
> > > v3: Don't nuke FBINFO_FLAG_DEFAULT, that's used all over the place.
> > > 
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: linux-fbdev@vger.kernel.org
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > 
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Do you plan to pick these two patches up yourself, or do you expect me to
> merge them?

Since the original patchset contained DRM changes (two last patches)
depending on fbdev changes (two first patches, the patch being discussed
was the second one) I assumed that you would like to take them all
through DRM tree. If this is not what is preferred, please tell me.

> I'm always confused when the official maintainer acks something without
> saying anything else ...

Point taken, I will try to be more verbose next time.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

