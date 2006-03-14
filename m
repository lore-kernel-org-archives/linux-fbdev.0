From: Fractallyte <fractallyte@csi.com>
Subject: Re: Re: Re: atyfb, console, kernel 2.6.14 & Sony Vaio C1VE
Date: Tue, 14 Mar 2006 17:10:00 +0000
Message-ID: <759672060d21cbb72d1f7e25a09a2f2e@csi.com>
References: <83d4769a9bceb571796228cb5c7534c3@csi.com> <20060303150123.GA27401@sci.fi> <60b1aebf4e1937a06ebff8cd92a8f4b3@csi.com> <20060312224354.GA1338@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJD2B-0008IB-9b
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Mar 2006 09:10:11 -0800
Received: from anchor-post-32.mail.demon.net ([194.217.242.90])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FJD29-00031d-O7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Mar 2006 09:10:11 -0800
Received: from serendip.demon.co.uk ([80.176.90.177] helo=[192.168.0.4])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1FJD22-0001K2-7u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Mar 2006 17:10:02 +0000
In-Reply-To: <20060312224354.GA1338@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Nice! ;-)  Fortunately, my laptop has a completely stable and reliable =20=

display.  It's definitely a kernel driver problem.  A patched 2.4 =20
kernel allows me to get the full-width 1024x480 console, but the 2.6 =20
kernel is very different.

I'm just looking at modedb.c - the standard video mode definitions =20
don't include 1024x480.  The 2.4 kernel patch modified this file; I'm =20=

wondering whether it would make a difference with the present kernel...

On 12 Mar 2006, at 22:43, Ville Syrj=E4l=E4 wrote:

> I was looking for the OB500 service manual and I stumbled on a HP =
forum
> thread discussing similar problems. It seems the "screen going white"
> problem may be caused by oxidation of the screen cable connectors.
>
> Here is the full thread:
> http://forums1.itrc.hp.com/service/forums/questionanswer.do?=20
> threadId=3D121645
>
> --=20
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
