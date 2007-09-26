From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
Date: Wed, 26 Sep 2007 18:33:08 +0200
Message-ID: <20070926163308.772580000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0587830179=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaZxW-0005pQ-Ns for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 09:41:59 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaZxV-0002uQ-5W
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 09:41:58 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org

--===============0587830179==

	Hi,

Here are some new patches for the PS3 AV Settings Driver (ps3av), which is
used in close collaboration with the PS3 Virtual Frame Buffer Device Driver
(ps3fb):
  [1] ps3av: eliminate unneeded temporary variables
  [2] ps3av: eliminate PS3AV_DEBUG
  [3] ps3av: use PS3 video mode ids in autodetect code
  [4] ps3av: treat DVI-D like HDMI in autodetect
  [5] ps3av: add autodetection for VESA modes
  [6] ps3av: add quirk database for broken monitors
  [7] ps3av: remove unused ps3av_set_mode()
  [8] ps3av: don't distinguish between `boot' and `non-boot' autodetection

Please review, and queue for 2.6.24 if they're ok. Thanks!

Question: As several DVI-D displays advertise they support 1080i modes while
they actually don't (cfr. the quirk database), perhaps I should drop 1080i
modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
better than 1080i anyway.  What do you think?

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village ������ Da Vincilaan 7-D1 ������ B-1935 Zaventem ������ Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 ������ B-1840 Londerzeel ������ Belgium	
VAT BE 0413.825.160 ������ RPR Brussels	
Fortis Bank Zaventem ������ Swift GEBABEBB08A ������ IBAN BE39001382358619



--===============0587830179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0587830179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0587830179==--
