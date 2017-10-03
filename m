From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 03 Oct 2017 09:24:39 +0000
Subject: Re: [PATCH] MAINTAINERS: Add dri-devel as a mailing list for anything fbdev
Message-Id: <20171003092439.st4c6ook5xbzefkh@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170908153528.17528-1-daniel.vetter@ffwll.ch>
 <CAOw6vbJs7OmZLRhhYXjO1ruSutO7U5E71ZF=WpYa+WhG+D629Q@mail.gmail.com>
 <20171002082926.di5qyio7egwfimxc@phenom.ffwll.local>
In-Reply-To: <20171002082926.di5qyio7egwfimxc@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sean Paul <seanpaul@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>

On Mon, Oct 02, 2017 at 10:29:26AM +0200, Daniel Vetter wrote:
> On Fri, Sep 08, 2017 at 11:39:44AM -0400, Sean Paul wrote:
> > On Fri, Sep 8, 2017 at 11:35 AM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > > fbdev is in maintenance only, except that it's still used by drm
> > > through the drm fbdev emulation, to be able to use fbcon. And people
> > > might want to sometimes extend fbcon to enable new features for drm
> > > drivers, e.g. Hans' panel orientation work.
> > >
> > > The problem is that when those patches only touch fbdev code they'll
> > > never show up on drm developer's radar, which means we end up with
> > > designs that don't really fit whell into the full stack. That happened
> > > a bit with the panel orientation work, where an fbcon patch made it
> > > into 4.14, implementing a design that won't really work on the drm
> > > side. Which means we now have to redo things, and on top coordinate 2
> > > subsystem trees.
> > >
> > > Since fbdev is super low-volume we can prevent this in the future by
> > > simply adding the dri-devel mailing list to the fbdev subsystem.
> > >
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: linux-fbdev@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: Sean Paul <seanpaul@chromium.org>
> > 
> > Acked-by: Sean Paul <seanpaul@chromium.org>
> 
> Bartlomiej, ack from you too?

Dave Airlie acked it on irc, so pushed to drm-misc-next.
-Daniel
> 
> Thanks, Daniel
> > 
> > > Cc: David Airlie <airlied@linux.ie>
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ba51d0906955..af9766a32949 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -5391,6 +5391,7 @@ F:        drivers/net/wan/sdla.c
> > >
> > >  FRAMEBUFFER LAYER
> > >  M:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > +L:     dri-devel@lists.freedesktop.org
> > >  L:     linux-fbdev@vger.kernel.org
> > >  T:     git git://github.com/bzolnier/linux.git
> > >  Q:     http://patchwork.kernel.org/project/linux-fbdev/list/
> > > --
> > > 2.14.1
> > >
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
