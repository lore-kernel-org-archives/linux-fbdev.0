From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Radeon EDID
Date: Sat, 23 Aug 2003 08:57:28 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030823155728.1056.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14915.mail.yahoo.com ([216.136.225.228])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qalc-0001bo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 23 Aug 2003 08:57:28 -0700
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
To: kronos@kronoz.cjb.net, fb-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andreas Oberritter <obi@saftware.de>

I merged in Radeon EDID with my ROM based Radeon driver. Results are at:
bk://mesa3d.bkbits.net/linux-2.5
I needed to fix some error handling in the init code, and remove =y from the
Kconfig.

Now that I2C is there, is it hard to make the rest of the I2C devices
accessible?

My current 2.5 R128 driver is in the same tree. Andreas is working a better one
(full console accel) but it hasn't been ported to 2.5 yet. The Radeon I2C code
should help is getting the R128 driver EDID working too.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
