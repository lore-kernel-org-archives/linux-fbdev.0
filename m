From: Jurriaan <thunder7@xs4all.nl>
Subject: accelerated radeonfb produces artifacts on scrolling in 2.6.7
Date: Wed, 16 Jun 2004 20:24:15 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040616182415.GA8286@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Baf5e-0001pt-Kz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 11:24:50 -0700
Received: from smtp-out2.xs4all.nl ([194.109.24.12])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Baf5e-0002EB-22
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 11:24:50 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out2.xs4all.nl (8.12.10/8.12.10) with ESMTP id i5GIOkb0033578
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Jun 2004 20:24:47 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

The radeonfb driver in 2.6.7 produces some interesting artifacts on
scrolling, both scrolling horizontally and vertically.

When scrolling vertically (in mutt, in slrn, in less) some lines
move horizontally, and corruption occurs. Not all scrolling produces
artifacts, but fairly often.

When scrolling horizontally (most obvious in angband -mcu with the
option 'keep the screen centered' on) corruption appears at once.

Booting with 'noaccel' fixes the problems, but is slow, of course.

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AQ [Radeon 9600]

Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-16@85
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=324.00 Mhz, System=182.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon AQ  SDR SGRAM 128 MB
Console: switching to colour frame buffer device 133x54

Any hints would be appreciated.

Jurriaan
-- 
All lies all lies all schemes all schemes
Every winner means a loser in the western dream.
	News Model Army - Western Dream
Debian (Unstable) GNU/Linux 2.6.7-rc3-mm2 2x6078 bogomips load load 1.74


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
