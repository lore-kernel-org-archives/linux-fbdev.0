From: "Peter Hanzel" <hanzelpeter@gmail.com>
Subject: fbdev intel with kernel modesetting
Date: Fri, 27 Feb 2009 12:13:36 +0100
Message-ID: <A71FB3B26F3F479BA375A7FA660E5E0F@avitech.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hanzelpeter@gmail.com>) id 1Ld0gM-0000KS-7B
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 11:15:06 +0000
Received: from fg-out-1718.google.com ([72.14.220.156])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ld0gI-0005i8-Dz for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 11:15:06 +0000
Received: by fg-out-1718.google.com with SMTP id l27so588378fgb.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2009 03:15:00 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hello.

I have a question. I am using intelfb to get framebuffer console on Acer 
Extensa 5220 notebeook. (VGA Intel 965GM)
In kernel 2.6.28.7 i must set video mode on boot with vga= param.
Now I have discovered that in 2.6.29 kernel, there is support for kernel 
modesetting with gpu/drm/i915.

Will this be joined with driver/video/intelfb ?

So mode switch will work with simple fbdev IOCTL.?
Like some cooperation between fbdev and gpu/drm?

Thanks. 


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
