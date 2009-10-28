From: Clemens Ladisch <clemens@ladisch.de>
Subject: FBIOPUT_VSCREENINFO: invalid vs. "none" value
	of pixclock?
Date: Wed, 28 Oct 2009 10:51:03 +0100
Message-ID: <4AE81407.4050601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <clemens@ladisch.de>) id 1N35BV-0000q3-9K
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Oct 2009 09:51:17 +0000
Received: from out4.smtp.messagingengine.com ([66.111.4.28])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N35BP-0002wk-3s for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Oct 2009 09:51:17 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 79C05B8017
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Oct 2009 05:51:05 -0400 (EDT)
Received: from [10.1.2.136] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F35CD16E9D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Oct 2009 05:51:04 -0400 (EDT)
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

Hi,

what should the pixclock field for the FBIOPUT_VSCREENINFO ioctl be set
to when an application doesn't care about the timing?

The fbset tool and Xorg's fbdevhw driver set it to zero when they have
no timing.  Other programs (like links or xine) set it to the value
returned by FBIOGET_VSCREENINFO.

However, this seems to be different from the actual DRM helpers
implementation:

drm_fb_helper_single_fb_probe() initializes pixclock to -1, and this is
the value returned by FBIOGET_VSCREENINFO.  (Many programs treat this
as a valid value, 0xffffffff = 4 ms.)

drm_fb_helper_check_var() explicitly rejects both values, 0 or -1.

drm_fb_helper_set_par() refuses to work with any value except -1.


Best regards,
Clemens

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
