From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: Fri, 14 Mar 2003 10:56:49 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030314185649.20002.qmail@web14908.mail.yahoo.com>
References: <3E71B0FE.1534.4BFD86E@localhost>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14908.mail.yahoo.com ([216.136.225.60])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tuMM-0004YX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 10:56:50 -0800
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
Content-Transfer-Encoding: 7bit
To: Kendall Bennett <KendallB@scitechsoft.com>, linux-fbdev-devel@lists.sourceforge.net

Most of the code your need is located in the x86emu-XX
files on the ftp.scitechsoft.com server. x86emu has
all of the VBIOS support for calling the INT
functions. You would just need to hook it up so that
the fb drivers can call it.

But wouldn't the time be better spent on getting the
info out of the board manufacturers that would allow
protected mode versions of these routines to be
implemented? With that info we could eliminate the
need for this VM86 stuff forever.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
