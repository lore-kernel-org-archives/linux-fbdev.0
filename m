From: Jaap van den Handel <jaap@quest-innovations.com>
Subject: Re: Kernel panic by write to console while switching consoles.
Date: Mon,  2 Aug 2004 13:18:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1091445502.410e22feafcb2@webmail.quest-innovations.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Brapn-0004lg-5q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Aug 2004 04:18:27 -0700
Received: from otto.isd-holland.nl ([62.221.254.21])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Brapm-00010P-OL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Aug 2004 04:18:27 -0700
Received: from quest-innovations.nl (62-221-244-197.dsl.fiberworld.nl [62.221.244.197])
	by otto.isd-holland.nl (Postfix) with ESMTP id 1B70036402F
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  2 Aug 2004 13:18:23 +0200 (CEST)
Received: (from apache@localhost)
	by quest-innovations.nl (8.11.6/8.11.6) id i72BIMI18862
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 2 Aug 2004 13:18:22 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

> the console is enabled very early in the boot process in order to print=
 some=20
> info about the boot process itself. Read start_kernel() in=20
> $(KERNEL_SOURCE)/init/main.c=20
> for more info=20

The console can be switched after the boot process has finished right?=20
When loading a driver module for example. Then it would also crash when s=
ombody=20
prints to the screen. Only when booting this change is quite big.=20

> This is a problem in 2.4, hopefully fixed by BenH in 2.6 by acquiring t=
he=20
> console semaphore at strategic places.=20
>=20
> Try placing acquire_console_sem(), release_console_sem() around the loo=
p=20
> in take_over_console() to disable early printing during console=20
> initialization.=20
>=20

Thanks for the reply, glad to know somebody is working on it.=20

Greetings=20
Jaap van den Handel

Confidentiality Note:
This e-mail and any attachments are confidential and the information here=
in
is property of Quest Innovations B.V.. If you are not the intended recipi=
ent(s) of this e-mail,you are hereby notified that any dissemination, dis=
tribution,=20
copying, use of or reliance upon the information contained within this e-=
mail=20
or attachments is unauthorized and strictly prohibited. If you have recei=
ved
this e-mail in error, please notify us immediately by returning it to the
sender and delete this copy from your system.

Quest Innovations B.V.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
