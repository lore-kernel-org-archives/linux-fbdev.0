From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: Kernel Summit presentation
Date: Thu, 28 Jul 2005 09:24:17 -0400
Message-ID: <9e47339105072806242ef1dfbe@mail.gmail.com>
References: <200507281445.25521.patrakov@ums.usu.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dy8N5-0007JK-B4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 06:24:23 -0700
Received: from wproxy.gmail.com ([64.233.184.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dy8N5-0004jd-0s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 06:24:23 -0700
Received: by wproxy.gmail.com with SMTP id 36so398190wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 06:24:17 -0700 (PDT)
In-Reply-To: <200507281445.25521.patrakov@ums.usu.ru>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

On 7/28/05, Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
> Jon Smirl wrote:
>=20
> > I attached the slides from my kernel summit presentation. The major
> > change is that Linus does not want a new VT state. Instead we should
> > open a new VT, switch it to VT_GRAPHICS, and then refuse to
> > acknowledge VT swap requests. Dave Airlie did another presentation on
> > mode setting and suspend/resume.
> >
> > The simple overview: goal is to get rid of the current VT swap system
> > but replace it with something that looks just like it. To do this the
> > console is split into two halves.
> >
> > 1) kernel console - it is as simple as possible and always guaranteed
> > to work. It is simpler than current fbconsole. It automatically uses
> > whatever mode is set on the monitor. There is only one kernel console
> > - no VTs.
> >
> > 2) user console - implements your normal VTs. Fully accelerated,
> > supports Unicode, etc.
> >
> > No one was really against restructuring the consoles. There was
> > support for a console that always works even when something like X is
> > running.
>=20
> I am really interested in this, and want to help (with code, once
> architectural issues are solved). But there is a question:
>=20
> How should applications that currently rely upon a kernel VT system being
> present (e.g. Xorg, MPlayer, SDL) be modified? (I mean, is there any prop=
osed
> API for hunting for a free userspace VC?)

If you are really interested the first place to help is getting the
new Xegl Xserver working. It is discussed on the xorg, dri-devel and
dri-egl mailing lists at freedesktop.org.

We probably won't start working on the other console pieces until the
Xserver is ready. Without the Xserver it is hard to do anything in the
new environment.


>=20
> --
> Alexander E. Patrakov
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO Septem=
ber
> 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
