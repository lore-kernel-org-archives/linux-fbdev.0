From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Wed, 10 Sep 2003 23:32:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063229555.678.10.camel@gaston>
References: <1062952639.655.6.camel@gaston>
	 <20030907230334.GA847@dreamland.darkstar.lan>
	 <1063000866.659.9.camel@gaston>
	 <20030908190527.GA1731@dreamland.darkstar.lan>
	 <20030910164101.GA437@dreamland.darkstar.lan>
	 <1063212505.642.77.camel@gaston>
	 <20030910174654.GA422@dreamland.darkstar.lan>
	 <1063216209.1356.80.camel@gaston>
	 <20030910212700.GA12271@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xCaw-0007GA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 14:33:46 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xCaw-0003V7-4I
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 14:33:46 -0700
In-Reply-To: <20030910212700.GA12271@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-09-10 at 23:27, Kronos wrote:

> This is the modedb created from my edid:
> [cut]
> mode 18
> mode->xres = 1280, mode->right_margin = 79
> mode->hsync_len = 137, mode->left_margin = 217
> mode->vres = 1024, mode->lower_margin = 1 
> mode->vsync_len = 3, mode->upper_margin = 32
> mode->refresh = 60
> mode 19
> mode->xres = 1280, mode->right_margin = 48 
> mode->hsync_len = 112, mode->left_margin = 248
> mode->vres = 1024, mode->lower_margin = 1 
> mode->vsync_len = 3, mode->upper_margin = 38
> mode->refresh = 60
> 
> mode 19 comes from get_detailed_timing, while 18 comes from
> get_std_timing and timings are calculated by calc_mode_timings (which in
> turn calls fb_get_mode). Any chance that there is some error in
> fb_get_mode?

I don't know the details about mode calculation and I never had any VESA
spec, ask James here...

On the other hand, we really want to use the detailed timings in
preferrence to the calculated modes. James didn't reply for that, but I
think I'll add a flag to the modes that tell how they were calculated. I
need that for flat panels too so I don't have to parse twice and I can
be smarter at picking the best LCD panel mode

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
