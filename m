From: Witold Filipczyk <witekfl@poczta.gazeta.pl>
Subject: Re: Why aty128fb is so slow?
Date: Sun, 9 Mar 2003 05:43:17 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030309054317.GA2456@pecet.fixsoftware.pl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [217.98.241.107] (helo=pecet.fixsoftware.pl)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rtaq-0000KV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Mar 2003 21:43:28 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, Mar 07, 2003 at 10:52:28PM +0000, James Simmons wrote:
> 
> > Hello,
> > Could anybody explain why aty128fb is so slow?
> > I'm using kernel-2.4.20.
> > 
> > 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro TF (prog-if 00 [VGA])
> >         Subsystem: ATI Technologies Inc Rage 128 Pro TF
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (2000ns min), cache line size 08
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
> >         Region 1: I/O ports at c000 [size=256]
> >         Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=16K]
> >         Expansion ROM at <unassigned> [disabled] [size=128K]
> >         Capabilities: [50] AGP version 2.0
> >                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
> >                 Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
> >         Capabilities: [5c] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > 
> > 
> > Computer has Athlon 1.8+ processor on K7VTA3 motherboard.
> > 
> > In directory with 5000 files ls on console takes more than 6 seconds.
> > In xterm or rxvt ls takes only 0.6 s.
> 
> Because the driver is completely unaccelerated. Everything is drawn pixel 
> by pixel :-( 2.5.X is much faster :-)

OK. I'll try it.

-- 
Witold Filipczyk
<witekfl@poczta.gazeta.pl>


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
