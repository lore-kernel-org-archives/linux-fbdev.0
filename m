From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: Fri, 14 Mar 2003 11:42:02 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E71C00A.24038.4FAA05B@localhost>
References: <3E71B0FE.1534.4BFD86E@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tv4L-0003OG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 11:42:17 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2EJgOPD023286
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 11:42:24 -0800
In-reply-to: <20030314185649.20002.qmail@web14908.mail.yahoo.com>
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

Jon Smirl <jonsmirl@yahoo.com> wrote:

> Most of the code your need is located in the x86emu-XX files on the
> ftp.scitechsoft.com server. 

Er, did you check my email address? I am the maintainer of the x86emu 
project on our site ;-)

> x86emu has all of the VBIOS support for calling the INT functions.
> You would just need to hook it up so that the fb drivers can call
> it. 

Yes, but it is a BIOS emulator only. What I am looking for is the code 
that Aki did that allowed the kernel mode VESA fbdev driver call out into 
a userland daemon to do the actual calls to the BIOS. Whether the calls 
are made using the x86emu emulator (for non-x86 platforms) or via the 
real BIOS is irrelevant. What is important is the userland daemon hookup; 
that is what I am looking for.

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
