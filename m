From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: Framebuffer newbie looking for
	documentation.
Date: Wed, 27 Dec 2006 13:40:16 +0000
Message-ID: <414D467D-3306-4174-A834-2DD58D972508@pobox.com>
References: <8d502f960612261814l6c219339ifa7a0c1467ef4401@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/mixed; boundary="===============1284718716=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GzZ17-00051e-6f for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 05:40:25 -0800
Received: from mail.netenviron.com ([212.18.24.150])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GzZ13-00065g-Lm
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 05:40:25 -0800
Received: from unknown (HELO [192.168.15.100]) (torgeir@[80.212.172.125])
	(envelope-sender <torgeir@pobox.com>)
	by mail.netenviron.com (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	27 Dec 2006 13:39:05 -0000
In-Reply-To: <8d502f960612261814l6c219339ifa7a0c1467ef4401@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--===============1284718716==
Content-Type: multipart/alternative; boundary=Apple-Mail-1--58944635


--Apple-Mail-1--58944635
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On 27 Dec 2006, at 02:14, Chris Stones wrote:

>
> I am strugling to find documentation, but from reading linux/fb.h  
> it seems the only way to do this is with the FBIOGET_VBLANK  
> ioctl.... however, for unknown reasons, this is always returning -1  
> ( ERROR ! )

That means that the framebuffer module used doesn't support that  
ioctl. It's not implemented for all framebuffer modules. The matrox  
framebuffer has it, and I have posted a patch in the past for the  
radeon framebuffer.

Which framebuffer module are you using?

-- 
Torgeir Veimo
torgeir@pobox.com




--Apple-Mail-1--58944635
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><BR><DIV><DIV>On 27 Dec 2006, at =
02:14, Chris Stones wrote:</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite"><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><BR>I am strugling =
to find documentation, but from reading linux/fb.h it seems the only way =
to do this is with the FBIOGET_VBLANK ioctl.... however, for unknown =
reasons, this is always returning -1 ( ERROR ! )<SPAN =
class=3D"Apple-converted-space">=A0</SPAN><BR></SPAN></BLOCKQUOTE></DIV><D=
IV><BR class=3D"khtml-block-placeholder"></DIV>That means that the =
framebuffer module used doesn't support that ioctl. It's not implemented =
for all framebuffer modules. The matrox framebuffer has it, and I have =
posted a patch in the past for the radeon framebuffer.=A0<DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Which framebuffer module =
are you using?</DIV><DIV><BR><DIV> <SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>--=A0</DIV><DIV>Torgeir Veimo</DIV><DIV><A =
href=3D"mailto:torgeir@pobox.com">torgeir@pobox.com</A></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN></SPAN></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-1--58944635--


--===============1284718716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1284718716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1284718716==--
