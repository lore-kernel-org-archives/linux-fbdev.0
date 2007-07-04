From: "Lothar Wassmann" <LW@KARO-electronics.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Wed, 4 Jul 2007 08:56:28 +0200
Message-ID: <18059.17564.230349.634600@ipc1.karo>
References: <200707031607.08511.hjk@linutronix.de>
	<18058.28725.106989.860166@ipc1.karo>
	<468A7359.5010305@grupopie.com>
	<200707031845.57256.hjk@linutronix.de>
	<468A85A2.1070506@grupopie.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1969885106=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5ynS-0008Gm-49 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 23:57:06 -0700
Received: from mail.karo-electronics.de ([213.146.116.110])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5ynP-0004nM-Ud
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 23:57:05 -0700
In-Reply-To: <468A85A2.1070506@grupopie.com>
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
To: Paulo Marques <pmarques@grupopie.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

--===============1969885106==

Hi,

> should be enough for most users of 18bpp pxafb users: have a console 
> with a palette mode and then switch to non-palette mode and run whatever 
> windowing system supports 18bpp.
> 
For this to work the pxafb driver would need to support switching
video modes first (reallocating framebuffer memory when the size
changes) which is not the case currently.


Lothar Wassmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra���e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch���ftsf���hrer: Matthias Kaussen, Rolf Rosenstein
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============1969885106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1969885106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1969885106==--
