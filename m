From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 10 Sep 2018 12:48:43 +0000
Subject: Re: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
Message-Id: <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1@epcas5p3.samsung.com>
 <20180822085405.10787-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: linux-fbdev@vger.kernel.org, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, David Lechner <david@lechnology.com>, Thierry Reding <treding@nvidia.com>, Kees Cook <keescook@chromium.org>


On 08/22/2018 10:54 AM, Daniel Vetter wrote:
> This was only added for the drm's fbdev emulation support, so that it
> would try harder to show the Oops.
> 
> Unfortunately this never really worked reliably, and in practice ended
> up pushing the real Oops off the screen due to plentyfull locking,
> sleep-while-atomic and other issues. So we removed all that support
> from the fbdev emulation a while back. Aside: We've also removed the
> kgdb support, for similar reasons.
> 
> Since it's such a small patch I figured I don't split this up into the
> usual 3-phase removal.
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: David Lechner <david@lechnology.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
