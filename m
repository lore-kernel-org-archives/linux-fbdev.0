From: Antonino Daplas <adaplas@pol.net>
Subject: Console Rotation
Date: 09 Sep 2002 22:20:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031580513.632.3.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oPOb-0002GB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 07:20:10 -0700
Received: from AP-202-70-99-9.compass.com.ph (AP-202-70-99-9.compass.com.ph [202.70.99.9])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id WAA90301
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Sep 2002 22:20:06 +0800 (PHT)
	(envelope-from adaplas@pol.net)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi, 

Since Xfbdev is able to rotate the display, I guess it's also reasonable
for the console to have the ability to rotate the display too. 

I have added 3 new flags to var->vmode: 

FB_VMODE_ROTATE_CW  0x010000 /*  90 degree rotation */ 
FB_VMODE_ROTATE_CCW 0x020000 /* 270 degree rotation */ 
FB_VMODE_ROTATE_UD  0x040000 /* 180 degree rotation */ 
FB_ROTATE_MASK      0xFF0000 

Rotating the display is done using console wrappers similar to
fbcon-accel.  Depending on the rotation flag, dispsw is pointed to the
appropriate wrapper in gen_set_disp. 

As for driver support, the minimum requirement is for the driver to
recognize these flags, and set the var->xres, var->yres,
var->xres_virtual, and var->yres_virtual fields to the appropriate
logical values.  Ie, if display is rotated CW or CCW, then logical xres
is physical yres, etc. 

For drivers that support panning, the viewport and direction of the
panning must be appropriate for the orientation.  Ie, if display is
rotated 180 degrees, the viewport must be flushed to the 'right' and
'bottom' edge of the framebuffer when xoffset and yoffset are zero. Then
logical pan_down is physical pan_up, etc. 

The option is configurable under 'Advanced Low Level Driver Options',
and is dependent on CONFIG_FB_ACCEL being set since the wrapper depends
on xxximageblit, xxxfillrect and xxxcopyarea. 

As a testbed, I modified vesafb to support console rotation. 

The following patches will follow (against linux-2.5.33): 

a. fb_rotate.diff 
b. fb_drawing.diff 
c. vesafb_rotate.diff 
d. fbset_rotate.diff 

If the patches are mangled, please get them at: 

http://i810fb.sourceforge.net/fb_rotate.tar.gz

Tony 

   




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
