From: David Ung <davidu@nvidia.com>
Date: Fri, 05 Dec 2014 03:54:04 +0000
Subject: RE: [PATCH 1/3] video: fbdev: Add additional vesa modes
Message-Id: <befb70e4c54242a183730df208597c3b@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-1-git-send-email-davidu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> On 03/12/14 23:49, David Ung wrote:
> > Add high resolution modes to vesa_modes struct.
> >
> > Signed-off-by: David Ung <davidu@nvidia.com>
> > ---
> >  drivers/video/fbdev/core/modedb.c | 27 +++++++++++++++++++++++++++
> >  include/linux/fb.h                |  2 +-
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/core/modedb.c
> > b/drivers/video/fbdev/core/modedb.c
> > index 388f797..0b57c1df 100644
> > --- a/drivers/video/fbdev/core/modedb.c
> > +++ b/drivers/video/fbdev/core/modedb.c
> > @@ -468,6 +468,33 @@ const struct fb_videomode vesa_modes[] = {
> >  	/* 33 1920x1440-75 VESA */
> >  	{ NULL, 75, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
> >  	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 34 1920x1200-60 RB VESA */
> > +	{ NULL, 60, 1920, 1200, 6493, 80, 48, 26, 3, 32, 6,
> > +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 35 1920x1200-60 VESA */
> > +	{ NULL, 60, 1920, 1200, 5174, 336, 136, 36, 3, 200, 6,
> > +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 36 1920x1200-75 VESA */
> > +	{ NULL, 75, 1920, 1200, 4077, 344, 136, 46, 3, 208, 6,
> > +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 37 1920x1200-85 VESA */
> > +	{ NULL, 85, 1920, 1200, 3555, 352, 144, 53, 3, 208, 6,
> > +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 38 2560x1600-60 RB VESA */
> > +	{ NULL, 60, 2560, 1600, 3724, 80, 48, 37, 3, 32, 6,
> > +	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 39 2560x1600-60 VESA */
> > +	{ NULL, 60, 2560, 1600, 2869, 472, 192, 49, 3, 280, 6,
> > +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 40 2560x1600-75 VESA */
> > +	{ NULL, 75, 2560, 1600, 2256, 488, 208, 63, 3, 280, 6,
> > +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 41 2560x1600-85 VESA */
> > +	{ NULL, 85, 2560, 1600, 1979, 488, 208, 73, 3, 280, 6,
> > +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > +	/* 42 2560x1600-120 RB VESA */
> > +	{ NULL, 120, 2560, 1600, 1809, 80, 48, 85, 3, 32, 6,
> > +	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> 
> Where did you take these timings? Are the modes in vesa_modes[] in some
> defined order, or just in the order they have been added?

From the DMT doc.  In the doc, the VESA modes are ordered by the DMT ids per page.
Each DMT mode is a valid vesa_mode.   vesa_modes are just a collection of modes
people had added over time.  There are quite a few modes that's missing from 
vesa_modes list.   Ideally the number of vesa_modes should match the number of
DMT ids.  If we wish to change the ordering, then some of the other drivers which
hardcodes the an index into vesa_modes will all need to be fixed.

David

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
