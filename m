From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: accelerated radeonfb produces artifacts on scrolling in 2.6.7
Date: Wed, 16 Jun 2004 21:52:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040616195210.GA26935@middle.of.nowhere>
References: <20040616182415.GA8286@middle.of.nowhere> <20040616184145.GA12673@havoc.gtf.org> <40D0A5B4.7060007@techsource.com>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BagSg-0004dJ-UK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 12:52:42 -0700
Received: from smtp-out2.xs4all.nl ([194.109.24.12])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BagSg-0005VQ-9Q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 12:52:42 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out2.xs4all.nl (8.12.10/8.12.10) with ESMTP id i5GJqboi005373
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Jun 2004 21:52:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <40D0A5B4.7060007@techsource.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timothy Miller <miller@techsource.com>
Cc: David Eger <eger@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Timothy Miller <miller@techsource.com>
Date: Wed, Jun 16, 2004 at 03:55:32PM -0400
> 
> 
> David Eger wrote:
> >On Wed, Jun 16, 2004 at 08:24:15PM +0200, Jurriaan wrote:
> >
> >>The radeonfb driver in 2.6.7 produces some interesting artifacts on
> >>scrolling, both scrolling horizontally and vertically.
> >
> >
> >The corruption you are talking about is, I believe, caused by a couple of 
> >things:
> >
> >(1) we're not issuing enough fifo_wait()'s around our accel engine
> >    and pan register writes.
> >(2) there's some disconnect between writing to fb memory, panning, and
> >    copyarea()/fillrect() calls
> >
> >I sent a hack of a fix for this to Ben a week ago, adding a call to 
> >radeonfb_sync()
> >at the end of radeonfb_copyarea() and radeonfb_fillrect().  This seems to 
> >fix the
> >problem for me, but you *shouldn't* have to do this.  
> >
> >I haven't tracked it any further than this.  My next guess would be 
> >auditing register writes and making sure there are enough fifo_wait()'s...
> 
> 
> Is this the case even with the off-by-one error in the bitblt code 
> fixed?  In the 2.4 kernel, I got rid of all artifacts by fixing the 
> off-by-one error.
> 
> In case, you don't know what I'm talking about, when you bitblt up or to 
> the left on Radeon, x and y need to be adjusted by (w-1) and/or (h-1), 
> respectively.  The code there, however, adjusted by w and/or h, which is 
> off-by-one.
> 

You mean this code? I see (w-1) and (h-1) in there.

static void radeonfb_prim_copyarea(struct radeonfb_info *rinfo, 
				   const struct fb_copyarea *area)
{
	int xdir, ydir;
	u32 sx, sy, dx, dy, w, h;

	w = area->width; h = area->height;
	dx = area->dx; dy = area->dy;
	sx = area->sx; sy = area->sy;
	xdir = sx - dx;
	ydir = sy - dy;

	if ( xdir < 0 ) { sx += w-1; dx += w-1; }
	if ( ydir < 0 ) { sy += h-1; dy += h-1; }

	radeon_fifo_wait(3);
	OUTREG(DP_GUI_MASTER_CNTL,
		rinfo->dp_gui_master_cntl /* i.e. GMC_DST_32BPP */
		| GMC_SRC_DSTCOLOR
		| ROP3_S 
		| DP_SRC_RECT );
	OUTREG(DP_WRITE_MSK, 0xffffffff);
	OUTREG(DP_CNTL, (xdir>=0 ? DST_X_LEFT_TO_RIGHT : 0)
			| (ydir>=0 ? DST_Y_TOP_TO_BOTTOM : 0));

	radeon_fifo_wait(3);
	OUTREG(SRC_Y_X, (sy << 16) | sx);
	OUTREG(DST_Y_X, (dy << 16) | dx);
	OUTREG(DST_HEIGHT_WIDTH, (h << 16) | w);
}


void radeonfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
{
	struct radeonfb_info *rinfo = info->par;
	struct fb_copyarea modded;
	u32 vxres, vyres;
	modded.sx = area->sx;
	modded.sy = area->sy;
	modded.dx = area->dx;
	modded.dy = area->dy;
	modded.width  = area->width;
	modded.height = area->height;
  
	if (info->state != FBINFO_STATE_RUNNING)
		return;
	if (radeon_accel_disabled()) {
		cfb_copyarea(info, area);
		return;
	}

	vxres = info->var.xres;
	vyres = info->var.yres;

	if(!modded.width || !modded.height ||
	   modded.sx >= vxres || modded.sy >= vyres ||
	   modded.dx >= vxres || modded.dy >= vyres)
		return;
  
	if(modded.sx + modded.width > vxres)  modded.width = vxres - modded.sx;
	if(modded.dx + modded.width > vxres)  modded.width = vxres - modded.dx;
	if(modded.sy + modded.height > vyres) modded.height = vyres - modded.sy;
	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
  
	radeonfb_prim_copyarea(rinfo, &modded);
}

HTH,
Jurriaan
-- 
hundred-and-one symptoms of being an internet addict:
17. You turn on your intercom when leaving the room so you can hear if new
e-mail arrives.
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 1.90


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
