From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] aty128fb: RGB565 console color fix
Date: Fri, 14 May 2004 08:00:55 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040514050055.GC2693@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUoc-000747-EF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 22:00:58 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUob-0002Yp-O6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 22:00:57 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 565134F2F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 08:00:56 +0300 (EEST)
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


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes console colors in RGB565 mode on aty128fb.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aty128fb-2.6-rgb565.patch"

diff -urN linux-orig/drivers/video/aty/aty128fb.c linux/drivers/video/aty/aty128fb.c
--- linux-orig/drivers/video/aty/aty128fb.c	2004-05-13 21:54:36.114529808 +0300
+++ linux/drivers/video/aty/aty128fb.c	2004-05-14 07:16:21.258569072 +0300
@@ -2092,7 +2092,7 @@
 			pal[regno] = (regno << 10) | (regno << 5) | regno;
 			break;
 		case 16:
-			pal[regno] = (regno << 11) | (regno << 6) | regno;
+			pal[regno] = (regno << 11) | (regno << 5) | regno;
 			break;
 		case 24:
 			pal[regno] = (regno << 16) | (regno << 8) | regno;

--CUfgB8w4ZwR/yMy5--


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
