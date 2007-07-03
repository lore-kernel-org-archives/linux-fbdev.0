From: "Lothar Wassmann" <LW@KARO-electronics.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 17:50:13 +0200
Message-ID: <18058.28725.106989.860166@ipc1.karo>
References: <200707031607.08511.hjk@linutronix.de>
	<468A6159.6000808@grupopie.com>
	<200707031703.53102.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1119027626=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5keZ-0007Qk-DB for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:50:59 -0700
Received: from mail.karo-electronics.de ([213.146.116.110])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5keW-0003by-Kp
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:50:59 -0700
In-Reply-To: <200707031703.53102.hjk@linutronix.de>
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
To: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, Paulo Marques <pmarques@grupopie.com>, linux-arm-kernel@lists.arm.linux.org.uk

--===============1119027626==

Hi,

> Can userspace applications work with such a weired format?
> If yes, I'm looking forward to your patch.
> 
At least framebuffer consoles don't work with that. So you should
add a configuration option that allows enabling the strange PXA pixel
formats only when CONFIG_FRAMEBUFFER_CONSOLE is not set.

BTW: PXA255 doesn't have an LCCR4 register.


Lothar Wassmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra���e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch���ftsf���hrer: Matthias Kaussen, Rolf Rosenstein
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============1119027626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1119027626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1119027626==--
