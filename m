From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Adding an fb_sync() operation to fb_ops
Date: 01 Jun 2002 21:29:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1022938092.543.3.camel@daplas>
References: <Pine.GSO.4.21.0205312213000.13028-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17E8xY-0007w6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 01 Jun 2002 06:30:21 -0700
In-Reply-To: <Pine.GSO.4.21.0205312213000.13028-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-06-01 at 04:14, Geert Uytterhoeven wrote:
> On Fri, 31 May 2002, James Simmons wrote:
> > > Secondly (not related to the topic), I was wondering if we can change
> > > the color value passed to fillrect and imageblit.  Presently, the
> > > palette index is always passed regardless of the visual. Should the
> > > color value passed be reflective of the framebuffer format instead?
> > > Pass a palette index if pseudocolor, an RGB value for truecolor, etc.
> > >
> > > Doing the latter will simplify the low-level drawing function and at the
> > > same time, it will make the drawing functions more flexible -- ie,
> > > possiblity of exporting to userspace.
> > 
> > We had this discussion sometime ago. We discovered it was just impossible
> > to handle all the possible different color formats in the higher levels.
> > We ended up with way to many #ifdefs. So it was decided to let the drivers
> > handle it instead. Actually if you wanted it to be useable to userland
> > then it makes even more sense to use the color map index instead. Think
> > about all the if() statements you would need in userland.
> 
> Userland can easily set up function pointers, depending on the used format
> (for commonly used formats). Even for the generic case it can be done without
> too much loss of efficiency using look-up tables, cfr. fbtest.
> 

I think that's a nice idea.  We can add another fb_op (I know, another
one), something like:

static u32 XXXfb_getcolor(u32 index, struct fb_info *info)
{
	u32 color = 0;

	switch (info->var.bits_per_pixel) {
	case 8:
	     color = index;
	     break;
	case 16:
	case 24:
	case 32:
	     color = ((u32 *)(info->pseudo_palette[index]))
	     break;
	}
	
	return color;
}


Then in fbcon-accel.c, we can have something like:

	region.fg_color = info->fb_getcolor(attr_fgcol(p, c));
	region.bg_color = info->fb_getcolor(attr_bgcol(p, c));

This will simplify fbcon-accel and the drawing functions. 

Tony


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
