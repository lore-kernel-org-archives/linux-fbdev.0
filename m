From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Framebuffer Driver
Date: Fri, 21 Jan 2005 05:59:56 +0800
Message-ID: <200501210559.59271.adaplas@hotpop.com>
References: <E1CrbHR-000AkB-00.kirdevv-mail-ru@f7.mail.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrkMM-0001TV-T9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 14:00:58 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CrkMM-0002kR-Bo
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 14:00:58 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5C756D31154
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Jan 2005 21:59:59 +0000 (UTC)
In-Reply-To: <E1CrbHR-000AkB-00.kirdevv-mail-ru@f7.mail.ru>
Content-Disposition: inline
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
Content-Type: text/plain; charset="koi8-r"
To: linux-fbdev-devel@lists.sourceforge.net, =?koi8-r?q?=EB=C9=D2=C9=CC=CC=20=E9=D7=C1=CE=CF=D7=20?= <kirdevv@mail.ru>

On Thursday 20 January 2005 20:19, =EB=C9=D2=C9=CC=CC =E9=D7=C1=CE=CF=D7 wr=
ote:
> Hello
> My name is Kirill.
> I'am not professional programmer, but wrote framebuffer driver for
> my Cyberblade/i1 (Trident Microsystems) videocard.
> Driver work, but with troubles.
>
> Mode is only one for now -- 640x480-8@85.
> When module (i wrote it as module) loaded, kernel reports:
>
> Console: switching to colour frame buffer device 80x30
>
> Yes, console have 30 lines and 80 columns, but this 80 columns
> is very stretched over hirisontal. And font is very big and greasy
> and stretched too, although i set fb.fontname =3D=3D "font_vga_8x16".
> So, image of console looks like zoomed.

If you do see 80 chars in the horizontal and 30 lines of text, maybe that
is the normal appearance, especially if you have a very large display?  Also
if your monitor does not have a 4:3 aspect ratio, then the fonts could
appear stretched.

Why not try a higher resolution instead, at least 1024x768?

If you think the problem is different, why not post a link with a screenshot
of the console?

BTW, have you tried using other apps, such as X, fbtest, etc, and still
see the same problem?

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
