From: rwhron@earthlink.net
Subject: Re: stack trace from matrox fb on 2.5.50
Date: Sun, 1 Dec 2002 17:22:01 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021201222201.GA224@rushmore>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from swan.mail.pas.earthlink.net ([207.217.120.123])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18IcPW-0006Ld-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 01 Dec 2002 14:17:58 -0800
Content-Disposition: inline
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
To: geert@linux-m68k.org
Cc: linux-fbdev-devel@lists.sourceforge.net

>> Call Trace:
>>  [<c011c340>] check_timer_failed+0x40/0x50
>>  [<c01c9050>] cursor_timer_handler+0x0/0x30

> Yes, the timer initialization was reverted in 2.5.50. Please apply the patch
> Mathijs Mohlmann send to this list.

Yes, Mathijs' patch eliminates the call trace at boot time.
Thanks!

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
