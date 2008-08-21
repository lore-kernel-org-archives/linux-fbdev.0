From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 3/13 v2] viafb: accel.c, accel.h
Date: Thu, 21 Aug 2008 22:30:57 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8285FDD@exchtp03.taipei.via.com.tw>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698F@exchtp03.taipei.via.com.tw>
	<20080819162303.5fc89c63.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1494981372=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWBBq-00015J-TJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 07:31:07 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KWBBn-0004sq-Cx
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 07:31:06 -0700
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
To: akpm@linux-foundation.org
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--===============1494981372==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9039A.86BC9BC0"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9039A.86BC9BC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
=20
It's our carelessness to check with x86_64 version. And thanks for =
reminding this.
The=20
=20
=20
>due to things like this:
>
>        MMIO_OUT32(VIA_REG_DSTBASE,
>                   ((u32) (info->screen_base) - (u32) viafb_FB_MM) >> =
3);
>
>now, we could just shut the warnings up by casting to (long) instead.

>But I wonder what's going on in there.  ->screen_base came from
>ioremap_nocache() and AFAIK there's no guarantee that this virtual
>address will be less than 4G on 64-bit machines?


>If the !VIA_MMIO code has no valid use then please just remove it.
>
>The VIA_MMIO!=3D0 macros inplicitly reference a local variable which is
>the kind of dopey programming trick which should not be performed in
>new code.  It would be much better to do
>
>static inline void via_writel(struct viafb_par *viaparinfo, int reg, =
u32 val)
>{
>        writel(val, viaparinfo->io_virt + reg);
>}
>
>and use that everywhere.
>
>It would also be quite acceptable to simply open-code the
>
>        writel(val, viaparinfo->io_virt + reg);
>
>at all callsites.
>
>Those macros may have made it easier to _write_ the code, but they make
>it harder to _read_ it.  That's a wrong tradeoff.

Yes, the code seems to be cleaner after removing the macro.=20
We define this macro for convenient debugging originally=20
(MMIO couldn't work due to some wired reason, we can=20
transfer to PORT easily by changing VIA_MMIO=3D0).=20
It is a real tradeoff.
=20
If necessary, we could modify this patch by following your
suggestions.=20
Should we do that? or they're already done by you?
Thanks.

------_=_NextPart_001_01C9039A.86BC9BC0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH 3/13 v2] viafb: accel.c, =
accel.h</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.5512" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText26233 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hi =
Andrew,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>It's our carelessness to check with x86_64 =
version. And thanks for reminding this.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>The </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>&gt;due to things like =
this:<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_DSTBASE,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((u32) (info-&gt;screen_base) - (u32) viafb_FB_MM) &gt;&gt; =
3);<BR>&gt;<BR>&gt;now, we could just shut the warnings up by casting to =
(long) instead.<BR></DIV></FONT>=0A=
<DIV dir=3Dltr><FONT size=3D2>&gt;But I wonder what's going on in =
there.&nbsp; -&gt;screen_base came from<BR>&gt;ioremap_nocache() and =
AFAIK there's no guarantee that this virtual<BR>&gt;address will be less =
than 4G on 64-bit machines?<BR><BR><BR>&gt;If the !VIA_MMIO code has no =
valid use then please just remove it.<BR>&gt;<BR>&gt;The VIA_MMIO!=3D0 =
macros inplicitly reference a local variable which is<BR>&gt;the kind of =
dopey programming trick which should not be performed in<BR>&gt;new =
code.&nbsp; It would be much better to do<BR>&gt;<BR>&gt;static inline =
void via_writel(struct viafb_par *viaparinfo, int reg, u32 =
val)<BR>&gt;{<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
writel(val, viaparinfo-&gt;io_virt + reg);<BR>&gt;}<BR>&gt;<BR>&gt;and =
use that everywhere.<BR>&gt;<BR>&gt;It would also be quite acceptable to =
simply open-code =
the<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
writel(val, viaparinfo-&gt;io_virt + reg);<BR>&gt;<BR>&gt;at all =
callsites.<BR>&gt;<BR>&gt;Those macros may have made it easier to =
_write_ the code, but they make<BR>&gt;it harder to _read_ it.&nbsp; =
That's a wrong tradeoff.<BR><BR>Yes, the code seems to be cleaner after =
removing the macro. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>We define this macro for convenient =
debugging originally </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>(MMIO couldn't work due to some wired =
reason, we can </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>transfer to PORT easily by changing =
VIA_MMIO=3D0). </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>It is a real tradeoff.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>If necessary, we could modify this patch =
by following your</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>suggestions. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>Should we do that? or they're already done =
by you?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>Thanks.</DIV></FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C9039A.86BC9BC0--


--===============1494981372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1494981372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1494981372==--
