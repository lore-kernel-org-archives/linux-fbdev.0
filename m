From: Tilman Schmidt <tilman@imap.cc>
Subject: i810fb fails to load (was: 2.6.20-rc4-mm1)
Date: Mon, 15 Jan 2007 00:52:36 +0100
Message-ID: <45AAC244.8060607@imap.cc>
References: <20070111222627.66bb75ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig45AC97A48380A9FE0492F6D4"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751724AbXANXsY@vger.kernel.org>
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45AC97A48380A9FE0492F6D4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

With kernel 2.6.20-rc4-mm1 and all hotfixes, i810fb fails to load on my
Dell Optiplex GX110. Here's an excerpt of the diff between the boot logs
of 2.6.20-rc5 (working) and 2.6.20-rc4-mm1 (non-working):

@@ -4,7 +4,7 @@
 No module symbols loaded - kernel modules not enabled.

 klogd 1.4.1, log source =3D ksyslog started.
-<5>Linux version 2.6.20-rc5-noinitrd (ts@gx110) (gcc version 4.0.2 20050=
901 (prerelease) (SUSE Linux)) #2 PREEMPT Sun Jan 14 23:37:12 CET 2007
+<5>Linux version 2.6.20-rc4-mm1-noinitrd (ts@gx110) (gcc version 4.0.2 2=
0050901 (prerelease) (SUSE Linux)) #3 PREEMPT Sun Jan 14 21:08:56 CET 200=
7
 <6>BIOS-provided physical RAM map:
 <4>sanitize start
 <4>sanitize end
@@ -188,7 +192,6 @@
 <6>ACPI: Interpreter enabled
 <6>ACPI: Using PIC for interrupt routing
 <6>ACPI: PCI Root Bridge [PCI0] (0000:00)
-<7>PCI: Probing PCI hardware (bus 00)
 <6>ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
 <7>Boot video device is 0000:00:01.0
 <4>PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
@@ -238,20 +241,15 @@
 <6>isapnp: No Plug & Play device found
 <6>Real Time Clock Driver v1.12ac
 <6>Intel 82802 RNG detected
-<6>Linux agpgart interface v0.101 (c) Dave Jones
+<6>Linux agpgart interface v0.102 (c) Dave Jones
 <6>agpgart: Detected an Intel i810 E Chipset.
 <6>agpgart: detected 4MB dedicated video ram.
 <6>agpgart: AGP aperture is 64M @ 0xf8000000
 <4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
 <7>PCI: setting IRQ 9 as level-triggered
 <6>ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 9 (level, l=
ow) -> IRQ 9
-<4>i810-i2c: Probe DDC1 Bus
-<4>i810fb_init_pci: DDC probe successful
-<4>Console: switching to colour frame buffer device 160x64
-<4>I810FB: fb0         : Intel(R) 810E Framebuffer Device v0.9.0
-<4>I810FB: Video RAM   : 4096K
-<4>I810FB: Monitor     : H: 30-83 KHz V: 55-75 Hz
-<4>I810FB: Mode        : 1280x1024-8bpp@60Hz
+<4>i810fb_alloc_fbmem: can't bind framebuffer memory
+<4>i810fb: probe of 0000:00:01.0 failed with error -16
 <6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enab=
led
 <6>serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
 <6>serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A

Please let me know if you need more information.

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig45AC97A48380A9FE0492F6D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFqsJSMdB4Whm86/kRAqkWAJ9vVwhivB2J+4zyNAiWE5st9Q6CigCfYrDK
WtodgKbBmhlfUqtslvhprNw=
=Pgn9
-----END PGP SIGNATURE-----

--------------enig45AC97A48380A9FE0492F6D4--
