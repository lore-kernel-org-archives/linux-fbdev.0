From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Framebuffer fixes.
Date: 28 Mar 2003 04:49:34 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048798158.1035.13.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303272148280.7286-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yebd-0001pA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 13:08:13 -0800
In-Reply-To: <Pine.GSO.4.21.0303272148280.7286-100000@vervain.sonytel.be>
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

On Fri, 2003-03-28 at 04:49, Geert Uytterhoeven wrote:
> > > 
> > > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> > 
> > Yes, fb_logo.depth == info->var.bits_per_pixel.
> 
> Euh, now I get confused... Do you mean
> `Yes, it should be replaced by info->var.bits_per_pixel' or
> `No, logo.depth is always equal to info->var.bits_per_pixel'?

:)  Sorry about that. I meant:


`No, fb_logo.depth is always equal to info->var.bits_per_pixel'

Tony



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
