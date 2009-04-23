From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Linux-fbdev-devel] fbcmap: non working tests on unsigned
 cmap->start
Date: Thu, 23 Apr 2009 14:56:52 -0700
Message-ID: <20090423145652.cce2d0f0.akpm@linux-foundation.org>
References: <49EDD799.8060607@gmail.com>
	<20090423134110.51ea8df2.akpm@linux-foundation.org>
	<20090423214738.GF7134@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932155AbZDWWAs@vger.kernel.org>
In-Reply-To: <20090423214738.GF7134@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: roel.kluin@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Fri, 24 Apr 2009 00:47:38 +0300
Ville Syrj__l__ <syrjala@sci.fi> wrote:

> On Thu, Apr 23, 2009 at 01:41:10PM -0700, Andrew Morton wrote:
> > On Tue, 21 Apr 2009 16:26:33 +0200
> > Roel Kluin <roel.kluin@gmail.com> wrote:
> > 
> > > vi include/linux/fb.h +478
> > > 
> > > Note that struct fb_cmap_user cmap->start in fb_set_user_cmap() is unsigned.
> > > Should there maybe be a test:
> > > 
> > > if (cmap->start > MAX || ...)
> > > 
> > > (and what should MAX be then?)
> > > 
> > > Otherwise you may want to apply the cleanup patch below
> > > 
> > > Roel
> > > ------------------------------>8-------------8<---------------------------------
> > > Remove redundant tests on unsigned
> > > 
> > > Signed-off-by: Roel Kluin <roel.kluin@gmail.com> 
> > > ---
> > > diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> > > index f53b9f1..958bf4e 100644
> > > --- a/drivers/video/fbcmap.c
> > > +++ b/drivers/video/fbcmap.c
> > > @@ -266,8 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
> > >  		rc = -ENODEV;
> > >  		goto out;
> > >  	}
> > > -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
> > > -				!info->fbops->fb_setcmap)) {
> > > +	if (!info->fbops->fb_setcolreg && !info->fbops->fb_setcmap) {
> > >  		rc = -EINVAL;
> > >  		goto out1;
> > >  	}
> > 
> > argh.
> > 
> > - Perhaps userspace can kill the kernel by sending a "negative"
> >   `start'.  Removing the test will make it even less likely that we'll
> >   fix this bug.
> 
> Shouldn't happen. 'start' is used as the starting index for the hardware
> palette, 'start+len-1' is the last index. All drivers should already check
> the passed values since the maximum index depends on the display mode.
> And I suppose the worst thing that could happen if the driver fails to
> check the values would be incorrect colors.

OK.

I wonder if all drivers _do_ check.  It probably doesn't matter much, as
it's a privileged operation (I assume?)

> > - If this bug doesn't exist, and there _is_ userspace which is
> >   legitimately sending in "negative" values of `start' (unlikely?) then
> >   we will break userspace if we fix this comparison.
> 
> The comparison will always be false since 'start' is unsigned so how
> would anything break?

By "fix this comparison" I meant converting it to

	if ((signed)cmap->start < 0)
