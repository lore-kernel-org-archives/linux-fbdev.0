From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: 17 Mar 2003 07:00:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047855538.1251.77.camel@localhost.localdomain>
References: <3E71B0FE.1534.4BFD86E@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uhAY-0001l3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Mar 2003 15:03:54 -0800
In-Reply-To: <3E71B0FE.1534.4BFD86E@localhost>
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
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-03-15 at 02:37, Kendall Bennett wrote:
> Hi Guys,
> 
> A long time ago in early 2000, Aki M Laukkanen was a guy working on a 
> VESA framebuffer console daemon for Linux. This driver was structured as 
> a as a user land daemon that the kernel vesafb console driver would call 
> back into once the system was up, allowing the userland VESA driver to 
> use the vm86() service to change modes, program the palette and other 
> useful things that can't be done by the basic VESA driver that uses a 
> mode set previously by LILO or GRUB.

That is a very neat project :-)  It can also be expanded to something
not just the VESA driver will use, but as a general interface whenever
the BIOS services are to be needed.  I can already think several uses
for it (warmboot secondary cards, save/restore current video state,
disable/enable the display, DDC/EDID, etc). I will be very interested if
that project is revived.

BTW:  I want to initialize multiple VGA adapters during the early boot
sequence.  The machine will be in real mode, so there's no such thing as
copy-on-write.  I'm pretty sure it's not possible, but do you know of a
way to disable the BIOS write protection of the C000:0000 segment? 

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
