From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: URGENT: status of atyfb
Date: Tue, 3 Aug 2004 22:57:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408032257.51111.alex.kern@gmx.de>
References: <1091417497.7393.63.camel@gaston> <1091424085.7387.68.camel@gaston>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Px/DBmhW1uB2Hd4"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bs6Me-0004xf-HL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 13:58:28 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bs6Md-00081g-TL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 13:58:28 -0700
In-Reply-To: <1091424085.7387.68.camel@gaston>
Content-Disposition: inline
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ville =?utf-8?q?Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>


--Boundary-00=_Px/DBmhW1uB2Hd4
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag, 2. August 2004 07:21 schrieb Benjamin Herrenschmidt:
> Ok, I built an upstream tree with just the new atyfb in, and it breaks
> on the wallstreet powerbook (LT-G) here. I'm not sure what is wrong at
> this point, I'd say the clock stuff is incorrectly calculated.
>
> On PPC, you do not have access to BIOS tables. So driver starts with
> blowing up since the code for retreiving that from BIOS is unconditional
> (it should be X86 only).
>
> I disabled that, but then, the default values (which are the same as the
> old driver afaik) don't seem to be enough anymore to produce a correct
> output.
>
> Ben.
Hi, I do not have any information or hardware about PPC. Should it own 
something like OpenFirmware? In this case it is possible to read clock 
information from this.

I found, that we change a little behaviour. Please give a try for this 
patch...

Regards Alex

--Boundary-00=_Px/DBmhW1uB2Hd4
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="atyfb_base_difference.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb_base_difference.patch"

--- atyfb_base.c	2004-08-01 00:23:53.000000000 +0200
+++ atyfb_base.c.ppc	2004-08-03 22:54:17.211890752 +0200
@@ -336,7 +336,7 @@
 
 #define ATI_CHIP_264GTB    (ATI_MODERN_SET) 
 /*#define ATI_CHIP_264GTDVD  ?*/
-#define ATI_CHIP_264LTG    (ATI_MODERN_SET)
+#define ATI_CHIP_264LTG    (M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_EXTRA_BRIGHT)
 
 #define ATI_CHIP_264GT2C   (ATI_MODERN_SET | M64F_HW_TRIPLE)
 #define ATI_CHIP_264GTPRO  (ATI_MODERN_SET | M64F_HW_TRIPLE | M64F_FIFO_32 | M64F_RESET_3D)

--Boundary-00=_Px/DBmhW1uB2Hd4--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
