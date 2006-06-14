From: Richard Purdie <rpurdie@rpsys.net>
Subject: Problems with rotated Logos
Date: Wed, 14 Jun 2006 11:13:17 +0100
Message-ID: <1150279997.27375.15.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqSNO-0008Kd-J5 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 03:13:30 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FqSNO-00053d-Fw for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 03:13:30 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqSNM-0007x2-Qn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 03:13:30 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Hi,

I've been experimenting with logos on the Sharp Zaurus C3000 which has a
480x640 framebuffer which is rotated clockwise to give 640x480. I'm
using a 2.6.16 based kernel.

If I use the standard Linux logo (clut224), all is well. I added a
640x185 logo and this locked the machine up when booting. Space was
cleared at the top of the console for the logo and some boot messages
appeared beneath it. Also, 639x185 gave the same result.

To assist debugging, I changed to a 480x185 logo and tested this without
console rotation where it displays fine. If I rotate the console
clockwise, the logo doesn't appear but there is space left for it and
the system boots.

I've tried to get further with this but I couldn't quite understand how
fb_rotate_logo_cw was working. Could this be broken in the case where
you have a logo with width > height? (height > width in the case of that
function). I made a test program to look at the numbers outputted by
that function and they didn't seem right for my logo size. I've not
checked with the tux logo sizes as I ran out of time but will do in due
course.

I'll continue to look into this but I wondered if anyone had any
thoughts where the problem might be offhand? The lockup worries me but
could be some separate issue and I'll work on getting the 480x185 logo
working initially.

Regards,

Richard
