From: Stuffed Crust <pizza@shaftnet.org>
Subject: radeonfb: Radeon Mobility X700 (M26) + x86-64 supported?
Date: Thu, 22 Dec 2005 22:13:33 -0500
Message-ID: <20051223031333.GA14399@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Epf94-0007TX-Ai
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Dec 2005 21:07:10 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com
	([24.73.230.86] helo=shaft.shaftnet.org ident=[CdRYKMBU8VN0DO2EMK4vz2ma5GRHTwXo])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Epf93-00089a-IL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Dec 2005 21:07:10 -0800
Received: from shaft.shaftnet.org (localhost [127.0.0.1])
	by shaft.shaftnet.org (8.12.11/8.12.11) with ESMTP id jBN3DXcr014969
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Dec 2005 22:13:33 -0500
Received: (from pizza@localhost)
	by shaft.shaftnet.org (8.12.11/8.12.8/Submit) id jBN3DXtd014966
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Dec 2005 22:13:33 -0500
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have an AMD64 laptop with a Radeon Mobility X700, and a 1680x1050
screen.  I'm trying to get it to work with the "new" radeonfb driver in
Linux 2.6.15-rc6.  I have not tested the "old" driver.  As best as I can=20
tell, I'm the second person to ask about this particular bit of=20
hardware.

The Radeon M26, aka Mobility X700, is supposedly a derivative of the
desktop X700, aka RV410, which in turn is supposedly derived from the
R423. (They certainly make this rather confusing..) As configured, mine=20
has 128 megs of RAM and a PCI ID of 1002:5653. =20

This deviceid is not present in the device table, but to get it detected=20
to begin with, I added this to the device table in radeon_base.c:=20

CHIP_DEF(PCI_CHIP_RV410_XX,     R420,   CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),

And in ati_ids.h:

#define PCI_CHIP_RV410_XX               0x5653

As I mentioned, this chip (M26, RV410) is supposedly closer to the X800=20
(R420) than the X600 (RV380).  Just in case, I tried setting it to a=20
'RV380' target as well, with similar results.=20

Basically what happens is that on initialization the screen goes blank=20
but the system is otherwise responsive.  logging in remotely, I'm able=20
to get this output from the point where 'modprobe radeonfb' is called:

ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 217
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=3D0.00 MHz (RefDiv=3D0) Memory=3D200.00 Mhz, System=3D2=
00.00 MHz
radeonfb: PLL min 0 max 36438016
radeonfb: No connector info table detected
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type CRT found
radeonfb: panel ID string: J=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=
=EF=BF=BDQ
radeonfb: detected LVDS panel size from BIOS: 9728x1734
radeondb: BIOS provided dividers will be used
radeonfb: Assuming panel size 9728x1734
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 80x25
radeonfb (0000:01:00.0): ATI Radeon VS=20

Meanwhile, 'modprobe radeonfb panel_yres=3D1050 monitor_layout=3DLVDS=20
	   ignore_edid=3D1 nomodeset=3D1 force_measure_pll=3D1=20
           mode_option=3D1280x1024-8@60 force_dfp=3D1' gives:

ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 217
xtal calculation failed: 4674
radeonfb: Used default PLL infos
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D166.00 Mhz, System=
=3D166.00 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: No connector info table detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: J=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=
=EF=BF=BDQ
radeonfb: detected LVDS panel size from BIOS: 9728x1734
radeondb: BIOS provided dividers will be used
radeonfb: Assuming panel size 9728x1734
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 80x25
radeonfb (0000:01:00.0): ATI Radeon VS=20

Mucking with module options has no discernable effect, and the LVDS
panel information is consistently misdetected, obviously..  It would
seem that all of the panel information is garbage.  (does fetching the
panel info from the BIOS work when running on an x86-64 system?)

Finally, the output 'lspci -vv', after the modprobe:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility X70=
0 (PCIE) (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 007e
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 217
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=3D128M]
        Region 1: I/O ports at 9000 [size=3D256]
        Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=3D64K]
        [virtual] Expansion ROM at c0120000 [disabled] [size=3D128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTa=
g+
                Device: Latency L0s <256ns, L1 <4us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port=
 0
                Link: Latency L0s <256ns, L1 <2us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
        Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [100] Advanced Error Reporting

I can provide additional information as needed, and of course act as a
guniea pig.  I'll be installing a i386 kernel (+userland) on this box
tomorrow to see it it behaves any differently.

Any suggestions on what I can do?

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDq2tdPuLgii2759ARAldPAKDazYPL8vgBVTgeUVypoP0NRla9OQCgnAt4
LFdLUjD/r1N2mvJP9i0jnAM=
=jKXq
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
