From: "Lothar Wassmann" <LW@KARO-electronics.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 19:14:58 +0200
Message-ID: <18058.33810.378130.695740@ipc1.karo>
References: <200707031607.08511.hjk@linutronix.de>
	<200707031703.53102.hjk@linutronix.de>
	<18058.28725.106989.860166@ipc1.karo>
	<200707031839.57252.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1338479520=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5lyd-0002ZC-GB for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:15:48 -0700
Received: from mail.karo-electronics.de ([213.146.116.110])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5lya-0005Ae-Mv
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:15:46 -0700
In-Reply-To: <200707031839.57252.hjk@linutronix.de>
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
To: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, Paulo Marques <pmarques@grupopie.com>, linux-arm-kernel@lists.arm.linux.org.uk

--===============1338479520==

Hi,

> > BTW: PXA255 doesn't have an LCCR4 register.
> 
> In that case I should insert some #ifdef CONFIG_PXA27x to have the
> new behaviour only on PXA270, right?
>
This would be incompatible with the efforts to have the same kernel
binary running on PXA25x as well as PXA27x.

Either check the cpuid or as Paulo mentioned just check if the
platform has defined a value for LCCR4 and assume that the platform
code knows when to specify it and when not.


Lothar Wassmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra���e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch���ftsf���hrer: Matthias Kaussen, Rolf Rosenstein
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============1338479520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1338479520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1338479520==--
