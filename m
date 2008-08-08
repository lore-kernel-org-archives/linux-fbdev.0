From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 1/13 v2] viafb: viafb.modes,
	viafb.txt
Date: Fri, 8 Aug 2008 23:01:58 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8285FD7@exchtp03.taipei.via.com.tw>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698D@exchtp03.taipei.via.com.tw>
	<Pine.LNX.4.64.0808081331130.420@anakin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0693509748=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRTVh-0000nu-HA for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 08:04:09 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRTVe-0002tl-Vo
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 08:04:08 -0700
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
To: geert@linux-m68k.org
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--===============0693509748==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8F967.FF8A96E0"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8F967.FF8A96E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Geert,
=20
It should be my carelessness. The check has been added in viafbdev.c =
already.=20
Do I need to re-send the patch for the documentation? Thanks for your =
reminding.
=20
BRs,
Joseph Chan

________________________________

From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
Sent: Fri 8/8/2008 7:32 PM
To: Joseph Chan
Cc: linux-fbdev-devel@lists.sourceforge.net; =
linux-kernel@vger.kernel.org; akpm@linux-foundation.org
Subject: Re: [PATCH 1/13 v2] viafb: viafb.modes, viafb.txt



On Fri, 8 Aug 2008, JosephChan@via.com.tw wrote:
> +    4. VX800 2D accelerator hasn't been supported in this driver yet. =
When
> +       using driver on VX800, one should add parameter =
"viafb_accel=3D0" to
> +       disable 2D accelerator.

Can't the driver detect this automatically, and disable the 2D
accelerator when running on a VX800?

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something =
like that.
                                                            -- Linus =
Torvalds




------_=_NextPart_001_01C8F967.FF8A96E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH 1/13 v2] viafb: viafb.modes, =
viafb.txt</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.5512" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText65264 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hi =
Geert,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>It should be my carelessness. =
</FONT><FONT face=3DArial size=3D2>The check has been added in =
viafbdev.c already. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Do I need to re-send the =
patch for the documentation? Thanks for your reminding.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>BRs,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Joseph Chan</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Geert Uytterhoeven =
[mailto:geert@linux-m68k.org]<BR><B>Sent:</B> Fri 8/8/2008 7:32 =
PM<BR><B>To:</B> Joseph Chan<BR><B>Cc:</B> =
linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; =
akpm@linux-foundation.org<BR><B>Subject:</B> Re: [PATCH 1/13 v2] viafb: =
viafb.modes, viafb.txt<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Fri, 8 Aug 2008, JosephChan@via.com.tw =
wrote:<BR>&gt; +&nbsp;&nbsp;&nbsp; 4. VX800 2D accelerator hasn't been =
supported in this driver yet. When<BR>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; using driver on VX800, one should =
add parameter "viafb_accel=3D0" to<BR>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable 2D =
accelerator.<BR><BR>Can't the driver detect this automatically, and =
disable the 2D<BR>accelerator when running on a =
VX800?<BR><BR>Gr{oetje,eeting}s,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Geert<BR><BR>--<BR>Geert =
Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org<BR><BR>In personal conversations with technical =
people, I call myself a hacker. But<BR>when I'm talking to journalists I =
just say "programmer" or something like =
that.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; -- Linus =
Torvalds<BR><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C8F967.FF8A96E0--


--===============0693509748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0693509748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0693509748==--
