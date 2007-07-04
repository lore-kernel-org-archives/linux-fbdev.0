From: "Lothar Wassmann" <LW@KARO-electronics.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Wed, 4 Jul 2007 09:51:35 +0200
Message-ID: <18059.20871.731074.623866@ipc1.karo>
References: <200707031607.08511.hjk@linutronix.de>
	<200707032236.27461.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1487097911=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5zfE-0006D7-TF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jul 2007 00:52:40 -0700
Received: from mail.karo-electronics.de ([213.146.116.110])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5zfD-0000V0-51
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jul 2007 00:52:40 -0700
In-Reply-To: <200707032236.27461.hjk@linutronix.de>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Clemens Koller <clemens.koller@anagramm.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, Paulo Marques <pmarques@grupopie.com>

--===============1487097911==

Hi,

> +#define LCCR4_PAL_FOR_0 (0 << 15)
> +#define LCCR4_PAL_FOR_1 (1 << 15)
> +#define LCCR4_PAL_FOR_2 (2 << 15)
> +#define LCCR4_PAL_FOR_MASK (3 << 15)
>
Just a minor nitpicking. I would prefer names which represent the
_meaning_ of the constants rather than duplicating their value in the
name, like:
#define LCCR4_PALFOR_16		(0 << 15) /* 16 palette, 16 bit output */
#define LCCR4_PALFOR_16_T	(1 << 15) /* 25 bit palette, 16 bit output +transp. */
#define LCCR4_PALFOR_18		(2 << 15) /* 25 bit palette, 18 bit output */
#define LCCR4_PALFOR_24		(3 << 15) /* 25 bit palette, 24 bit output */


Lothar Wassmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra���e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch���ftsf���hrer: Matthias Kaussen, Rolf Rosenstein
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============1487097911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1487097911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1487097911==--
