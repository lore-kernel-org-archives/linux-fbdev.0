From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 18:05:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046945135.1209.76.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>	<1046913411
	 .1206.185.camel@localhost.localdomain> 	<3E670B82.30900@winischhofer.net>
	<1046942633.1330.54.camel@localhost.localdomain> 
	<3E671848.5020506@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qsEa-0004DM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 02:04:17 -0800
In-Reply-To: <3E671848.5020506@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 17:43, Thomas Winischhofer wrote:
> > Mode checking is not simply looking at xres and yres, but also looking
> > at htotal, and vtotal to derive hsync, vsync and pixelclock.  These are
> > then compared to the monitor/graphics card's capability.  If any of the
> > values fall outside the limits then the mode is not valid.  Otherwise,
> > the new mode should still produce a usable display, perhaps not the one
> > the user wants (ie refresh rate is lower).  By this time though, the
> > user can freely use fbset to fine tune all the timings.
> 
> Perhaps I have not made myself clear:
> 
> I start with a default 800x600-60. Pixelclock in var is now X.
> 
> fbcon_resize adapts the xres and yres, leaving the pixelclock alone.
> 
> The driver sees upon the check_var call: xres, yres and X - the old 
> pixelclock (which is non-zero).
> 
> That pixelclock *COULD* be valid, but it COULD also be invalid! There is 
> no way of distinguishing!
> 

Yes, there is.  Using the "stale" pixelclock, htotal and vtotal,
calculate hsync and vsync.  Compare this with your monitor's limit -- if
any fall outside, the entire mode, pixelclock and all is not valid.

(see fb_get_mode() and fb_validate_mode() in fbmon.c)

And if you use very narrow vsync and hsync ranges, then the "stale"
pixelclock will always most certainly be invalid.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
