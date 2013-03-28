From: Julia Lawall <julia.lawall@lip6.fr>
Date: Thu, 28 Mar 2013 16:19:59 +0000
Subject: Re: [PATCH] compat/compat-drivers/linux-next: fb skip_vt_switch
Message-Id: <alpine.DEB.2.02.1303281718490.1928@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364472270-9297-1-git-send-email-mcgrof@do-not-panic.com> <20130328083943.01e61b4b@jbarnes-desktop>
In-Reply-To: <20130328083943.01e61b4b@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, backports@vger.kernel.org, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, rodrigo.vivi@gmail.com, daniel.vetter@ffwll.ch, rafael.j.wysocki@intel.com

On Thu, 28 Mar 2013, Jesse Barnes wrote:

> On Thu, 28 Mar 2013 05:04:26 -0700
> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> wrote:
>
> > The new commit by Jesse that extended the fb_info with a skip_vt_switch
> > element is the simplest example of a data structure expansion. We'd backport
> > this by adding a static inline to compat so that new kernels muck with the
> > new element and for older kernels this would be a no-op. This reduces the
> > size of the backport and unclutters the required patch with #idefs, and
> > insteads leaves only a replacement of the usage of the new elements with
> > a static inline, this however would still be required on our end:
> >
> > 	-      info->skip_vt_switch = true;
> > 	+      fb_enable_skip_vt_switch(info);
> >
> > So we'd then have to just add this static inline change for each new driver...
> > There may be a way to get SmPL to do this for us...

@@
type of info  *info;
@@

-      info->skip_vt_switch = true;
+      fb_enable_skip_vt_switch(info);

for whatever the type of info is.

Then I guess there would be a similar rule for the false case?

julia


>
> Yeah I'm not attached to the direct structure reference; a couple of
> inlines are just as easy to read.  So no argument from me.
>
> Thanks,
> --
> Jesse Barnes, Intel Open Source Technology Center
>
