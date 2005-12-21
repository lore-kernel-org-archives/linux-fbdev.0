From: Harald Welte <laforge@gnumonks.org>
Subject: [PATCH] radeonfb ATI 9100IGP shared main memory / VRAM
Date: Wed, 21 Dec 2005 21:37:06 +0100
Message-ID: <20051221203706.GR4495@sunbeam.de.gnumonks.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O7Os1+MGCLLi8F5z"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EpAi8-0007la-7n
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 12:37:20 -0800
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EpAi0-0002D2-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 12:37:20 -0800
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
To: "Ben. Herrenschmidt" <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


--O7Os1+MGCLLi8F5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben!

I have a couple of machines with an ASUS P4R800-VM mainboard.

lspci looks like this:

00:00.0 Host bridge: ATI Technologies Inc Radeon 9100 IGP Host Bridge (rev =
02)
00:01.0 PCI bridge: ATI Technologies Inc Radeon 9100 IGP AGP Bridge
00:13.0 USB Controller: ATI Technologies Inc OHCI USB Controller #1 (rev 01)
00:13.1 USB Controller: ATI Technologies Inc OHCI USB Controller #2 (rev 01)
00:13.2 USB Controller: ATI Technologies Inc EHCI USB Controller (rev 01)
00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 18)
00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349
00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audi=
o Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon 9100 IGP
02:08.0 Ethernet controller: 3Com Corporation 3Com 3C920B-EMB-WNM Integrate=
d Fast Ethernet Controller (rev 40)
02:09.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000=
 Controller (PHY/Link)

The issue is that those boards (as I believe most 9100IGP chips do)
share main memory and video memory, and the user configures in CMOS
SETUP whihc amount of memory he wants to dedicate to the video card.

However (it might be a BIOS issue specific to this board), the cards
report 0k videoram.

radeonfb as it is in 2.6.14.4 therefore only does the following:

radeonfb_pci_register BEGIN
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 16 (level, low) -> IRQ 177
radeonfb (0000:01:05.0): Found 0k of DDR 128 bits wide videoram
radeonfb (0000:01:05.0): cannot map FB
ACPI: PCI interrupt for device 0000:01:05.0 disabled
radeonfb: probe of 0000:01:05.0 failed with error -5

I've altered radeon_base.c with a special exception for this chip, see
the patch below.  Now everything works like a charm.

Cheers,
	Harald


--- linux-2.6.14.4/drivers/video/aty/radeon_base.c	2005-12-15 00:50:41.0000=
00000 +0100
+++ linux-2.6.14.4-radeonfb/drivers/video/aty/radeon_base.c	2005-12-21 21:2=
6:27.000000000 +0100
@@ -2157,6 +2157,11 @@
 		case PCI_CHIP_RADEON_LZ:
 	       		rinfo->video_ram =3D 8192 * 1024;
 	       		break;
+		case PCI_CHIP_RS300_5834:
+			/* This chip ?can? have shared main memory / VRAM,
+			 * and the size is configured according to CMOS SETUP */
+			rinfo->video_ram =3D pci_resource_len(rinfo->pdev, 0);
+			break;
 	       	default:
 	       		break;
 		}

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--O7Os1+MGCLLi8F5z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDqbzyXaXGVTD0i/8RAk9OAJ43LLrjr/YbctwvXstHQ3HM8iKHpQCfUt45
SqBqNGPSjOy/zP7aGwtsbxw=
=oV8F
-----END PGP SIGNATURE-----

--O7Os1+MGCLLi8F5z--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
