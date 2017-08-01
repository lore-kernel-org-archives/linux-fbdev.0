From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 15:43:24 +0000
Subject: Re: [PATCH] fbdev: Nuke FBINFO_MODULE
Message-Id: <2983645.ftmugOAeCm@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-3-daniel.vetter@ffwll.ch>
 <CAKMK7uEDWYZFZLeCO9==dZk0pg6-bwP1H-hZAibeCsV6Vz+jqA@mail.gmail.com>
 <3012281.mcLmPQijCc@amdc3058>
 <CGME20170801154325epcas1p2af41ab0f0c9040074622b0627a679ba5@epcas1p2.samsung.com>
In-Reply-To: <3012281.mcLmPQijCc@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Thursday, July 13, 2017 04:01:50 PM Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, July 12, 2017 05:07:42 PM Daniel Vetter wrote:
> > On Wed, Jul 12, 2017 at 2:54 PM, Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com> wrote:
> > > On Wednesday, July 12, 2017 02:42:14 PM Daniel Vetter wrote:
> > >> On Wed, Jul 12, 2017 at 12:41:34PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > >> > On Tuesday, July 11, 2017 04:52:19 PM Daniel Vetter wrote:
> > >> > > Instead check info->ops->owner, which amounts to the same.
> > >> > >
> > >> > > Spotted because I want to remove the pile of broken and cargo-culted
> > >> > > fb_info->flags assignments in drm drivers.
> > >> > >
> > >> > > v2: Fixup matrox (reported by kbuild). Also nuke FBINFO_FLAG_* defines
> > >> > > that I've failed to spot.
> > >> > >
> > >> > > v3: Don't nuke FBINFO_FLAG_DEFAULT, that's used all over the place.
> > >> > >
> > >> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > >> > > Cc: linux-fbdev@vger.kernel.org
> > >> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > >> >
> > >> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > >>
> > >> Do you plan to pick these two patches up yourself, or do you expect me to
> > >> merge them?
> > >
> > > Since the original patchset contained DRM changes (two last patches)
> > > depending on fbdev changes (two first patches, the patch being discussed
> > > was the second one) I assumed that you would like to take them all
> > > through DRM tree. If this is not what is preferred, please tell me.
> > 
> > There's no direct depency between 1&2 and 3&4, the only effect of
> > merging them through separate trees is that the bootup logo might not
> > show up when it's expected, until the trees are merged together. We
> > could merge them through separate trees if you prefer that (I forgot
> > to mention that in the cover letter), but I'm fine with putting them
> > all into drm-misc with your ack for 4.14.
> > 
> > Whatever you prefer, I don't mind either way.
> 
> Then I will merge patches 1&2 for v4.14 through fbdev tree (there are
> some other changes pending touching fbdev core and I would like to avoid
> conflicts between fbdev & drm-misc trees). Thanks!

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

