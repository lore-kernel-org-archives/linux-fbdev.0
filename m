From: Jon Smirl <jonsmirl@yahoo.com>
Subject: EDID through sysfs
Date: Sun, 17 Aug 2003 10:34:07 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030817173407.16010.qmail@web14907.mail.yahoo.com>
References: <20030817144528.GA843@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14907.mail.yahoo.com ([216.136.225.59])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19oRQA-0005gz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Aug 2003 10:34:26 -0700
In-Reply-To: <20030817144528.GA843@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Kronos <kronos@kronoz.cjb.net> wrote:
> > Somewhat complete I2C driver code exists in the
> KATOS
> Cool. I'm coding something  like this but I'm unable
> to  get an ACK back
> from the  card. I'll look  at this  code and see  if
> I  can speak  to my
> board.

Post as soon as you get something working. No sense
duplicating effort, I can spend the time working on
standalone OpenGL.

Exporting EDID info through sysfs is probably the best
universal solution. That way we can have a standard
utility for setting modes instead of having a custom
solution for each card. It also be fun to play with
all of the other devices on my All-in-Wonder.

How is I2C code in Katos vs the 2.6 kernel? Katos is
four years old, I'm sure I2C support has improved
since then.

> sysfs to set a new mode. I think that Greg KH is
> working on it.
Point Greg at the Katos code, it may same him some
effort.

Does anyone know how other vendors handle the EDID/DDC
info? Do other cards use I2C? Will sysfs work as a
universal solution?



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
