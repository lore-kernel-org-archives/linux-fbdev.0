From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 21:38:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049203284.1050.14.camel@localhost.localdomain>
References: <1049104351.1037.53.camel@localhost.localdomain>
	<3E886C5F.28140.1013B3CA@localhost>
	<1049160350.1059.39.camel@localhost.localdomain>
	<1049185774.593.46.camel@zion.wanadoo.fr>
	<1049189944.1009.61.camel@localhost.localdomain> 
	<1049196891.596.57.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190M2i-00018Y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 05:43:12 -0800
In-Reply-To: <1049196891.596.57.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-04-01 at 19:34, Benjamin Herrenschmidt wrote:
> On Tue, 2003-04-01 at 11:41, Antonino Daplas wrote:
> 
> > How I'm currently doing it with the extended vesafb driver is this:
> >
> > .../...
> 
> Ok, good. I'll investigate adapting that to radeonfb & aty128fb
> at least.

I'm planning to submit a patch to James to add more functionality to
fbmon.c,  fbmon.c should have these at least:

1. struct fb_videomode* fb_create_modedb(unsigned char *edid)

- this will create a mode database that can be used with fb_find_mode() 

2. fb_destroy_modedb(struct fb_videomode *modedb)

- destroy mode database

3. fb_get_monitor_limits(struct fb_monspecs *specs, unsigned char *edid)

- place monitor operating limits to specs

4. fb_validate_mode(struct fb_var_screeninfo *var, struct fb_info *info)

- validate mode timings in var

5. fb_get_mode(int flags, int val, struct fb_var_screeninfo *var, struct
fb_info *info)

- compute mode timings using GTF (refresh driven, hsync driven, pixclock
driven, or maximized refresh) and place result in var

#4 and #5 are already in fbmon.c


> Also, It would be very useful if we defined a standard ioctl to
> retreive the EDID block from userland when available.
> 

I have no problem with this, and this was discussed some time ago, but
nothing was really decided.  It's actually a very nice fallback solution
if there's really no method to get the EDID.

> This would help some fbdev based apps (especially the maconlinux
> emulator) and would be useful for some distro X autoconfig tools,
> especially on platforms where X cannot get that EDID via it's
> current mecanisms.
> 
> Actually, I would like 2 things:
> 
>  - Be able to know that the display has been detected as beeing a
> TFT panel, and in this case, a "simple" way to retreive the
> fb_var_screeninfo of the "native" panel mode. 
> 
>  - Returning the full EDID block when it exist
> 
> What do you think about adding some ioctl's for that ?
> 

It's okay by me.

Tony





-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
