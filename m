From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 11 Sep 2018 08:47:34 +0000
Subject: Re: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
Message-Id: <20180911084736eucas1p1e7f98eb3bc4e30bdc1041744fc7fc7a6~TTC14JPXa1980019800eucas1p1O@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1@epcas5p3.samsung.com>
 <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
 <20180911074228.GI19774@phenom.ffwll.local>
In-Reply-To: <20180911074228.GI19774@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Kees Cook <keescook@chromium.org>, Thierry Reding <treding@nvidia.com>, David Lechner <david@lechnology.com>, nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>

On 09/11/2018 09:42 AM, Daniel Vetter wrote:
> On Mon, Sep 10, 2018 at 02:48:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> On 08/22/2018 10:54 AM, Daniel Vetter wrote:
>>> This was only added for the drm's fbdev emulation support, so that it
>>> would try harder to show the Oops.
>>>
>>> Unfortunately this never really worked reliably, and in practice ended
>>> up pushing the real Oops off the screen due to plentyfull locking,
>>> sleep-while-atomic and other issues. So we removed all that support
>>> from the fbdev emulation a while back. Aside: We've also removed the
>>> kgdb support, for similar reasons.
>>>
>>> Since it's such a small patch I figured I don't split this up into the
>>> usual 3-phase removal.
>>>
>>> Cc: Ben Skeggs <bskeggs@redhat.com>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Thierry Reding <treding@nvidia.com>
>>> Cc: David Lechner <david@lechnology.com>
>>> Cc: nouveau@lists.freedesktop.org
>>> Cc: linux-fbdev@vger.kernel.org
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>
>> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Ack for merging the entire series through drm-misc-next?

Yes, thanks for taking care of this.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
