From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: still ..Confused about atyfb and M1
Date: Sat, 7 Feb 2004 18:54:41 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402071852500.19574@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
 <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
 <40210CEA.5080102@bitworks.com> <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be>
 <4022838A.8010502@bitworks.com> <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be>
 <4022B783.8070002@bitworks.com> <Pine.GSO.4.58.0402061017120.398@waterleaf.sonytel.be>
 <4023F579.7030701@bitworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApWfc-0006mB-Ko
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 07 Feb 2004 09:55:08 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1ApWfb-0003pJ-Fo
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 07 Feb 2004 09:55:08 -0800
In-Reply-To: <4023F579.7030701@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Smith <rsmith@bitworks.com>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 6 Feb 2004, Richard Smith wrote:
> Geert Uytterhoeven wrote:
> > 01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
> >         Subsystem: Sony Corporation: Unknown device 80c7
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
> >         Interrupt: pin A routed to IRQ 9
> >         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
>
> I don't think your chip is an M1.  The M1 is limited to 8 Megs of memory
> which is on chip and not expandable so I don't see how you can have 16Megs.

It has 8 MiB of RAM.

All Mach64 PCI/AGP variants show 16 MiB of PCI memory space, for up to 8 MiB of
video RAM. The second 8 MiB is the big endian aperture.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
