From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Radeon EDID
Date: Sat, 23 Aug 2003 18:50:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030823165021.GA773@dreamland.darkstar.lan>
References: <20030823155728.1056.qmail@web14915.mail.yahoo.com>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qbb0-0000Oy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 23 Aug 2003 09:50:34 -0700
Content-Disposition: inline
In-Reply-To: <20030823155728.1056.qmail@web14915.mail.yahoo.com>
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
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, Andreas Oberritter <obi@saftware.de>

Il Sat, Aug 23, 2003 at 08:57:28AM -0700, Jon Smirl ha scritto: 
> I merged in Radeon EDID with my ROM based Radeon driver. Results are at:
> bk://mesa3d.bkbits.net/linux-2.5
> I needed to fix some error handling in the init code, and remove =y from the
> Kconfig.

If radeonfb  is build  into the kernel  we need  i2c-algo-bit also. What
about this:

depends on FB_RADEON && (I2C_ALGOBIT=FB_RADEON || I2C_ALGOBIT=y)

> Now that I2C is there, is it hard to make the rest of the I2C devices
> accessible?

Such as the tvout? We need another  i2c adapter (and a driver of course)
because the  current one deals with  only with DDC registers. If  I find
some docs I can write something, but I don't hw to test.

Btw, where can I find some docs about i2c on radeon? Can't find anything
on ATI web site. My work is based on XFree code...

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Io mi ricordo sempre il compleanno della mia ragazza:
cade il giorno dopo di quando lei me lo ricorda


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
