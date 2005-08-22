From: Keith O'Conor <Keith.OConor@cs.tcd.ie>
Subject: Re: Hardware specs?
Date: Mon, 22 Aug 2005 17:46:08 +0100
Message-ID: <430A0150.1050904@cs.tcd.ie>
References: <43035F25.5000907@cs.tcd.ie> <1124581331.4877.94.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7FRZ-0004Y8-9Q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 09:46:41 -0700
Received: from relay.cs.tcd.ie ([134.226.32.56] helo=smtp.cs.tcd.ie)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E7FRX-0001sf-0Z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 09:46:41 -0700
Received: from smtp.cs.tcd.ie (localhost [127.0.0.1])
	by relay.cs.tcd.ie (Postfix) with ESMTP id D0A5D23C9
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Aug 2005 17:46:32 +0100 (IST)
Received: from [134.226.35.134] (pc1244.cs.tcd.ie [134.226.35.134])
	by smtp.cs.tcd.ie (Postfix) with ESMTP id 89A091CE1
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Aug 2005 17:46:32 +0100 (IST)
In-Reply-To: <1124581331.4877.94.camel@localhost>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Thanks for the reply. I've applied to the ATI Developer Relations=20
program under the project I'm working on, maybe they'll see fit to give=20
me some manuals - I'm only looking for details on chips circa 9200,=20
nothing too recent.

Until then, I've dug up Voodoo3 and Matrox G400 datasheets - I'll go=20
through the relevant code armed with these and see if I can figure=20
things out that way. I'm sure I'll have a question or two to ask you on=20
the way!

Thanks,
Keith

Michel D=C3=A4nzer wrote:

>On Wed, 2005-08-17 at 17:00 +0100, Keith O'Conor wrote:=20
> =20
>
>>Up until now I've been only developing graphics applications, so alot o=
f=20
>>these things are new to me - pixel clocks, horizontal timings, PLL, MTR=
R=20
>>etc.etc.... it's all quite overwhelming. I've been reading as much as I=
=20
>>can, but there are still big gaps in my understanding - how did everyon=
e=20
>>else get up to speed in this area?
>>   =20
>>
>
>I did it basically the way you're doing it, by reading and tweaking
>code. :)
>
>
> =20
>
>>My main problem is that although it's fairly easy to follow the radeonf=
b=20
>>source and the fb in general, when it comes to what register does what=20
>>I'm completely lost. Did the people who wrote the driver have technical=
=20
>>specs from ATI telling them which did what?=20
>>   =20
>>
>
>Some of us do, yes.
>
> =20
>
>>Are the specs openly available, only under NDA, or not at all?!
>>   =20
>>
>
>Only under NDA, and I'm afraid it's hard to get them even under that
>ATM. Your best way forward might be to ask specific questions about
>existing code.
>
>
> =20
>

_____________
Keith O'Conor
Image Synthesis Group
Computer Science Department
University of Dublin, Trinity College
http://isg.cs.tcd.ie/keith



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
