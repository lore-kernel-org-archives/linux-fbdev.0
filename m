From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 28 Nov 2019 10:11:16 +0000
Subject: Re: [PATCH 13/13] samples: vfio-mdev: constify fb ops
Message-Id: <20191128101116.GQ406127@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <fc8342eef9fcd2f55c86fcd78f7df52f7c76fa87.1574871797.git.jani.nikula@intel.com>
 <20191127182940.GM406127@phenom.ffwll.local>
 <87d0dcnynk.fsf@intel.com>
In-Reply-To: <87d0dcnynk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

On Thu, Nov 28, 2019 at 11:22:23AM +0200, Jani Nikula wrote:
> On Wed, 27 Nov 2019, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Nov 27, 2019 at 06:32:09PM +0200, Jani Nikula wrote:
> >> Now that the fbops member of struct fb_info is const, we can star making
> >> the ops const as well.
> >> 
> >> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> >> Cc: kvm@vger.kernel.org
> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >
> > You've missed at least drivers/staging/fbtft in your search. I guess you
> > need to do a full make allyesconfig on x86/arm and arm64 (the latter
> > because some stupid drivers only compile there, not on arm, don't ask).
> > Still misses a pile of mips/ppc only stuff and maybe the sparcs and
> > alphas, but should be good enough.
> 
> fbtft dynamically allocates the fbops, for whatever reason. There were
> others like that too. Some of the drivers modify the fbops runtime to
> choose different hooks for different configurations. Can't change them
> all anyway.
> 
> Facilitating making the fbops const is one thing (patches 1-8), but I'm
> not really sure I want to sign up for exhaustively moving fbops to
> rodata on anything beyond drivers/gpu/drm. It's not like I leave stuff
> broken. Besides I am trying to cover all the low hanging fruit where I
> can simply add the "const" and be done with it.

Uh indeed, I didn't check the output of my grep with sufficient finesses.
r-b as-is on that pile.

Since fbdev is officially in drm-misc you can just merge it all once the
prep is done - feels silly not to when you've done the work already.
-Daniel

> 
> BR,
> Jani.
> 
> >
> > With that done, on the remaining patches:
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> >> ---
> >>  samples/vfio-mdev/mdpy-fb.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
> >> index 2719bb259653..21dbf63d6e41 100644
> >> --- a/samples/vfio-mdev/mdpy-fb.c
> >> +++ b/samples/vfio-mdev/mdpy-fb.c
> >> @@ -86,7 +86,7 @@ static void mdpy_fb_destroy(struct fb_info *info)
> >>  		iounmap(info->screen_base);
> >>  }
> >>  
> >> -static struct fb_ops mdpy_fb_ops = {
> >> +static const struct fb_ops mdpy_fb_ops = {
> >>  	.owner		= THIS_MODULE,
> >>  	.fb_destroy	= mdpy_fb_destroy,
> >>  	.fb_setcolreg	= mdpy_fb_setcolreg,
> >> -- 
> >> 2.20.1
> >> 
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
