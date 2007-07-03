From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 19:33:47 +0200
Message-ID: <200707031933.47099.hjk@linutronix.de>
References: <200707031607.08511.hjk@linutronix.de>
	<200707031839.57252.hjk@linutronix.de>
	<18058.33810.378130.695740@ipc1.karo>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5mG8-0004cF-4u for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:33:52 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5mG6-0000VC-Oz
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:33:52 -0700
In-Reply-To: <18058.33810.378130.695740@ipc1.karo>
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
To: Lothar Wassmann <LW@karo-electronics.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, Paulo Marques <pmarques@grupopie.com>, linux-arm-kernel@lists.arm.linux.org.uk

Am Dienstag 03 Juli 2007 19:14 schrieb Lothar Wassmann:
> Hi,
> 
> > > BTW: PXA255 doesn't have an LCCR4 register.
> > 
> > In that case I should insert some #ifdef CONFIG_PXA27x to have the
> > new behaviour only on PXA270, right?
> >
> This would be incompatible with the efforts to have the same kernel
> binary running on PXA25x as well as PXA27x.

OK, I see.

> 
> Either check the cpuid 

This is probably the right way to go if you actually want the binary
to run on both platforms.

> or as Paulo mentioned just check if the 
> platform has defined a value for LCCR4 and assume that the platform
> code knows when to specify it and when not.

Well, my patch adds this definition to pxa_regs.h. Anyway, this solution
also decides at compile time where the binary will run.

Thanks,
Hans


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
