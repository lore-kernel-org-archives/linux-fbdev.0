From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH][FBDEV]: generic fb console rotation infrastructure
Date: 05 Feb 2003 16:38:15 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1044434293.1170.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>

Hi James,

I decided to add the Console rotation patch which I submitted before to
linux-2.5.59.  The orientation of the display is determined by the
valued of display.rotate, and the appropriate drawing functions in
display.dispsw.  If the display is rotated, fontdata will be prerotated,
and the appropriate console window dimenstions are swapped if necessary.

Currently, this is just an implementation and no hooks are provided yet
to enable/disable this.  This will require some coordination between the
console layer and fbdev.

Current limitations:

1.  cannot support a fontwidth not a multiple of 8 if rotated 180
degrees, and a fontheight not a multiple of 8 if rotated by 90 degrees. 
This is a limitation with fb_imageblit which has no support for bitmap
clipping.

2.  code for panning when rotated by 90 degrees is still buggy, so it's
disabled.

3.  minor graphics glitches.

4.  no support for hardware based rotation, but this should be easy to
add

You can test this by defining DEBUG_ROTATE in the following code
snippet:

#undef DEBUG_ROTATE
#ifdef DEBUG_ROTATE
	/*
	 * change to the appropriate orientation and 
	 * drawing function to test for rotation
	 */
	p->dispsw = &fbcon_180_dispsw;
	p->rotate = FB_VMODE_ROTATE_180
	if (p->rotate) 
		fbcon_rotate_fontdata(p->rotate, p); 
#endif

I've tested the code with several drivers including vga16fb and vesafb.

The patch is at
http://i810fb.sourceforge.net/linux-2.5.59-rotate.diff.gz


Any comments welcome.

Tony
