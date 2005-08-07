From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Sun, 7 Aug 2005 19:48:31 -0400
Message-ID: <9e47339105080716487e59df5c@mail.gmail.com>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
	 <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
	 <20050807094618.0cc4cadc.akpm@osdl.org>
	 <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
	 <42F699DC.20103@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1usf-0007T2-Px
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:48:37 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1usf-0003AF-KE
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:48:38 -0700
Received: by wproxy.gmail.com with SMTP id i17so440393wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 16:48:31 -0700 (PDT)
In-Reply-To: <42F699DC.20103@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

On 8/7/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> James Simmons wrote:
> >
> >> I'll also drop fbdev-dont-allow-softcursor-use-from-userland.patch as =
there
> >> seems to be quite a bit of controversy there.
> >
> > The disagreement was how much to change it at one time. Some patches wh=
ere
> > just huge and did massive changes to all drivers. I wanted to break the=
 patch
> > up into little pieces. Please apply this patch otherwise we will be stu=
ck
> > where we are.
> >

James, if you are really worried about our patch to move softcursor
into fbcon, why don't we put it into the -mm tree for a month without
moving it to the main kernel and see if anyone complains.

I am definitely of the belief that since softcursor can only be used
by fbcon then it should be moved into fbcon and all support for it be
dropped from fbdev. We can't leave the code as is since it interferes
with the use of the hardware cursors from user space.

I just don't think this patch is as complex as you are making it out
to be. It is large simply because the same action has been repeated
for each of the 65 drivers. The action is only a simple deletion of
two lines.

> Please, my patch (based from Jon's) is huge because it's removing > 200 l=
ines
> and it's moving softcursor.c from drivers/video to drivers/video/console =
where
> it belongs. But it is _not_ intrusive.  In fact, the majority of the patc=
h consists
> of a single logical change which removes the line below from each driver
>=20
> - .fb_cursor =3D softcursor;
>=20
> and removes the line below from drivers/video/Kconfig.
>=20
> - select FB_SOFT_CURSOR
>=20
> Our proposal aims to make complex code simpler and big code smaller. Your=
 patch,
> on the other hand, although small, introduces another flag  FB_HWCURSOR_S=
OFTCURSOR,
> which is redundant, and adds yet another level of complexity to an alread=
y too
> complex code.
>=20
> I already have the patch, but I'm not pushing it yet because of an ongoin=
g
> disagreement, in courtesy to other developers such as yourself.
>=20
> Tony

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
