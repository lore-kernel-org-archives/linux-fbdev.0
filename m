From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Some thoughts on Rage128/Radeon EDID
Date: Sat, 16 Aug 2003 23:32:34 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030817063234.75420.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14910.mail.yahoo.com ([216.136.225.62])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19oH5f-0000Qe-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Aug 2003 23:32:35 -0700
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

I looked through the 2.4 radeon driver and I see all
of the code for parsing the EDID blocks. This is a lot
of code and it is seldom used (compared to something
like an interrupt handler).

Somewhat complete I2C driver code exists in the KATOS
project.
http://www.core.binghamton.edu/~insomnia/gatos/katos/src/katos-0.5.tar.gz

These next thoughts just apply to 2.6, not 2.4.

There are a lot of things on the I2C bus on the these
cards: EDID,  video capture, teletext, tv out and mpeg
decoding control, etc..

1) How about making the fb driver register itself as
an I2C bus so that it appears in /proc/bus/I2C? I've
never touched I2C code so I don't know what this
involves.

2) Making the card appear in /proc/bus/I2C makes it
easy to get to from user space.  A user level app can
read the EDID info, diff it off against card
capabilities and IOCTL the new mode in. Maybe modify
fbset.

3) Doesn't the video hardware always power on to a
visible state? So setting an alternate mode can wait
until we can run user space apps. I'm not sure it is
worth all of the kernel code  just to get a 50 line
display with valid EDID during the first few seconds
of boot.

4) Once we have access to the other devices maybe
people will write apps that use them.


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
