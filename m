From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [RFC] intelfb + DirectFB + laptop issue
Date: Thu, 29 Oct 2009 14:42:41 +0200
Message-ID: <4AE98DC1.3070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulius.zaleckas@gmail.com>) id 1N3Uvf-0005oS-Md
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:20:39 +0000
Received: from darkstar.wilibox.com ([195.14.175.138])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3UvX-0002Fc-FE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:20:38 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sf.net
Cc: sylvain.meyer@worldonline.fr

Hi,

After failing to start DirectFB (tries to get and then set current
resolution) on my asus eeePC I investigated problem and I found out
that it is caused by:

static int intelfb_check_var(struct fb_var_screeninfo *var,
                              struct fb_info *info)
{
...
	if (FIXED_MODE(dinfo) &&
	    (change_var ||
	     var->yres_virtual > dinfo->initial_var.yres_virtual ||
	     var->yres_virtual < dinfo->initial_var.yres ||
	     var->xoffset || var->nonstd)) {
		if (first) {
			ERR_MSG("Changing the video mode is not supported.\n");
			first = 0;
		}
		return -EINVAL;
	}
...

I my situation FIXED_MODE(dinfo) = true, but change_var = false
It still fails since dinfo->initial_var.yres_virtual is initialized
only once as 0, so var->yres_virtual is always bigger value.

Do we need these checks? chnage_var already does size chekings...

fbset -accel [true|false] also fails because of this check.

Please help me to resolve this issue and we should send patch for stable
also.

BR,
Paulius Zaleckas

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
