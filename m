From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Thu, 28 Mar 2013 15:39:43 +0000
Subject: Re: [PATCH] compat/compat-drivers/linux-next: fb skip_vt_switch
Message-Id: <20130328083943.01e61b4b@jbarnes-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364472270-9297-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1364472270-9297-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-fbdev@vger.kernel.org, backports@vger.kernel.org, FlorianSchandinat@gmx.de, daniel.vetter@ffwll.ch, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, rodrigo.vivi@gmail.com, cocci@systeme.lip6.fr

On Thu, 28 Mar 2013 05:04:26 -0700
"Luis R. Rodriguez" <mcgrof@do-not-panic.com> wrote:

> The new commit by Jesse that extended the fb_info with a skip_vt_switch
> element is the simplest example of a data structure expansion. We'd backport
> this by adding a static inline to compat so that new kernels muck with the
> new element and for older kernels this would be a no-op. This reduces the
> size of the backport and unclutters the required patch with #idefs, and
> insteads leaves only a replacement of the usage of the new elements with
> a static inline, this however would still be required on our end:
> 
> 	-      info->skip_vt_switch = true;
> 	+      fb_enable_skip_vt_switch(info);
> 
> So we'd then have to just add this static inline change for each new driver...
> There may be a way to get SmPL to do this for us...

Yeah I'm not attached to the direct structure reference; a couple of
inlines are just as easy to read.  So no argument from me.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
