From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Some thoughts on Rage128/Radeon EDID
Date: Sun, 17 Aug 2003 16:45:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030817144528.GA843@dreamland.darkstar.lan>
References: <20030817063234.75420.qmail@web14910.mail.yahoo.com>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19oOnC-0003WW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Aug 2003 07:46:02 -0700
Content-Disposition: inline
In-Reply-To: <20030817063234.75420.qmail@web14910.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

Il Sat, Aug 16, 2003 at 11:32:34PM -0700, Jon Smirl ha scritto: 
> Somewhat complete I2C driver code exists in the KATOS
> project.
> http://www.core.binghamton.edu/~insomnia/gatos/katos/src/katos-0.5.tar.gz

Cool. I'm coding something  like this but I'm unable to  get an ACK back
from the  card. I'll look  at this  code and see  if I  can speak  to my
board.

> These next thoughts just apply to 2.6, not 2.4.
> 
> There are a lot of things on the I2C bus on the these
> cards: EDID,  video capture, teletext, tv out and mpeg
> decoding control, etc..
> 
> 1) How about making the fb driver register itself as
> an I2C bus so that it appears in /proc/bus/I2C? I've
> never touched I2C code so I don't know what this
> involves.

Well, on 2.6 the device model  will handle this pretty well. The devices
and the driver will show up in /sys/bus/i2c (sysfs).

> 2) Making the card appear in /proc/bus/I2C makes it
> easy to get to from user space.  A user level app can
> read the EDID info, diff it off against card
> capabilities and IOCTL the new mode in. Maybe modify
> fbset.

Sure, we can expose EDID and other infos to user space. Maybe we can use
sysfs to set a new mode. I think that Greg KH is working on it.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
