From: Richard Smith <rsmith@bitworks.com>
Subject: Re: still ..Confused about atyfb and M1
Date: Fri, 06 Feb 2004 14:13:45 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4023F579.7030701@bitworks.com>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org> <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be> <40210CEA.5080102@bitworks.com> <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be> <4022838A.8010502@bitworks.com> <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be> <4022B783.8070002@bitworks.com> <Pine.GSO.4.58.0402061017120.398@waterleaf.sonytel.be>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApCMk-0004Au-AS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 Feb 2004 12:14:18 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ApCMj-0006Yg-RU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 Feb 2004 12:14:18 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 06 Feb 2004 14:13:33 -0600
In-Reply-To: <Pine.GSO.4.58.0402061017120.398@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: geert@linux-m68k.org
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
>         Subsystem: Sony Corporation: Unknown device 80c7
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]

I don't think your chip is an M1.  The M1 is limited to 8 Megs of memory 
which is on chip and not expandable so I don't see how you can have 16Megs.




-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
