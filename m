From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 06 Dec 2017 09:11:20 +0000
Subject: Re: [PATCH 0/1] drm: Document that drm_panel_orientation_quirks.c is shared with fbdev
Message-Id: <20171206091120.ylmnicpjjle3jsd4@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171205110035.7537-1-hdegoede@redhat.com>
In-Reply-To: <20171205110035.7537-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>

On Tue, Dec 05, 2017 at 12:00:34PM +0100, Hans de Goede wrote:
> Hi All,
> 
> This is a resend from my gmail mail address so that patchwork and the CI
> pick this up.

If you mean the intel CI farm, then you need to cc: intel-gfx.
Unfortunately our CI does not (yet) watch what's going on on dri-devel,
moslty because we're still dealing with too much noise and random issues.
And we don't want to inflict that noise on the overall drm community.

We are working on some small early steps, like at least compile testing
and running sparse and stuff on every patch, using our CI. Just as a first
step, to start the discussion of how to integrate all this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
