From: ilmari@ping.uio.no (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Subject: aty128fb breaks on Dell Inspiron 4000
Date: Sat, 11 May 2002 17:23:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <d8jvg9u3dzb.fsf@fimm.ifi.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pat.uio.no ([129.240.130.16])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 176Yis-0000lp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 May 2002 08:23:50 -0700
Received: from fimm.ifi.uio.no ([129.240.66.163])
	by pat.uio.no with esmtp (Exim 2.12 #7)
	id 176Yii-00010r-00
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 May 2002 17:23:40 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Dell Inspiron 4000 laptop with an 8MB ATI Rage Mobility M3
video card with the following lspci output:

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
            M3 AGP 2x (rev 02) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
                 ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
                >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=3D64M]
        Region 1: I/O ports at ec00 [size=3D256]
        Region 2: Memory at fdffc000 (32-bit, non-prefetchable) [size=3D16K]
        Expansion ROM at <unassigned> [disabled] [size=3D128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D0 SBA+ AGP- 64bit- FW- Rate=3D<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

The LCD display is a 1400x1050 panel, identified by XFree86 as
follows:

        (II) R128(0): Panel size: 1400x1050
        (II) R128(0): Panel ID: Samsung LTN141P2=20=20=20=20=20=20=20=20
        (II) R128(0): Panel Type: Color, Single, TFT
        (II) R128(0): Panel Interface: LVDS

When I load the aty128fb module (I've tried with several kernels, most
recently 2.5.13 with the fbdev patch posted on lkml just after its
release), the screeen goes black and flickery with a thin,
multicolored horizontal line about 1cm from the bottom. dmesg says
this about the card when the module is loaded:

     PCI: Found IRQ 11 for device 01:00.0
     aty128fb: Rage128 BIOS not located. Guessing...
     aty128fb: Rage Mobility M3 (AGP) [chip rev 0x0] 8M 128-bit SDR SGRAM (=
1:1)
     Console: switching to colour frame buffer device 80x30
     fb0: ATY Rage128 frame buffer device on PCI
     aty128fb: Rage128 MTRR set to ON

If I switch resolutions with fbset (logged in remotely), the display
goes completely weird, it looks like if some liquid with bright green
and purple "edges" flows from the top and the bottom of the screen,
about 5cm from the right edge. This goes on until the left half of the
screen is green and purple, then it fades to black and white. If I
switch back to 640x480@60Hz, it goes back to the initial black state.

If I log in remotely and start X (or switch back to the X VT, if X
was already running), the screen has 5-15cm wide bands containing
various misplaced and corrupted (except one of the bands) parts of the
image. If I switch resolutions and switch between stretched and
centered mode (Fn-F7), I can get it to look right (but still
flickering) in 800x600 and 640x480.

I hope someone can make some sense of this. I am of course more than
willing to test patches and assist in debugging.

=2D-=20
Dagfinn I. Manns=C3=A5ker
aka. Ilmari

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.6 (SunOS)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE83Td81C7NxFHs+sYRAsdtAKC5wpjEkg7fmDvBFg1PVmIEoV4glwCfahpN
NGEkP0SKkDqXgFX7TY1tOsQ=
=CFqu
-----END PGP MESSAGE-----
--=-=-=--

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
