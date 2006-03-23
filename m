From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium II framebuffer
Date: Thu, 23 Mar 2006 00:47:34 +0000 (GMT)
Message-ID: <20060323004734.31741.qmail@web52911.mail.yahoo.com>
References: <4421DCD7.6010908@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMDzK-0005SP-1E
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 16:47:42 -0800
Received: from web52911.mail.yahoo.com ([206.190.49.21])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FMDzI-0006ic-PO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 16:47:42 -0800
In-Reply-To: <4421DCD7.6010908@gmail.com>
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
Content-Type: text/plain; charset="windows-1252"
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: vandrove@vc.cvut.cz

Hmm, the effect is no longer happening on my console, although it was at =
a consistent height
before. (As if someone thought that the framebuffer had fewer lines than =
it actually did.)

The machine is a busy one that is awkward to reboot. I'll try and schedul=
e something.

Cheers,
Chris

--- "Antonino A. Daplas" <adaplas@gmail.com> wrote:

> Chris Rankin wrote:
> > Hi,
> >=20
> > I have just booted vanilla 2.6.16, and am having trouble with the cur=
sor on my framebuffer
> > console. The cursor tracks the column correctly, but appears on a lin=
e too high up the screen.
>=20
> How high? Is the offset constant?
>=20
> >=20
> > All kernels up to 2.6.15 work correctly.
>=20
> Can you try booting with video=3Dmatroxfb:noaccel?
>=20
> Tony
>=20



	=09
___________________________________________________________=20
Yahoo! Photos =96 NEW, now offering a quality print service from just 8p =
a photo http://uk.photos.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
