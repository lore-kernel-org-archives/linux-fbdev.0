From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Jan 2020 05:53:48 +0000
Subject: Re: [PATCH] fbdev: wait for references go away
Message-Id: <20200121055348.s4anrveo2z6avin6@sirius.home.kraxel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
 <20200120100014.23488-1-kraxel@redhat.com>
 <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
In-Reply-To: <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, marmarek@invisiblethingslab.com, dri-devel@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>

  Hi,

> > open.  Which can result in drm driver not being able to grab resources
> > (and fail initialization) because the firmware framebuffer still holds
> > them.  Reportedly plymouth can trigger this.
> 
> Could you please describe issue some more?
> 
> I guess that a problem is happening during DRM driver load while fbdev
> driver is loaded? I assume do_unregister_framebuffer() is called inside
> do_remove_conflicting_framebuffers()?

Yes.  Specifically bochs-drm.ko and efifb in virtual machines.

> At first glance it seems to be an user-space issue as it should not be
> holding references on /dev/fb0 while DRM driver is being loaded.

Well, the drm driver is loaded by udev like everything else.

Dunno what plymouth (graphical boot screen tool) does to handle the
situation.  I guess listening to udev events.  So it should notice efifb
going away and drop the /dev/fb0 reference, but this races against
bochs-drm initializing.

> > Fix this by trying to wait until all references are gone.  Don't wait
> > forever though given that userspace might keep the file handle open.
> 
> Where does the 1s maximum delay come from?

Pulled out something out of thin air which I expect being on the safe
side.  plymouth responding on the udev event should need only a small
fraction of that.

cheers,
  Gerd
