From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Re: still ..Confused about atyfb and M1
Date: Sun, 8 Feb 2004 21:42:02 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200402082142.02820.alex.kern@gmx.de>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org> <4023F579.7030701@bitworks.com> <Pine.GSO.4.58.0402071852500.19574@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Apvkx-000503-Cn
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Feb 2004 12:42:19 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Apvkw-0006Cc-N2
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Feb 2004 12:42:18 -0800
In-Reply-To: <Pine.GSO.4.58.0402071852500.19574@waterleaf.sonytel.be>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Am Samstag, 7. Februar 2004 18:54 schrieb Geert Uytterhoeven:
> On Fri, 6 Feb 2004, Richard Smith wrote:
> > Geert Uytterhoeven wrote:
> > > 01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
> > > P/M AGP 2x (rev 64) (prog-if 00 [VGA]) Subsystem: Sony Corporation:
> > > Unknown device 80c7
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr- Stepping+ SERR- FastB2B- Status: Cap+ 66Mhz- UDF- FastB2B+
> > > ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
> > > 66 (2000ns min), Cache Line Size: 0x08 (32 bytes) Interrupt: pin A
> > > routed to IRQ 9
> > >         Region 0: Memory at fd000000 (32-bit, non-prefetchable)
> > > [size=16M]
> >
> > I don't think your chip is an M1.  The M1 is limited to 8 Megs of memory
> > which is on chip and not expandable so I don't see how you can have
> > 16Megs.
>
> It has 8 MiB of RAM.
>
> All Mach64 PCI/AGP variants show 16 MiB of PCI memory space, for up to 8
> MiB of video RAM. The second 8 MiB is the big endian aperture.
>
> Gr{oetje,eeting}s,
>
> 						Geert
Hallo all,

I'm not understand, what a problem is, who is problem reporter and why
he don't ask me?

I work on this driver for 2.6 kernel and it works good on my ARMADA E500
It's 15" 1400x1050 natural with
ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64)

good means all resolutions, from 320x200 to 1600x1200(that one only on CRT).

Regards Alex

P.S.
If everybody has a problem, please be sure, you use the last code from James's 
fbdev.diff.gz, than switch debug define in atyfb_base.c on and
send me a log.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
