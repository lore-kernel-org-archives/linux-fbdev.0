From: Grahame Bowland <grahame@angrygoats.net>
Subject: RadeonFB
Date: Tue, 24 Feb 2004 01:03:07 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077555787.1672.7.camel@solitaire.cook.theducks.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-n3fjcy7NsqvehV5sH2ja"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvJbm-0004EP-5y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 09:11:06 -0800
Received: from asclepius.uwa.edu.au ([130.95.128.56])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvJU3-00052H-H7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 09:03:07 -0800
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by dummy.domain.name (Postfix) with SMTP id 9C9F83676CE
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 Feb 2004 01:03:04 +0800 (WST)
Received: from billy.angrygoats.net (billy.angrygoats.net [130.95.86.253])
	by asclepius.uwa.edu.au (Postfix) with ESMTP id 95DC33676C7
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 Feb 2004 01:03:04 +0800 (WST)
Received: from solitaire.cook.theducks.org (cook.theducks.org [203.22.197.49])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by billy.angrygoats.net (Postfix) with ESMTP id 83E331FE33
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 Feb 2004 01:02:59 +0800 (WST)
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


--=-n3fjcy7NsqvehV5sH2ja
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hi guys

I own a Sapphire Radeon 9700 PRO. It's never worked with radeonfb in the
past. I just installed Linux 2.6.3-mm3 and suddenly radeonfb will
actually load. However, if I try to fbset to any mode other than the
default, I end up with what looks like a corrupt version of the screen
the VGA bios displays when I turn on the computer.

Does anyone have any hints on what I could do to make progress on this?
I can program, but don't know where to start or what to try. I'm
attaching the relevant logged output after I insmod the radeonfb module
- I've compiled it with the new debugging option.

(in the past I was just getting a "radeonfb: cannot map map FB" logged)

Cheers!
Grahame


--=-n3fjcy7NsqvehV5sH2ja
Content-Disposition: attachment; filename=fbdev.txt
Content-Type: application/octet-stream; name=fbdev.txt
Content-Transfer-Encoding: 7bit

radeonfb_pci_register BEGIN
radeonfb: probed SDR SGRAM 131072k videoram
radeonfb: mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=325.00 Mhz, System=310.00 MHz
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Monitor Operating Limits: From EDID
     H: 30-98KHz V: 50-160Hz DCLK: 170MHz
radeonfb: ATI Radeon ND  SDR SGRAM 128 MB
radeonfb_pci_register END

--=-n3fjcy7NsqvehV5sH2ja--




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
