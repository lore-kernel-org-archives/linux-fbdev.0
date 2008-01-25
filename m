From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 00/11] ps3av/3fb patches for 2.6.25
Date: Fri, 25 Jan 2008 16:06:23 +0100
Message-ID: <20080125150623.202631389@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0132365733=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JIQXz-00021h-Ik for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:32:51 -0800
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JIQXy-0004fn-0j
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jan 2008 07:32:51 -0800
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org

--===============0132365733==

	Hi Tony, Andrew,

Hare are the ps3av/fb patches for 2.6.25:
  [1] ps3av: ps3av_get_scanmode() and ps3av_get_refresh_rate() are unused
  [2] ps3: Use symbolic names for video modes
  [3] ps3fb: Kill PS3FB_FULL_MODE_BIT
  [4] ps3fb: Inline macros that are used only once
  [5] ps3fb: Kill ps3fb_res[]
  [6] ps3fb: Make frame buffer offsets unsigned int
  [7] ps3fb: Add support for configurable black borders
  [8] ps3fb: Reorganize modedb handling
  [9] ps3fb: Round up video modes
  [10] ps3fb: Cleanup sweep
  [11] ps3fb: Fix modedb typos

Patches 1-9 have been sent for review on Mon, 26 Nov 2007. They haven't
changed in the mean time, except for rebasing and minor editing of patch
descriptions.
Patches 10-11 are new, but not very complex, and tested in ps3-linux.git since
a while.

Please apply for 2.6.25. Thanks a lot!

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



--===============0132365733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0132365733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0132365733==--
