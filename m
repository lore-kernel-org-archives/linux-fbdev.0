From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 18:34:45 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051829450.27760-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0303051055250.23176-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qdjd-0006YG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 10:35:21 -0800
In-Reply-To: <Pine.GSO.4.21.0303051055250.23176-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > 1. Text mode support?
> 
> Required by at least davem and petr

Just Petr. I'm working to seperate the text code out into a matroxcon.c 
file. Needs alot more work tho.

> > 2. console resizing using fbset (besides stty)?
> 
> Nice, if it's not too much work.

:-( I hope to improve fbcon to handle this.
 
> 0. Update all drivers
> 
> Absolutely required

Its getting there. Drivers not ported are:

68328fb.c
S3triofb.c
amifb.c
atafb.c
clgenfb.c
cyber2000fb.c
cyberfb.c
imsttfb.c    <- I have a nearly done driver. The old driver doesn't work 
		on ix86. I tried it. Oh wells.
leofb.c
pm2fb.c
pm3fb.c
pvr2fb.c
retz3fb.c
sun3fb.c
valkyriefb.c
virgefb.c


Many of these drivers have been in state of code rotte for a long time :-( 



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
