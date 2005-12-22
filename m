From: Christian Trefzer <ctrefzer@gmx.de>
Subject: [PATCH] neofb: take existing display configuration as default
Date: Thu, 22 Dec 2005 19:49:54 +0100
Message-ID: <20051222184952.GA1423@hermes.uziel.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EpVWr-0006GN-HF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Dec 2005 10:51:05 -0800
Received: from mxout01.versatel.de ([212.7.152.117])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EpVWo-00028B-Tz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Dec 2005 10:51:05 -0800
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
Cc: Antonino Daplas <adaplas@pol.net>, Denis Oliver Kropp <dok@directfb.org>


--lEGEL1/lMxI0MVQ2
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello everyone,

on a Dell Latitude CPi-A I noticed a strangeness wrt. the handling of an
external monitor by the neomagic framebuffer driver, namely when the
laptop is docked in a C/Dock II with the lid shut.

A cold boot would result in the BIOS configuring the video chip to use
the "external monitor only" mode, yet neofb would default to "internal
LCD only".  An attempt for a quick fix by using the Fn-F8 keystroke to
toggle the display combination modes resulted in a reproductible hard
lock, powering down being the only solution.

The attached patch makes neofb probe the register for the current
display mode, using that value as a default if nothing was specified as
kernel/module parameter. Any comment welcome.

If I should have wrongly Cc:ed someone, please let me know.


Some questions related to neofb:
I was desperately looking for any kind of specification regarding the
NeoMagic NM2200 and similar chips - trying to understand what neofb.c
does in general was possible, but understandind the hardware was not.
With further information regarding registers and their intended use, I
might play a little with the chip and driver. Any pointers to stuff on
the web (google hit almost nil) or attachments would be great. TIA!


Further issues I would like to investigate are, also with the CPi-A
docked in the C/Dock II:

 - Even though "neofb:external" is given on the kernel command line, the
   external display is not activated. This is not in any way changed by
   the attached patch. The register values for display mode selection
   seem correct, though - I verified that by adding printk statements
   all over the place.
   It seems that the only missing thing is the final activation of the
   external display output: toggling the internal/external display three
   times via the keystroke gives the usual modulo 3 result, changing
   from (inactive) external-only to internal-only, then dual, then
   (active) external only. Any hints on where to look in particular?

 - Once the latter is fixed, I might look into pushing the resolution
   and depth to its limits. Recent X.org drivers put the NM2200 with
   2560KB to 1280x1024 at 16bpp, vesafb gave me only 8bpp but the
   resolution was alright. Would it be possible to get a framebuffer of
   1280x1024x16 out of this thing?


One more thing that might be trivial for someone who ate the NeoMagic
specs for breakfast:

 - Shutting the lid turns off the LCD backlight, but if power saving is
   configured via setterm, it is flipped back on once the given timeout
   is reached. In my case, with an open lid the backlight is off after
   five minutes. With the lid shut, it will be back on after five
   minutes ; ) Some state-machine-like info about certain registers,
   anyone?


Thanks for your time.

--
Chris

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename="neofb-use-register-value-as-default.patch"
Content-Transfer-Encoding: quoted-printable

--- a/drivers/video/neofb.c	2005-12-19 19:47:20.000000000 +0100
+++ b/drivers/video/neofb.c	2005-12-22 02:39:32.000000000 +0100
@@ -852,8 +852,8 @@
=20
 	/* If the user did not specify any display devices, then... */
 	if (par->PanelDispCntlReg1 =3D=3D 0x00) {
-		/* Default to internal (i.e., LCD) only. */
-		par->PanelDispCntlReg1 |=3D 0x02;
+		/* Default to the value stored in the register. */
+		par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
 	}
=20
 	/* If we are using a fixed mode, then tell the chip we are. */

--vkogqOf2sHV7VnPd--

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ6r1Tl2m8MprmeOlAQIO1g/+MDl4cHCTb47/lNyOWwNnExvuWnKobS7A
Hx7qy/VJCva9a9MqeodiI9nVtP/vyL7dw1TM8O1IKN2RwupT72vpPbA4q2Glhl47
3XKhJ32HYPm+z69fnBXNDeqmXICitd1PHTilxUNeYZmNzIAs6F5kntYsoITtAOmA
egDrgWC7myv70kHuNdr8HRmDDNtqjt97G3veGZnZt0fKwBW+jffoTTh2h+CYrRnQ
Nb8jJAlQkHEUF2geOC1R/Jy8nGlm3L0uB4iNV6e4BR8xP+xoOTGMbS4dzvTt5nqj
gjW15LUvybLMSElacliUf6WJ+eOPOKNsCwjVG+r/IhabHHisRdul+Nx4Hk8ieFZQ
JVuR/0Z+QycaCmQo9Yx0rj7zDznVk4jVcy6yiLSzIJWRrItJjXx+uU5zf2WcAFz3
UhJl1sT29PJV57hvubKYthdHjio9wT5yOASvZfM6sew6mOURJYCyZ/cEVN3yQdZA
K27n+Rbhf5M+j8fGxkIOrh0/6apjEG+sfSTccS7Xufhpc7V+JoH2N0jpWBYEN89M
TH3V+ppGbvmiu+0Oa7tBrS4ExWLJjGP6OIheGKCC3KKWKd9jJWR5K5S/CfhvepQi
k22Aab/UzLhRPvQJRl/SBuybz7lIZz3hCMjnaYqg7Zzja8yRZ6jMM1knBHZwcaQK
Ob46Xf6L1fY=
=PXDl
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
