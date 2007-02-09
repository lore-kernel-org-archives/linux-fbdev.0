From: Marcus Better <marcus@better.se>
Subject: Re: intelfb not working on Thinkpad R60
Date: Fri, 09 Feb 2007 11:16:05 +0100
Message-ID: <eqhhl5$esr$1@sea.gmane.org>
References: <eqeuc6$irv$1@sea.gmane.org>
	<Pine.LNX.4.64.0702081850460.7686@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFSo6-0007dl-17 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Feb 2007 02:16:42 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFSo4-00011I-7B
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Feb 2007 02:16:41 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFSnl-00005F-IX for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Feb 2007 11:16:21 +0100
Received: from 67.152.216.81.static.g-va.siw.siwnet.net ([81.216.152.67])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 Feb 2007 11:16:21 +0100
Received: from marcus by 67.152.216.81.static.g-va.siw.siwnet.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 Feb 2007 11:16:21 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

James Simmons wrote:
>>*First, if I compile intelfb and fbcon into the kernel, and no other
>>frame buffer modules, I don't think the "vga" parameter is ever
>>processed.

> That is correct vga= is only used by vga console or vesafb.

Some people claim that the boot loader (Grub or Lilo?) is supposed to
interpret the vga= parameter and set the video mode through BIOS.

And what is this text doing in Documentation/fb/intelfb.txt:

  If setting this parameter doesn't work (you stay in a 80x25 text-mode),   
  you might need to set the "vga=<mode>" parameter too - see vesafb.txt in 
  this directory.

> I bet the mode you can passing is incomplete. Please try
> something like this
> 
> video=intelfb:mode:1024x768-8@75

I suppose you mean "video=intelfb:mode=1024x768-8@75"? That doesn't help
either. I get the VGA console or vesafb, depending on whether the "vga="
option was given. Besides the depth and refresh rate parameters are
supposed to be optional.

Regards,

Marcus



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
