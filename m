From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 21:11:03 +0200
Message-ID: <200707032111.03658.hjk@linutronix.de>
References: <200707031607.08511.hjk@linutronix.de>
	<468A9D26.5000808@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5nmH-00070G-9l for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 12:11:09 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5nmF-0002k2-S3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 12:11:09 -0700
In-Reply-To: <468A9D26.5000808@anagramm.de>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Thomas Gleixner <tglx@linutronix.de>, Clemens Koller <clemens.koller@anagramm.de>, linux-arm-kernel@lists.arm.linux.org.uk

Am Dienstag 03 Juli 2007 21:01 schrieb Clemens Koller:
> Hans-J=FCrgen Koch schrieb:
> > Index: linux-2.6.22-rc/include/asm-arm/arch-pxa/pxa-regs.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.22-rc.orig/include/asm-arm/arch-pxa/pxa-regs.h	2007-06-29=
 17:45:00.000000000 +0200
> > +++ linux-2.6.22-rc/include/asm-arm/arch-pxa/pxa-regs.h	2007-07-03 15:4=
6:20.000000000 +0200
> > @@ -1843,6 +1843,7 @@
> >  #define LCCR1		__REG(0x44000004)  /* LCD Controller Control Register 1=
 */
> >  #define LCCR2		__REG(0x44000008)  /* LCD Controller Control Register 2=
 */
> >  #define LCCR3		__REG(0x4400000C)  /* LCD Controller Control Register 3=
 */
> > +#define LCCR4		__REG(0x44000010)  /* LCD Controller Control Register 3=
 */
> =

> little typo...                                                           =
           ^^^^^

No, classical copy'n'paste error :-)

Thanks, fixed. Although I don't know yet if I'm allowed to define a =

PXA27x-only register in pxa-regs.h, any comments about that?

Hans


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
