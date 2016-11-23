From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 23 Nov 2016 08:45:55 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <CAKMK7uGv11kk08myiSmt0-R3zMZrWcYo3-o9Pnj0JAFDxVuG3g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123081932.byoasvcl322hrlin@phenom.ffwll.local>
 <CAMuHMdVdPOGQx+kKDvVmKCqws+NjngMv6kE5h-ojx4eCSUY5Fw@mail.gmail.com>
In-Reply-To: <CAMuHMdVdPOGQx+kKDvVmKCqws+NjngMv6kE5h-ojx4eCSUY5Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Wed, Nov 23, 2016 at 9:25 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Daniel,
>
> On Wed, Nov 23, 2016 at 9:19 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Wed, Nov 23, 2016 at 10:03:10AM +0200, Tomi Valkeinen wrote:
>>> Since the fbdev framework is in maintenance mode and all new display drivers
>>> should be made with the DRM framework, remove the fbdev drivers from staging.
>>>
>>> Note: the patches are created with git format-patch -D, so they can't be
>>> applied. Only for review.
>>
>> +1 from my side. Now that we have the simple pipe helpers in drm-kms, and
>> a few drivers starting to use them, there's really no reasons left anymore
>> to have fbdev drivers.
>
> I haven't been following this that closely, so can you please point me to a
> sample DRM driver using this simple pipe helper?

Bummer, they still haven't landed. But afaik there's at least 4 of
them floating around in various places ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
