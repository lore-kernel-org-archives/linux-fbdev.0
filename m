From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Wed, 10 Sep 2003 23:27:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030910212700.GA12271@dreamland.darkstar.lan>
References: <1062952639.655.6.camel@gaston> <20030907230334.GA847@dreamland.darkstar.lan> <1063000866.659.9.camel@gaston> <20030908190527.GA1731@dreamland.darkstar.lan> <20030910164101.GA437@dreamland.darkstar.lan> <1063212505.642.77.camel@gaston> <20030910174654.GA422@dreamland.darkstar.lan> <1063216209.1356.80.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xCVJ-0006us-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 14:27:57 -0700
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xCVI-00015r-M3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 14:27:56 -0700
Content-Disposition: inline
In-Reply-To: <1063216209.1356.80.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Wed, Sep 10, 2003 at 07:50:10PM +0200, Benjamin Herrenschmidt ha scritto: 
> Anyway, if your EDID returns incorrect infos, then we are screwed, or
> maybe we aren't calculating the horizontal margin properly when building
> the mode.

This is the modedb created from my edid:
[cut]
mode 18
mode->xres = 1280, mode->right_margin = 79
mode->hsync_len = 137, mode->left_margin = 217
mode->vres = 1024, mode->lower_margin = 1 
mode->vsync_len = 3, mode->upper_margin = 32
mode->refresh = 60
mode 19
mode->xres = 1280, mode->right_margin = 48 
mode->hsync_len = 112, mode->left_margin = 248
mode->vres = 1024, mode->lower_margin = 1 
mode->vsync_len = 3, mode->upper_margin = 38
mode->refresh = 60

mode 19 comes from get_detailed_timing, while 18 comes from
get_std_timing and timings are calculated by calc_mode_timings (which in
turn calls fb_get_mode). Any chance that there is some error in
fb_get_mode?

I'll check XFree ASAP.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Al termine di un pranzo di nozze mi hanno dato un
amaro alle erbe cosi' schifoso che perfino sull'etichetta
c'era un frate che vomitava.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
