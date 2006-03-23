From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium II framebuffer
Date: Thu, 23 Mar 2006 22:09:12 +1100
Message-ID: <21d7e9970603230309h5e74bfbajc3f07efd6c41bac3@mail.gmail.com>
References: <4421DCD7.6010908@gmail.com>
	 <20060323004734.31741.qmail@web52911.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMNgp-0000mp-CK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 03:09:15 -0800
Received: from [64.233.182.190] (helo=nproxy.gmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMNgo-00009d-N3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 03:09:15 -0800
Received: by nproxy.gmail.com with SMTP id a4so295736nfc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 03:09:12 -0800 (PST)
In-Reply-To: <20060323004734.31741.qmail@web52911.mail.yahoo.com>
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
Content-Type: text/plain; charset="windows-1252"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, vandrove@vc.cvut.cz

On 3/23/06, Chris Rankin <rankincj@yahoo.com> wrote:
> Hmm, the effect is no longer happening on my console, although it was at =
a consistent height
> before. (As if someone thought that the framebuffer had fewer lines than =
it actually did.)
>

Happens for me with my intelfb tree, on first entry to fbcon.. a VT
switch fixes it...

Dave.

> The machine is a busy one that is awkward to reboot. I'll try and schedul=
e something.
>
> Cheers,
> Chris
>
> --- "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> > Chris Rankin wrote:
> > > Hi,
> > >
> > > I have just booted vanilla 2.6.16, and am having trouble with the cur=
sor on my framebuffer
> > > console. The cursor tracks the column correctly, but appears on a lin=
e too high up the screen.
> >
> > How high? Is the offset constant?
> >
> > >
> > > All kernels up to 2.6.15 work correctly.
> >
> > Can you try booting with video=3Dmatroxfb:noaccel?
> >
> > Tony
> >
>
>
>
>
> ___________________________________________________________
> Yahoo! Photos =96 NEW, now offering a quality print service from just 8p =
a photo http://uk.photos.yahoo.com
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
> that extends applications into web and mobile media. Attend the live webc=
ast
> and join the prime developer group breaking into this new coding territor=
y!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
