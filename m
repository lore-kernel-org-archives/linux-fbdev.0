From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 12 Jul 2017 10:41:34 +0000
Subject: Re: [PATCH] fbdev: Nuke FBINFO_MODULE
Message-Id: <1903695.PIoOfWhuj9@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-3-daniel.vetter@ffwll.ch>
 <CGME20170711145229epcas3p169b5dd002290cfb76c539d05733c971a@epcas3p1.samsung.com>
 <20170711145219.22410-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20170711145219.22410-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>

On Tuesday, July 11, 2017 04:52:19 PM Daniel Vetter wrote:
> Instead check info->ops->owner, which amounts to the same.
> 
> Spotted because I want to remove the pile of broken and cargo-culted
> fb_info->flags assignments in drm drivers.
> 
> v2: Fixup matrox (reported by kbuild). Also nuke FBINFO_FLAG_* defines
> that I've failed to spot.
> 
> v3: Don't nuke FBINFO_FLAG_DEFAULT, that's used all over the place.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

