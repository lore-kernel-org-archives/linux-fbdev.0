From: Pete Popov <ppopov@embeddedalley.com>
Subject: Re: [PATCH] Au1200fb driver.
Date: Mon, 17 Oct 2005 20:10:19 -0700
Message-ID: <1129605019.18165.4.camel@localhost.localdomain>
References: <20051015021045.GA28016@linux-mips.org>
	 <435450C5.3040800@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERhrs-0003On-RN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 20:10:24 -0700
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1ERhrq-0003VK-Uj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 20:10:24 -0700
In-Reply-To: <435450C5.3040800@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>

Thanks Tony. I'll fix it up and resubmit.

Pete

On Tue, 2005-10-18 at 09:32 +0800, Antonino A. Daplas wrote:
> Ralf Baechle wrote:
> > Au1200 fb driver. Updated db1200 defconfig to include driver by default.
> 
> Besides coding style issues, here are a few comments:
> 
> > +struct window_settings
> > +{
> > +	unsigned char name[64];
> > +	uint32 mode_backcolor;
> > +	uint32 mode_colorkey;
> > +	uint32 mode_colorkeymsk;
> 
> Any problems using u32 and family instead of uint32?
> 
> > +
> > +/* AU1200 framebuffer driver */
> > +
> > +int au1200fb_fb_open(struct fb_info *fbi, int user)
> > +{
> > +	return 0;
> > +}
> > +
> > +int au1200fb_fb_release(struct fb_info *fbi, int user)
> > +{
> > +	return 0;
> > +}
> > +
> 
> You can just remove the fb_release and fb_open methods if they're not
> doing anything.
> 
> > +
> > +/* fb_blank
> > + * Blank the screen. Depending on the mode, the screen will be
> > + * activated with the backlight color, or desactivated
> > + */
> > +int au1200fb_fb_blank(int blank_mode, struct fb_info *fbi)
> > +{
> > +	/* Short-circuit screen blanking */
> > +	if (noblanking)
> > +		return 0;
> > +
> > +	switch (blank_mode) {
> > +
> > +	case VESA_NO_BLANKING:
> > +		/* printk("turn on panel\n"); */
> > +		au1200_setpanel(panel);
> > +		break;
> > +
> > +	case VESA_VSYNC_SUSPEND:
> > +	case VESA_HSYNC_SUSPEND:
> > +	case VESA_POWERDOWN:
> > +		/* printk("turn off panel\n"); */
> > +		au1200_setpanel(NULL);
> > +		break;
> 
> Better to use the FB_BLANK_* constants defined in include/linux/fb.h instead
> of the VESA_* constants.  There's also one constant, FB_BLANK_NORMAL, which
> usually means blank the display but keep monitor syncs on.  But if you just
> have 2 blank states, might as well do an if (blank_mode)/else.
> 
> Tony



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
