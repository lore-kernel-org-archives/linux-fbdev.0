From: "Leif Neland" <leif@neland.dk>
Subject: Re: Framebuffer overflow halts network (fwd)
Date: Fri, 14 Feb 2003 02:12:09 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <007e01c2d3c6$193feb80$6705a8c0@gina>
References: <Pine.LNX.4.44.0302122001240.31435-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 0x50c48aec.adsl-fixed.tele.dk ([80.196.138.236] helo=arnold.neland.dk)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18jUPW-0003a7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Feb 2003 17:13:02 -0800
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
To: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


----- Original Message -----
From: "James Simmons" <jsimmons@infradead.org>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Linux Frame Buffer Device Development"
<linux-fbdev-devel@lists.sourceforge.net>; "Leif Neland" <leif@neland.dk>
Sent: Wednesday, February 12, 2003 9:01 PM
Subject: Re: [Linux-fbdev-devel] Framebuffer overflow halts network (fwd)



> > I have set up my primary work machine (i.e. it is mostly used as a
terminal
> > to connect to other servers) with framebuffer and have 64 lines*160
chars in
> > a pretty font.
> >
> > I ssh to other servers from this machine.
> >
> > If I do something which create a lot of output, eg. ls -lR /, the remote
> > machine sends more data than the framebuffer-terminal can handle. This
> > blocks the network on the terminal machine, which also is nameserver,
> > internal webserver and upsd server.
> >

> Which kernel are you using and whcih video card?

Debian-version: 3.0

Linux 2.2.19

From dmesg:

Detected 350798 kHz processor.
vesafb: framebuffer at 0xdc000000, mapped to 0xd0000000, size 4096k
vesafb: mode is 1280x1024x8, linelength=1280, pages=2
vesafb: protected mode interface info at c000:5b6a
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device

from /proc/pci

  Bus  0, device  12, function  0:
    VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 1).
      Medium devsel.  IRQ 11.  Master Capable.  Latency=32.  Min Gnt=4.Max
Lat=255.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdc000000].

>



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
