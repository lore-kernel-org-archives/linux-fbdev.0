From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 01 Sep 2015 15:31:17 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <20150901153117.GT1367@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
 <CAF6AEGu54g+5Q0ZQXeMd7HLHkGWPw+sdo-FZ4qVS=9nB6nLwtw@mail.gmail.com>
 <55E57ED1.5060109@ti.com>
 <CAF6AEGtV1-tgvA0D-BFZ8NMNyNN7C8-jst5xXBKrQHGFVWCpyA@mail.gmail.com>
 <55E5B92C.7000202@ti.com>
 <CAF6AEGva6hg9Nkn7kk8msB3WXOAVNB4C+akh-u-QHkZU9sT6zQ@mail.gmail.com>
In-Reply-To: <CAF6AEGva6hg9Nkn7kk8msB3WXOAVNB4C+akh-u-QHkZU9sT6zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Tue, Sep 01, 2015 at 11:12:11AM -0400, Rob Clark wrote:
> On Tue, Sep 1, 2015 at 10:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> >
> > On 01/09/15 17:34, Rob Clark wrote:
> >> On Tue, Sep 1, 2015 at 6:32 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >>>
> >>>
> >>> On 25/08/15 22:24, Rob Clark wrote:
> >>>> On Tue, Aug 25, 2015 at 9:45 AM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >>>>> When the usual fbcon legacy options are enabled we have
> >>>>> ->register_framebuffer
> >>>>>   ->fb notifier chain calls into fbcon
> >>>>>     ->fbcon sets up console on new fbi
> >>>>>       ->fbi->set_par
> >>>>>         ->drm_fb_helper_set_par exercises full kms api
> >>>>>
> >>>>> And because of locking inversion hilarity all of register_framebuffer
> >>>>> is done with the console lock held. Which means that the first time on
> >>>>> driver load we exercise _all_ the kms code (all probe paths and
> >>>>> modeset paths for everything connected) is under the console lock.
> >>>>> That means if anything goes belly-up in that big pile of code nothing
> >>>>> ever reaches logfiles (and the machine is dead).
> >>>>>
> >>>>> Usual tactic to debug that is to temporarily remove those console_lock
> >>>>> calls to be able to capture backtraces. I'm fed up writing this patch
> >>>>> and recompiling kernels. Hence this patch here to add an unsafe,
> >>>>> kernel-taining option to do this at runtime.
> >>>>>
> >>>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> >>>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>>>> Cc: linux-fbdev@vger.kernel.org
> >>>>> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >>>>
> >>>> This one was causing me some problems, if I tried to enable
> >>>> lockless_register_fb.  It *looks* like it should work, so I'm not
> >>>> quite sure what the deal is.  But I'm 110% fan of getting something
> >>>> like this working, because console_lock is pretty much the bane of kms
> >>>> developer's existence..
> >>>>
> >>>> I'll have to debug further on a system where I can see more than the
> >>>> bottom three lines of the second to last backtrace..
> >>>
> >>> Any idea if anyone has ever looked at properly fixing this?
> >>
> >> I hadn't had a chance to look at it further yet..  I think Daniel
> >> claimed it worked for him, but he was probably on intel-next, where I
> >> was on drm-next at the time which seemed to be having some unrelated
> >> i915 issues (when I was trying to debug atomic fb-helper patches).  So
> >> can't really say that the issue I had was actually related to this
> >> patch.  I'll try again later this week or next, when hopefully i915 in
> >> drm-next is in better shape..
> >
> > Oh, I didn't mean this patch, but the whole console lock in general.
> > I've also banged my head to a wall because of it =).
> 
> oh, not sure.. every time I've started looking closer at
> console/console_lock I run away screaming..  I guess if it were
> possible to push the lock down further so only drivers that needed the
> lock (presumably serial/net/etc) could take it, that would be nice..
> but not sure I am that brave..

console_lock is pretty much unfixable without rewriting half of fbdev.
Which I don't expect to ever happen. For the curious look at all the
commits changing locking in fbdev over the past few years.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
