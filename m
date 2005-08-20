From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Hardware specs?
Date: Sat, 20 Aug 2005 19:42:11 -0400
Message-ID: <1124581331.4877.94.camel@localhost>
References: <43035F25.5000907@cs.tcd.ie>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6cyx-0000MU-JW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Aug 2005 16:42:35 -0700
Received: from darkcity.gna.ch ([195.226.6.9])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6cyw-0007QP-5B
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Aug 2005 16:42:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by darkcity.gna.ch (Postfix) with ESMTP id 531701D348E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Aug 2005 01:42:25 +0200 (CEST)
Received: from unknown by localhost (amavisd-new, unix socket)
 id client-XXU1PN4l for <linux-fbdev-devel@lists.sourceforge.net>;
 Sun, 21 Aug 2005 01:42:23 +0200 (CEST)
Received: from localhost (CPE001124084852-CM014500006147.cpe.net.cable.rogers.com [65.48.154.37])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by darkcity.gna.ch (Postfix) with ESMTP id C358C1D348E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Aug 2005 01:42:15 +0200 (CEST)
Received: from daenzer by localhost with local (Exim 4.52)
	id 1E6cya-0005tH-4v
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Aug 2005 19:42:12 -0400
In-Reply-To: <43035F25.5000907@cs.tcd.ie>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2005-08-17 at 17:00 +0100, Keith O'Conor wrote:=20
>=20
> Up until now I've been only developing graphics applications, so alot of=20
> these things are new to me - pixel clocks, horizontal timings, PLL, MTRR=20
> etc.etc.... it's all quite overwhelming. I've been reading as much as I=20
> can, but there are still big gaps in my understanding - how did everyone=20
> else get up to speed in this area?

I did it basically the way you're doing it, by reading and tweaking
code. :)


> My main problem is that although it's fairly easy to follow the radeonfb=20
> source and the fb in general, when it comes to what register does what=20
> I'm completely lost. Did the people who wrote the driver have technical=20
> specs from ATI telling them which did what?=20

Some of us do, yes.

> Are the specs openly available, only under NDA, or not at all?!

Only under NDA, and I'm afraid it's hard to get them even under that
ATM. Your best way forward might be to ask specific questions about
existing code.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
