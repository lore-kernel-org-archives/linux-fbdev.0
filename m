From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 02 Apr 2019 20:43:25 +0000
Subject: Re: [PATCH] fbdev: list all pci memory bars as conflicting apertures
Message-Id: <20190402204325.cqu7fobzekd3ccls@sirius.home.kraxel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6@epcas2p2.samsung.com>
 <20190314114500.8336-1-kraxel@redhat.com>
 <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
 <CAKMK7uEs+OaoiEmd9Dp6K_v5Pz4pf197DP8KFkvhNMYXv9tYxA@mail.gmail.com>
In-Reply-To: <CAKMK7uEs+OaoiEmd9Dp6K_v5Pz4pf197DP8KFkvhNMYXv9tYxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Tue, Apr 02, 2019 at 02:09:45PM +0200, Daniel Vetter wrote:
> On Mon, Apr 1, 2019 at 4:00 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> >
> > On 03/14/2019 12:45 PM, Gerd Hoffmann wrote:
> > > Simply add all pci memory bars to struct apertures_struct in
> > > remove_conflicting_pci_framebuffers(), without depending on the
> > > res_id parameter.
> > >
> > > The plan is to drop the res_id parameter later on.  For now keep the
> > > parameter, use it for sanity-checking and warn on inconsistencies.
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Patch queued for v5.2, thanks.
> 
> Might be good to also stuff this into drm (double merge or topic
> branch, whatever you prefer), since that's where all the users are.
> Gerd also has some follow-up patches to apply on top of this one iirc.

No follow-up patches yet.  Plan is to wait a bit, see if the
sanity-checks trigger, and if all goes well go drop the res_id
parameter in 5.3 ...

cheers,
  Gerd
