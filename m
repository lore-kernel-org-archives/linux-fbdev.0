From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 13/13] viafb: via_utility.c,
	via_utility.h, vt1636.c, vt1636.h
Date: Sat, 2 Aug 2008 09:03:03 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8285FCE@exchtp03.taipei.via.com.tw>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E78BE@exchtp03.taipei.via.com.tw>
	<20080630104407.6adf59ab@lxorguk.ukuu.org.uk>
	<20080801132316.GA2784@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2079521187=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP5WY-0001Ib-BS for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 18:03:10 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KP5WV-0001NQ-JE
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 18:03:10 -0700
Content-class: urn:content-classes:message
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
To: laforge@gnumonks.org, alan@lxorguk.ukuu.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--===============2079521187==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8F43B.8408FB84"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8F43B.8408FB84
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Harald and all,
=20
Sorry for the delay.
I've got a update one, and I still checked those items which were =
mentioned by community.
Also, before sending out the patches, I will do some tests on most VIA =
GFX chips to make sure the quality of driver.
I wish I could send the patches out next week.
=20
BRs,
Joseph

________________________________

From: Harald Welte [mailto:laforge@gnumonks.org]
Sent: Fri 8/1/2008 9:23 PM
To: Alan Cox
Cc: Joseph Chan; geert@linux-m68k.org; akpm@linux-foundation.org; =
linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH 13/13] viafb: =
via_utility.c,via_utility.h, vt1636.c, vt1636.h



On Mon, Jun 30, 2008 at 10:44:07AM +0100, Alan Cox wrote:

> I think at this point however the code is in a state where it would be
> more productive to merge it and then fix up the remaining smaller =
details
> than keep going round back to VIA to change it internally and return.

Well, I'm obviously not having any unbiased opinion on this anymore...
... but have a vital interest in getting this driver merged ;)

Joseph: Can you please give me an update about what the current state
of this driver merge is?  This message is the last one that I can find
ont this subject on linux-fbdev-devel, and it's already one month old.

Joseph: If there was any further work on this since your last
13-patch-posting in June, can you please provide me with the latest
driver patchset?  I'd be happy to help in cleaning this further up and
finally getting it mainline.

Thanks to everyone involved,
--
- Harald Welte <laforge@gnumonks.org>           =
http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. =
A6)



------_=_NextPart_001_01C8F43B.8408FB84
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [Linux-fbdev-devel] [PATCH 13/13] =
viafb: via_utility.c,via_utility.h, vt1636.c, vt1636.h</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.5512" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText10182 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hi Harald and =
all,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Sorry for the =
delay.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I've got a update one, and I =
still checked those items which were mentioned by community.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Also, before sending out the =
patches, I will do some tests on most VIA GFX chips to make sure the =
quality of driver.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I wish I could send the =
patches out next week.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>BRs,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Joseph</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Harald Welte =
[mailto:laforge@gnumonks.org]<BR><B>Sent:</B> Fri 8/1/2008 9:23 =
PM<BR><B>To:</B> Alan Cox<BR><B>Cc:</B> Joseph Chan; =
geert@linux-m68k.org; akpm@linux-foundation.org; =
linux-fbdev-devel@lists.sourceforge.net; =
linux-kernel@vger.kernel.org<BR><B>Subject:</B> Re: [Linux-fbdev-devel] =
[PATCH 13/13] viafb: via_utility.c,via_utility.h, vt1636.c, =
vt1636.h<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Mon, Jun 30, 2008 at 10:44:07AM +0100, Alan Cox =
wrote:<BR><BR>&gt; I think at this point however the code is in a state =
where it would be<BR>&gt; more productive to merge it and then fix up =
the remaining smaller details<BR>&gt; than keep going round back to VIA =
to change it internally and return.<BR><BR>Well, I'm obviously not =
having any unbiased opinion on this anymore...<BR>... but have a vital =
interest in getting this driver merged ;)<BR><BR>Joseph: Can you please =
give me an update about what the current state<BR>of this driver merge =
is?&nbsp; This message is the last one that I can find<BR>ont this =
subject on linux-fbdev-devel, and it's already one month =
old.<BR><BR>Joseph: If there was any further work on this since your =
last<BR>13-patch-posting in June, can you please provide me with the =
latest<BR>driver patchset?&nbsp; I'd be happy to help in cleaning this =
further up and<BR>finally getting it mainline.<BR><BR>Thanks to everyone =
involved,<BR>--<BR>- Harald Welte =
&lt;laforge@gnumonks.org&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; <A =
href=3D"http://laforge.gnumonks.org/">http://laforge.gnumonks.org/</A><BR=
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<BR>"Privacy in residential applications is a desirable marketing =
option."<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (ETSI EN 300 175-7 Ch. =
A6)<BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C8F43B.8408FB84--


--===============2079521187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2079521187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2079521187==--
