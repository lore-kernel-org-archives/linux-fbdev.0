From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 0/4] Cell SPE logos
Date: Mon, 16 Jul 2007 15:55:50 +0200
Message-ID: <20070716135550.010775000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1185825376=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IAR8a-00051U-TQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Jul 2007 07:01:21 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IAR8Z-0005nB-D6
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Jul 2007 07:01:20 -0700
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

--===============1185825376==

The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardware
threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs).
When booting Linux, 2 penguins logos are shown on the graphical console by
the standard frame buffer console logo code.

To emphasize the existence of the SPEs (which can be used under Linux), we
added a second row of (smaller) helper penguin logos, one for each SPE.

A sample screenshot can be found at
http://www.kernel.org/pub/linux/kernel/people/geoff/cell/debian-penguin-shot.png
(or on the ps3linux T-shirts we wore at OLS :-)

Summaries:
  [1] fbdev: extract fb_show_logo_line()
  [2] fbdev: Add fb_append_extra_logo()
  [3] fbdev: SPE helper penguin logo
  [4] Cell: Draw SPE helper penguin logos

Compared to the previous submission, patches 2 and 4 were modified (cfr. the
changelogs in those patches).

Thanks for applying!

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



--===============1185825376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1185825376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1185825376==--
