From: David Ung <davidu@nvidia.com>
Date: Fri, 05 Dec 2014 04:08:48 +0000
Subject: RE: [PATCH 2/3] video: fbdev: Check Standard Timing against DMT
Message-Id: <1f9106d7dbe44844ab0a872737a5999c@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> > diff --git a/drivers/video/fbdev/core/modedb.c
> > b/drivers/video/fbdev/core/modedb.c
> > index 0b57c1df..858a97e 100644
> > --- a/drivers/video/fbdev/core/modedb.c
> > +++ b/drivers/video/fbdev/core/modedb.c
> > @@ -497,6 +497,90 @@ const struct fb_videomode vesa_modes[] = {
> >  	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED,
> FB_MODE_IS_VESA },
> > };  EXPORT_SYMBOL(vesa_modes);
> > +
> > +const struct dmt_videomode dmt_modes[DMT_SIZE] = {
> > +	{ 0x01, 0x0000, 0x000000, &vesa_modes[0] },
> > +	{ 0x02, 0x3119, 0x000000, &vesa_modes[1] },
> > +	{ 0x03, 0x0000, 0x000000, &vesa_modes[2] },
> > +	{ 0x04, 0x3140, 0x000000, &vesa_modes[3] },
> > +	{ 0x05, 0x314c, 0x000000, &vesa_modes[4] },
> > +	{ 0x06, 0x314f, 0x000000, &vesa_modes[5] },
> > +	{ 0x07, 0x3159, 0x000000, &vesa_modes[6] },
> > +	{ 0x08, 0x0000, 0x000000, &vesa_modes[7] },
> > +	{ 0x09, 0x4540, 0x000000, &vesa_modes[8] },
> > +	{ 0x0a, 0x454c, 0x000000, &vesa_modes[9] },
> > +	{ 0x0b, 0x454f, 0x000000, &vesa_modes[10] },
> > +	{ 0x0c, 0x4559, 0x000000, &vesa_modes[11] },
> > +	{ 0x0d, 0x0000, 0x000000, 0 },
> > +	{ 0x0e, 0x0000, 0x000000, 0 },
> 
> You've filled only some of the modes in this table. What's the logic which
> modes are left out?
> 

For DMT id 0xd, it has no STD 2byte id, no 3byte CVT code and no mode timings
currently defined in vesa_modes struct.
There is 80 DMT ids, but only 43 vesa_modes defined in fbdev.  So I've left those
entries empty.  If we eventually have all the VESA timings, the last column could
be eliminated.

David 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
