From: Alex Thiel <stderr@web.de>
Subject: vesafb and ypan
Date: Tue, 12 Aug 2003 11:09:38 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m3ptjb6y3x.fsf@spock.alex.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
To: linux-fbdev-devel@sourceforge.net

Hello,

I was wondering if the ypan et al. options to the VESA framebuffer
device are broken in the 2.5 series.

Looking at the source, it seems that var.accel_flags is left
uninitialized in struct fb_var_screeninfo, in my setup accel_flags has
a value of 0. This in turn causes the scrollmode to be set to
SCROLL_REDRAW in fbcon_init(). Now in updatescrollmode() the
expression (p->scrollmode & __SCROLL_YFIXED) always evaluates to true,
and the scrollmode is never changed to ypan.

Am I missing something here? Can anyone confirm that ypan is actually
working with vesafb (i.e. is actually calling vesafb_pan_display)?

Cheers,

        Alex



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
