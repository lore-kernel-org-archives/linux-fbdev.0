From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Much better framebuffer fixes.
Date: 28 Mar 2003 03:15:23 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048792147.1086.28.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303271016300.26358-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yd8a-0007hB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 11:34:09 -0800
In-Reply-To: <Pine.GSO.4.21.0303271016300.26358-100000@vervain.sonytel.be>
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

On Thu, 2003-03-27 at 17:18, Geert Uytterhoeven wrote:
> On Thu, 27 Mar 2003, James Simmons wrote:
> >  drivers/video/logo/logo.c       |   69 +++++------
> 
> Are you sure the change from logo type to logo depth in (fb_)find_logo() won't
> have any side effects? After this change, you may receive a different type of
> logo than you requested.
> 


I agree.  Take the case of Directcolor. At 16-bpp, it needs
linux_logo_vga16, not linux_logo_clut224. Also, monochrome at 8bpp needs
linux_logo_mono, certainly not linux_logo_clut224.  There are obviously
other similar cases.

I think the original logo code in both logo.c and fbmem.c, though a bit
more confusing, provides better ways of choosing the correct logo.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
