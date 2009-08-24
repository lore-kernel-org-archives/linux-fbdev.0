From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: radeonfb cannot map FB
Date: Mon, 24 Aug 2009 16:20:44 -0400
Message-ID: <a728f9f90908241320q585d649bobed8c026cd2a7097@mail.gmail.com>
References: <4A92EDDB.6040806@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1Mfg2G-0004E5-7j
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Aug 2009 20:21:00 +0000
Received: from mail-bw0-f227.google.com ([209.85.218.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mfg2B-0003ME-2Q for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Aug 2009 20:20:59 +0000
Received: by bwz27 with SMTP id 27so1641664bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 24 Aug 2009 13:20:44 -0700 (PDT)
In-Reply-To: <4A92EDDB.6040806@grupopie.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Rui Santos <rsantos@grupopie.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux FB-Devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Aug 24, 2009 at 3:45 PM, Rui Santos<rsantos@grupopie.com> wrote:
> Dear Benjamin Herrenschmidt, dear mailing list subscribers,
>
> =A0 =A0 I'm trying to load radeonfb for an RV100 QY chipset. Whatever I
> type in the modprobe I always get:
> =A0 =A0 =A0 radeonfb (0000:01:0c.0): cannot map FB
> =A0 =A0 =A0 radeonfb: probe of 0000:01:0c.0 failed with error -5
>
> =A0 =A0I've tried latest 2.6.27.x and 2.6.30.x kernels. This a secondary
> video card that I would like to connect a monitor to. The first video
> card is an Intel 915G, which is working with vesafb.
>
> =A0 =A0Here is the output of lspci -vvv
> =A0 =A001:0c.0 VGA compatible controller: ATI Technologies Inc Radeon RV1=
00
> QY [Radeon 7000/VE] (prog-if 00 [VGA controller])
> =A0 =A0 =A0 =A0 =A0 =A0Subsystem: ATI Technologies Inc Device 013b
> =A0 =A0 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- =
VGASnoop-
> ParErr- Stepping+ SERR- FastB2B- DisINTx-
> =A0 =A0 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
>>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> =A0 =A0 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 18
> =A0 =A0 =A0 =A0 =A0 =A0Region 0: Memory at d8000000 (32-bit, prefetchable=
) [size=3D128M]
> =A0 =A0 =A0 =A0 =A0 =A0Region 1: I/O ports at dc00 [size=3D256]
> =A0 =A0 =A0 =A0 =A0 =A0Region 2: Memory at fdee0000 (32-bit, non-prefetch=
able)
> [size=3D64K]
> =A0 =A0 =A0 =A0 =A0 =A0[virtual] Expansion ROM at fde00000 [disabled] [si=
ze=3D128K]
> =A0 =A0 =A0 =A0 =A0 =A0Capabilities: [50] Power Management version 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1+ D2+ AuxCur=
rent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 NoSoftRst- PME-Enable- =
DSel=3D0 DScale=3D0 PME-
> =A0 =A0 =A0 =A0 =A0 =A0Kernel modules: radeonfb
>
> =A0 =A0Can you or anyone give a hint on what I might be doing wrong:
> modprobe radeonfb mode_option=3D800x600-16 panel_yres=3D600
> =A0 =A0Or could this be some kind of hardware issue ?

radeonfb doesn't currently have any code to post secondary x86 cards
so they won't work unless they have been posted by the system bios.

Alex

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
