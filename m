From: Ondrej Zajicek <santiago@mail.cz>
Subject: Framebuffer questions
Date: Wed, 15 Mar 2006 22:10:22 +0100
Message-ID: <20060315211022.GA4474@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJdGI-00011k-T8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Mar 2006 13:10:30 -0800
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FJdGH-0006Zf-7w
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Mar 2006 13:10:30 -0800
Received: from localhost.localdomain (feanorr.kolej.mff.cuni.cz [195.113.26.209])
	by smtp1.kolej.mff.cuni.cz (8.13.4/8.13.1) with ESMTP id k2FLANgO042945
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Mar 2006 22:10:25 +0100 (CET)
	(envelope-from zajio1am@artax.karlin.mff.cuni.cz)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1FJdGA-0001mQ-4c
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Mar 2006 22:10:22 +0100
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello

I have several questions about fbdev. I already read FB-FAQ, most docs
in Documentation/fb/*, linux/fb.h and some messages in archive of this
mailing list.

- I understood that if i want to change videomode then i should set
  all items in struct fb_var_screeninfo, call ioctl FBIOPUT_VSCREENINFO,
  driver considers wanted parameters and if exactly this mode or mode
  with more bits_per_pixel or greater some bitfield.length is supported,
  then mode is changed, otherwise change is rejected. If change is
  successfull, then i should call ioctl FBIOGET_VSCREENINFO and
  FBIOGET_FSCREENINFO to get information about real framebuffer
  structure. Is this correct?

- Should i really set all fields? For example offset and msb_right
  parts of red, green, blue and transp. I usually don't care of this
  so i want to set some DONT_CARE value. Or are these items always
  ignored so i needn't set anything?
  
- If i have to supply complete mode timings for videomode change
  why there is modedb.c and mode lines stored inside drivers?

- I see there is FB_TYPE_TEXT mode (assume for standard text mode).
  what should i set in struct fb_var_screeninfo to get this mode?
  If i grep drivers/video for it, i get it occurs only in vga16fb.
  Is there some deep reason for this or just programmers of other
  fb drivers don't care about text mode?
  
- Is there some possibility to get list of possible framebuffer
  videomodes? Or just list of possible 'structural' framebuffer
  configurations (type,visual,bpp,r/g/b)? (i hope that usually this is
  ortogonal to resolution and timings setting - suppose have enough ram).
  I know about FB_ACTIVATE_TEST but use iterative binary search to
  find all video modes isn't sane idea :-)

- Is there description of fb sysfs interface anywhere? 

- Is there description of specific framebuffer formats for
  various FB_TYPE_* and FB_AUX_*  anywhere?

- I found that with vga16fb i can access just first plane.
  Is it possible to switch planes from userspace and without
  interaction with VGA registers?

- What exactly is supposed to do FB_SYNC_BROADCAST ?

- In include/fb.h there is:

#define FB_VISUAL_PSEUDOCOLOR           3       /* Pseudo color (like atari) */

  Is there some deep sense in remark '(like atari)' or is this well-known
  basic palette visual mode?

I hope i can get some answers or hints.

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
