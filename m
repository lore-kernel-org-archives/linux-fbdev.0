From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Finding Aki M Laukkanen's VESAFBD project?
Date: Fri, 14 Mar 2003 10:37:50 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E71B0FE.1534.4BFD86E@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tu4D-0004IM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 10:38:05 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2EIcCPD022288
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 10:38:12 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi Guys,

A long time ago in early 2000, Aki M Laukkanen was a guy working on a 
VESA framebuffer console daemon for Linux. This driver was structured as 
a as a user land daemon that the kernel vesafb console driver would call 
back into once the system was up, allowing the userland VESA driver to 
use the vm86() service to change modes, program the palette and other 
useful things that can't be done by the basic VESA driver that uses a 
mode set previously by LILO or GRUB.

After some research I discovered that unfortunately Aki was killed in an 
accident in January 2001, and hence this project was forgotten about. I 
would very much like to resurrect this project and complete it on Aki's 
behalf. Below is the original announcement email from Aki in January 
2000, but none of the links work anymore. If anyone downloaded this code 
at the time or knows where to find the code that Aki was working on, 
please let me know.

--- cut here ----

Subject: [ANNOUNCE] vesafb full VBE 2.0 support
From: Aki M Laukkanen (amlaukka@cc.helsinki.fi)
Date: Sat Jan 22 2000 - 09:21:48 EST

Patch to vesafb adds support for communicating with a user-space daemon. 
This user-space daemon uses the LRMI library by Josh Vanderhoof (need his 
e-mail) to call real-mode VBE 2.0 functions to set the mode, pan the 
display and perform other framebuffer functions. Thanks to Alan Cox for 
the idea and mailing the LRMI library.  

This is a very preliminary version and released because it works for me. 
Your mileage may vary. The communication between kernel/user-space is 
achieved via a special character device file (/dev/vesafb).  

~$ file /dev/vesafb
/dev/vesafb: character special (10/180)

When vesafbd successfully opens the vesafb device, the `dummy' functions 
in the vesafb driver are overrided with the ones capable of communicating 
with the daemon. Issued FB ioctls are then added to a request/reply queue 
which is processed by the device read/write functions. A queue is needed 
because console switching is done from an interrupt context.  

In practice this seems to work quite well. Even panning (for example in 
X) is completely smooth on my Pentium/133. By default the patch writes a 
lot of debug info but this may be omitted by commenting out the DEBUG 
define in the code. The patch itself is against 2.3.x (I doubt there has 
been any changes during that time) but needs only small changes to work 
with 2.2.x.  

Download from:
http://www.cs.helsinki.fi/u/amlaukka/vesafb/

I've also setting up a web page at:
http://www.cs.helsinki.fi/u/amlaukka/vesafb.html

---- cut here ----

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
