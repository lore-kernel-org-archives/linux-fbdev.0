From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Garbled data on radeon KMS
Date: Tue, 1 Sep 2009 14:01:13 -0400
Message-ID: <a728f9f90909011101w13e7abd8q9307311b02f7079f@mail.gmail.com>
References: <4A9D432E.3030901@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1MiXfa-00020F-60
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Sep 2009 18:01:26 +0000
Received: from mail-bw0-f227.google.com ([209.85.218.227])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MiXfT-0000nj-IC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Sep 2009 18:01:26 +0000
Received: by bwz27 with SMTP id 27so187196bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 01 Sep 2009 11:01:13 -0700 (PDT)
In-Reply-To: <4A9D432E.3030901@grupopie.com>
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
Cc: Linux FB-Devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Sep 1, 2009 at 11:52 AM, Rui Santos<rsantos@grupopie.com> wrote:
> Hi all,
>
> =A0 =A0I'm trying to setup a secondary video card through radeon KMS
> driver. I'm only using fbcon, no X.
> =A0 =A0Every time I change to a console belonging to /dev/fb1 the kernel
> crashes. I've setup a netconsole but I get no extra info from it. Just a
> crash...

What do you mean by crash?  lockup?  segfault?

Alex

> =A0 =A0Here is the drm output:
>
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] Initialized drm 1.=
1.0
> =A0 =A020060810
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon default to
> =A0 =A0kernel modesetting.
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon kernel
> =A0 =A0modesetting enabled.
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: radeon 0000:01:0c.0:
> =A0 =A0enabling device (0080 -> 0083)
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: radeon 0000:01:0c.0: PCI=
 INT
> =A0 =A0A -> GSI 18 (level, low) -> IRQ 18
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.debug kernel: radeon 0000:01:0c.0:
> =A0 =A0setting latency timer to 64
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: Initializi=
ng
> =A0 =A0kernel modesetting.
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] register mmio base:
> =A0 =A00xFDEE0000
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] register mmio size=
: 65536
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.debug kernel: Switched to high resolu=
tion
> =A0 =A0mode on CPU 0
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] GPU reset succeed
> =A0 =A0(RBBM_STATUS=3D0x00000140)
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] GPU not posted.
> =A0 =A0posting now...
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] Clocks initialized=
 !
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] Detected VRAM RAM=
=3D32M,
> =A0 =A0BAR=3D128M
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] RAM width 32bits D=
DR
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: VRAM 32M
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: VRAM from
> =A0 =A00x00000000 to 0x03FFFFFF
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: VRAM less =
than
> =A0 =A0aperture workaround enabled
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: GTT 512M
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: GTT from
> =A0 =A00x20000000 to 0x3FFFFFFF
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: irq initia=
lized.
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [TTM] TTM available grap=
hics
> =A0 =A0memory: 247 MiB
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [TTM] TTM available obje=
ct
> =A0 =A0memory: 247 MiB
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: 32M of VRAM
> =A0 =A0memory ready
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: 512M of GTT
> =A0 =A0memory ready.
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] GART: num cpu pages
> =A0 =A0131072, num gpu pages 131072
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: cp idle
> =A0 =A0(0x00008080)
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] Loading R100 Micro=
code
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: ring at
> =A0 =A00x0000000020000000
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] ring test succeede=
d in
> =A0 =A01 usecs
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: ib pool re=
ady.
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] ib test succeeded =
in 0
> =A0 =A0usecs
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] Radeon Display Con=
nectors
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] Connector 0:
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] =A0 VGA
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] =A0 DDC: 0x60 0x60=
 0x60
> =A0 =A00x60 0x60 0x60 0x60 0x60
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] =A0 Encoders:
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] =A0 =A0 CRT1: INTE=
RNAL_DAC1
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] fb mappable at 0xD=
8040000
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] vram apper at 0xD8=
000000
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] size 5242880
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] fb depth is 24
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] =A0 =A0pitch is 51=
20
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: fb1: radeondrmfb frame
> =A0 =A0buffer device
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: registered panic notifier
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] radeon: kernel
> =A0 =A0modesetting successfully initialized.
> =A0 =A0Sep =A01 15:42:54 ws1t1 user.info kernel: [drm] Initialized radeon
> =A0 =A02.0.0 20080528 for 0000:01:0c.0 on minor 0
>
> =A0 =A0lspci -vvv:
>
> 01:0c.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
> [Radeon 7000/VE] (prog-if 00 [VGA controller])
> =A0 =A0 =A0 =A0Subsystem: ATI Technologies Inc Device 013b
> =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B- DisINTx-
> =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> =A0 =A0 =A0 =A0Latency: 64 (2000ns min), Cache Line Size: 64 bytes
> =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 18
> =A0 =A0 =A0 =A0Region 0: Memory at d8000000 (32-bit, prefetchable) [size=
=3D128M]
> =A0 =A0 =A0 =A0Region 1: I/O ports at dc00 [size=3D256]
> =A0 =A0 =A0 =A0Region 2: Memory at fdee0000 (32-bit, non-prefetchable) [s=
ize=3D64K]
> =A0 =A0 =A0 =A0Expansion ROM at fde00000 [disabled] [size=3D128K]
> =A0 =A0 =A0 =A0Capabilities: [50] Power Management version 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0=
mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 NoSoftRst- PME-Enable- DSel=3D0=
 DScale=3D0 PME-
> =A0 =A0 =A0 =A0Kernel driver in use: radeon
> =A0 =A0 =A0 =A0Kernel modules: radeonfb
>
> =A0 =A0Can anyone help me with some debug or, maybe I'm not just doing it
> right... I also found little documentation on the subject...
>
> Thanks for you help,
> Rui Santos
>
>
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay
> trial. Simplify your report design, integration and deployment - and focu=
s on
> what you do best, core application coding. Discover what's new with
> Crystal Reports now. =A0http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
