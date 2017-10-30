From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 30 Oct 2017 09:58:14 +0000
Subject: Re: [Intel-gfx] [PATCH v3 0/7] drm/fbdev: Panel orientation connector property support
Message-Id: <20171030095814.wauslr56gxiusc2f@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
In-Reply-To: <20171023071425.5090-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, intel-gfx <intel-gfx@lists.freedesktop.org>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>

On Mon, Oct 23, 2017 at 09:14:18AM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v3 of my series to add a "panel orientation" property to
> the drm-connector for the LCD panel to let userspace know about LCD
> panels which are not mounted upright, as well as detecting upside-down
> panels without needing quirks (like we do for 90 degree rotated screens).
> 
> As requested by Daniel this version moves the quirks over from the fbdev
> subsys to the drm subsys. I've done this by simpy starting with a copy of
> the quirk table and eventually removing the fbdev version.

I think this design makes much more sense. Some nits I spotted and a few
ideas, but otherwise lgtm.

> The 1st patch in this series is a small fbdev/fbcon patch, patches 2-5
> are all drm patches since patches 2-5 depend on patch 1 I believe it
> would be best to merge patches 1-5 through the drm tree.
> 
> For merging patches 6-7 I see 3 options:
> 
> 1) Wait a kernel cycle, things will work fine without them, they are really
> just there to remove the fbdev copy of the quirks
> 
> 2) Merge all 7 patches through the drm tree

My preference. We can do a topic branch that Bartlomiej pulls into fbdev
so that the patches are in both trees. We need them anyway in both for
testing I'd say.

> 3) Use a stable tag in the drm tree which the fbdev tree can merge and then
> merge patches 6-7 through the drm tree.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
