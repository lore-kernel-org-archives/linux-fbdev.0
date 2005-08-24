From: Ian Romanick <idr@us.ibm.com>
Subject: [PATCH] Read MGA PInS data on PowerPC
Date: Wed, 24 Aug 2005 15:44:49 -0700
Message-ID: <430CF861.7060208@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010007090308090001000600"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E83zV-0006XV-KO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Aug 2005 15:45:05 -0700
Received: from e33.co.us.ibm.com ([32.97.110.131])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1E83zR-0005xS-De
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Aug 2005 15:45:02 -0700
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7OMirNN393996
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Aug 2005 18:44:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7OMiKen275388
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Aug 2005 16:44:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7OMiqcb031783
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Aug 2005 16:44:52 -0600
Received: from [9.47.22.101] (dyn9047022101.beaverton.ibm.com [9.47.22.101])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7OMipKk031758
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Aug 2005 16:44:51 -0600
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010007090308090001000600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This updates the matroxfb code so that it can find the PInS data
embedded in the BIOS on PowerPC cards.  The process for finding the data
is different on OpenFirmware cards than on x86 cards, and the code for
doing so was missing.

After patching, building, installing, and booting a kernel, you should
grep for "PInS" in /var/log/messages.  You should see two messages in
the log:

PInS data found at offset XXXXX
PInS memtype = X

On the GXT135p card I get "31168" and "5".  The first value is
irrelevant, but it's presence lets me know that the PInS data was
actually found.  On a GXT130p, the second value should be 3.  Since I
don't have access to that hardware, if someone can verify that, I will
submit a follow-on patch that rips out all the memtype parameter stuff.

fa76838aa195ee448d788ba65d73fa30  matroxfb_PInS-01.patch

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDDPhgX1gOwKyEAw8RApKwAJ0SMcNCzdZJceCeJ8fi8pvfKaVhOwCfU1tD
+RfH4M6ACtK9v/u2LUtSuy4=
=56qc
-----END PGP SIGNATURE-----

--------------010007090308090001000600
Content-Type: text/x-patch;
 name="matroxfb_PInS-01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="matroxfb_PInS-01.patch"

diff -rud --exclude='*~' linux-2.6.11.8/drivers/video/matrox/matroxfb_misc.c linux-2.6.11.8.matroxfb/drivers/video/matrox/matroxfb_misc.c
--- linux-2.6.11.8/drivers/video/matrox/matroxfb_misc.c	2005-04-29 18:29:20.000000000 -0700
+++ linux-2.6.11.8.matroxfb/drivers/video/matrox/matroxfb_misc.c	2005-06-20 11:44:49.647889368 -0700
@@ -67,6 +67,9 @@
  *
  *               "David C. Hansen" <haveblue@us.ibm.com>
  *                     Fixes
+ * 
+ *               "Ian Romanick" <idr@us.ibm.com>
+ *                     Find PInS data in BIOS on PowerPC systems.
  *
  * (following author is not in any relation with this code, but his code
  *  is included in this driver)
@@ -499,10 +502,35 @@
 	get_bios_version(vbios, bd);
 	get_bios_output(vbios, bd);
 	get_bios_tvout(vbios, bd);
+#if defined(__powerpc__)
+	/* On PowerPC cards, the PInS offset isn't stored at the end of the
+	 * BIOS image.  Instead, you must search the entire BIOS image for
+	 * the magic PInS signature.
+	 * 
+	 * This actually applies to all OpenFirmware base cards.  Since these
+	 * cards could be put in a MIPS or SPARC system, should the condition
+	 * be something different?
+	 */
+	for ( pins_offset = 0 ; pins_offset <= 0xFF80 ; pins_offset++ ) {
+		unsigned char header[3];
+
+		header[0] = readb(vbios + pins_offset);
+		header[1] = readb(vbios + pins_offset + 1);
+		header[2] = readb(vbios + pins_offset + 2);
+		if ( (header[0] == 0x2E) && (header[1] == 0x41)
+		     && ((header[2] == 0x40) || (header[2] == 0x80)) ) {
+			printk(KERN_INFO "PInS data found at offset %u\n",
+			       pins_offset);
+			get_pins(vbios + pins_offset, bd);
+			break;
+		}
+	}
+#else
 	pins_offset = readb(vbios + 0x7FFC) | (readb(vbios + 0x7FFD) << 8);
 	if (pins_offset <= 0xFF80) {
 		get_pins(vbios + pins_offset, bd);
 	}
+#endif
 }
 
 #define get_u16(x) (le16_to_cpu(get_unaligned((__u16*)(x))))
@@ -758,6 +786,8 @@
 	}
 #endif
 	matroxfb_set_limits(PMINFO &ACCESS_FBINFO(bios));
+	printk(KERN_INFO "PInS memtype = %u\n",
+	       (ACCESS_FBINFO(values).reg.opt & 0x1C00) >> 10);
 }
 
 EXPORT_SYMBOL(matroxfb_DAC_in);

--------------010007090308090001000600--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
