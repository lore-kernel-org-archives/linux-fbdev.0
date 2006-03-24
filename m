From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium II framebuffer
Date: Fri, 24 Mar 2006 00:31:55 +0000 (GMT)
Message-ID: <20060324003155.83478.qmail@web52902.mail.yahoo.com>
References: <21d7e9970603231537l3074d8f9o1ffd9a168c996dd5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMaDj-0001zN-2n
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 16:32:03 -0800
Received: from web52902.mail.yahoo.com ([206.190.49.12])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FMaDh-0003KY-CK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 16:32:03 -0800
In-Reply-To: <21d7e9970603231537l3074d8f9o1ffd9a168c996dd5@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

--- Dave Airlie <airlied@gmail.com> wrote:
> Just to let you know what I do, I boot up in text mode, ssh in and
> modprobe my fb driver then fbcon... I don't touch the console during
> that time.. if I vt switch and come back it works fine..

If vt-switching "fixes" things then that would explain why I can't reprod=
uce this bug now.

Cheers,
Chris


	=09
___________________________________________________________=20
Does your mail provider give you FREE antivirus protection?=20
Get Yahoo! Mail http://uk.mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
