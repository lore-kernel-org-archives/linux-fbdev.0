From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: Mon, 17 Mar 2003 10:22:35 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E75A1EB.8118.1424F41D@localhost>
References: <3E71B0FE.1534.4BFD86E@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uzFq-0003RD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 10:22:34 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2HIMpPD029001
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 10:22:52 -0800
In-reply-to: <1047855538.1251.77.camel@localhost.localdomain>
Content-description: Mail message body
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas <adaplas@pol.net> wrote:

> > A long time ago in early 2000, Aki M Laukkanen was a guy working on a 
> > VESA framebuffer console daemon for Linux. This driver was structured as 
> > a as a user land daemon that the kernel vesafb console driver would call 
> > back into once the system was up, allowing the userland VESA driver to 
> > use the vm86() service to change modes, program the palette and other 
> > useful things that can't be done by the basic VESA driver that uses a 
> > mode set previously by LILO or GRUB.
> 
> That is a very neat project :-)  It can also be expanded to
> something not just the VESA driver will use, but as a general
> interface whenever the BIOS services are to be needed.  

Yes, it could. It also doesn't need to be used just for VESA/BIOS 
services, but could be used to implement real mode fbconsole drivers 
using existing driver modules from XFree86 if desired.

> BTW:  I want to initialize multiple VGA adapters during the early
> boot sequence.  The machine will be in real mode, so there's no
> such thing as copy-on-write.  I'm pretty sure it's not possible,
> but do you know of a way to disable the BIOS write protection of
> the C000:0000 segment? 

I don't think it is possible to do this because the BIOS is in ROM on the 
graphics card. If the system BIOS is shadowing it (quite likely) then it 
would be possible, but you would need to know how to disable the write 
protection in the system chipset which is probably different for each 
motherboard.

The other option is to use the x86emu BIOS emulator project. Then you 
don't need to do any of this stuff and instead can warm boot all the 
graphics controllers using the BIOS from the card (see the sample 
'warmboot' program included in the source code archives). The code is 
presently 32-bit specific I believe, so you would have two choices for 
running this from real mode - port the code to a 16-bit C compiler or 
port it to run in 32-bit real mode. I assume you are probably thinking of 
during the boot phase of GRUB or LILO, so at that point you will have 
full control and should be able to execute 32-bit real mode code. You may 
even be able to put the machine into protected mode and run the code as 
32-bit protected mode code also if needed (but you would need to then 
write your own protected mode kernel).

The BIOS emulator code is available from:

ftp://ftp.scitechsoft.com/devel/x86emu

I think...

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
