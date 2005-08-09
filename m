From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Mon, 8 Aug 2005 21:04:12 -0400
Message-ID: <9e473391050808180432253947@mail.gmail.com>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
	 <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
	 <20050807094618.0cc4cadc.akpm@osdl.org>
	 <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
	 <42F699DC.20103@gmail.com>
	 <Pine.LNX.4.56.0508090057460.2187@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2YvQ-0005ww-7I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 11:34:08 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2Yut-00072o-NQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 11:34:08 -0700
Received: by wproxy.gmail.com with SMTP id 36so1263426wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Aug 2005 11:33:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508090057460.2187@pentafluge.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

On 8/8/05, James Simmons <jsimmons@infradead.org> wrote:
>=20
> > Please, my patch (based from Jon's) is huge because it's removing > 200=
 lines
> > and it's moving softcursor.c from drivers/video to drivers/video/consol=
e where
> > it belongs. But it is _not_ intrusive.  In fact, the majority of the pa=
tch consists
> > of a single logical change which removes the line below from each drive=
r
> >
> > - .fb_cursor =3D softcursor;
> >
> > and removes the line below from drivers/video/Kconfig.
> >
> > - select FB_SOFT_CURSOR
> >
> > Our proposal aims to make complex code simpler and big code smaller. Yo=
ur patch,
> > on the other hand, although small, introduces another flag  FB_HWCURSOR=
_SOFTCURSOR,
> > which is redundant, and adds yet another level of complexity to an alre=
ady too
> > complex code.
>=20
> I ask you the same question as Jon. Currently several fbdev drivers have =
a
> optional flag to turn on and off the hardware cursor. Should this functio=
nality

In the current code I don't view that flag as turning the hardware
cursor on/off. Instead I view it as choosing to use the software or
hardware cursor.  In my view the flag should be eliminated form fbdev.
If a driver has a hardware cursor it is always exposed.

fbconsole is then free to implement the flag if it chooses.

> be removed and force all fbdev drivers to always have the hardware cursor
> avaiable. Thus leaving fbcon to control when to use the hardware cursor
> or the software cursor. It all comes down to who controls when the
> hardware driver will use the hardware cursor. As noted several drivers
> have such a flag. You would have to strip that flag out of the drivers as
> well.


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
