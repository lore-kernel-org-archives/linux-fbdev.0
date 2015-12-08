From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 08 Dec 2015 08:19:16 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <20151208081916.GA20822@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
 <5665C2BA.3010304@ti.com>
In-Reply-To: <5665C2BA.3010304@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Mon, Dec 07, 2015 at 07:32:42PM +0200, Tomi Valkeinen wrote:
> 
> On 25/08/15 16:45, Daniel Vetter wrote:
> > When the usual fbcon legacy options are enabled we have
> > ->register_framebuffer
> >   ->fb notifier chain calls into fbcon
> >     ->fbcon sets up console on new fbi
> >       ->fbi->set_par
> >         ->drm_fb_helper_set_par exercises full kms api
> > 
> > And because of locking inversion hilarity all of register_framebuffer
> > is done with the console lock held. Which means that the first time on
> > driver load we exercise _all_ the kms code (all probe paths and
> > modeset paths for everything connected) is under the console lock.
> > That means if anything goes belly-up in that big pile of code nothing
> > ever reaches logfiles (and the machine is dead).
> > 
> > Usual tactic to debug that is to temporarily remove those console_lock
> > calls to be able to capture backtraces. I'm fed up writing this patch
> > and recompiling kernels. Hence this patch here to add an unsafe,
> > kernel-taining option to do this at runtime.
> 
> I think this was never merged. This was part 4 of 4, were there
> dependencies or...? Should I apply this for 4.5?

Patches 1-3 have all already landed in drm, and patch 4 is free standing.
Would be great if you can pull it in.
 
> But then... I think my issues with console lock have been later at
> runtime, not at register. Maybe we need a module option to disable the
> console lock altogether. I wonder how much havoc that might create, though.

Hm, where in fbdev do you hold the console_lock outside of
registering/unregistering an fbdev (because of fbcon)? There's of course
general trouble with console_lock deadlocks and fun like that, but ime
that all got a lot more manageable since I added lockdep annotations to
console_lock.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
