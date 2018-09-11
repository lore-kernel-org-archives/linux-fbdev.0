From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 11 Sep 2018 07:42:28 +0000
Subject: Re: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
Message-Id: <20180911074228.GI19774@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1@epcas5p3.samsung.com>
 <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
In-Reply-To: <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nouveau@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, David Lechner <david@lechnology.com>, Thierry Reding <treding@nvidia.com>, Kees Cook <keescook@chromium.org>

On Mon, Sep 10, 2018 at 02:48:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 08/22/2018 10:54 AM, Daniel Vetter wrote:
> > This was only added for the drm's fbdev emulation support, so that it
> > would try harder to show the Oops.
> > 
> > Unfortunately this never really worked reliably, and in practice ended
> > up pushing the real Oops off the screen due to plentyfull locking,
> > sleep-while-atomic and other issues. So we removed all that support
> > from the fbdev emulation a while back. Aside: We've also removed the
> > kgdb support, for similar reasons.
> > 
> > Since it's such a small patch I figured I don't split this up into the
> > usual 3-phase removal.
> > 
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: David Lechner <david@lechnology.com>
> > Cc: nouveau@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Ack for merging the entire series through drm-misc-next?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
