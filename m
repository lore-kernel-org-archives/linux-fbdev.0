From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Framebuffer fixes.
Date: 28 Mar 2003 03:15:30 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048792155.1109.29.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303271008190.26358-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yd8d-0007l8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 11:34:12 -0800
In-Reply-To: <Pine.GSO.4.21.0303271008190.26358-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-27 at 17:09, Geert Uytterhoeven wrote:
> On 27 Mar 2003, Antonino Daplas wrote:
> >        - image->depth should be representative of the data depth
> > (currently, either 8 or 1).  If image->depth == 1, color expansion can
> > now be used to draw the logo, thus there's no need to differentiate
> > between mono logo drawing and monochrome expansion.
> 
> > +	/*
> > +	 * Monochrome expansion and logo drawing functions are the same if
> > +	 * fb_logo.needs_logo == 1.
> > +	 */
> > +	switch (info->fix.visual) {
> > +	case FB_VISUAL_MONO10:
> > +		image.fg_color = (u32) (~(~0UL << fb_logo.depth));
>                                                   ^^^^^^^^^^^^^
> > +		image.bg_color = 0;
> > +		image.depth = 1;
> > +		break;
> > +	case FB_VISUAL_MONO01:
> > +		image.bg_color = (u32) (~(~0UL << fb_logo.depth));
>                                                   ^^^^^^^^^^^^^
> > +		image.fg_color = 0;
> > +		image.depth = 1;
> > +		break;
> 
> Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> 


Yes, fb_logo.depth == info->var.bits_per_pixel.

Tony



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
