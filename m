From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: FBDEV updates.
Date: Thu, 14 Aug 2003 14:57:46 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030814215746.64028.qmail@web14908.mail.yahoo.com>
References: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14908.mail.yahoo.com ([216.136.225.60])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19nQ6N-0005e6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Aug 2003 14:57:47 -0700
In-Reply-To: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>, Otto Solares <solca@guug.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

When I was working on Rage128/Radeon drivers and
fixing them up for the 2.6 modules parameters, I
noticed that they allow an fb mode as a parameter. How
is this supose to work? I tried setting a mode and it
gets copied into the internal structures but the
display doesn't change. If I modify the driver to
change the display mode fbconsole gets all confused.

I just left the drviers the way I found them. Mode
fills in the internal vars but doesn't actually set it.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
