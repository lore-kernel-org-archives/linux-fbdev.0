From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Please advise on choosing the right backlight switching framework
Date: Wed, 27 May 2009 01:11:31 +0200
Message-ID: <200905270111.32947.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-omap@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

I'd like to add support for lcd backlight on/off switching on omap1 ams-delta 
board. I could potentially use omap1_bl backlight class device driver for 
this purpose, but it is not fully compatible with ams-delta, as it actually 
changes lcd contrast instead of backlight intensity on this board.
I can see two possible ways of controlling backlight on omap platforms:
1. over omapfb panel device driver, with lcd_panel.set_bklight_level(),
2. over backlight class device driver, using backlight_ops.update_status().
Which method is the preferred one, giving more chances for integration into 
the mainline kernel?

Thanks,
Janusz
