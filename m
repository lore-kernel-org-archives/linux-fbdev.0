From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Fri, 5 Nov 2004 17:30:27 +0200
Message-ID: <20041105153027.GA207@sci.fi>
References: <1099448020.900.25.camel@gaston> <20041103032613.GA3677@sci.fi> <1099633776.9260.160.camel@gaston> <20041105093618.GA15762@sci.fi> <Pine.GSO.4.61.0411051052490.15464@waterleaf.sonytel.be> <1099655227.3946.17.camel@gaston> <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ62q-0007hH-AW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:30:32 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ62p-0000Oa-Ia
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:30:32 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Fri, Nov 05, 2004 at 01:15:35PM +0100, Geert Uytterhoeven wrote:
> On Fri, 5 Nov 2004, Benjamin Herrenschmidt wrote:
> > > But every existing application that uses (shiver) the kernel header=
s will break
> > > after this change...
> >=20
> > Geert, can you explain the whole story please ?
>=20
> The story about the +1 or the story about the breakage?
>=20
> The Story About The +1
> ----------------------
> Since the VESA levels do not provide a way to blank (`make it black') t=
he
> screen, the +1 is introduced. Hence 0 means unblank, 1 means black scre=
en, 2
> means lowest power save level, and so on...
>=20
> The Story About The Breakage
> ----------------------------
> Every application that passes VESA_*+1 will break when recompiled, sinc=
e (most
> of) the VESA_* values are incremented by 1 by the patch.

My proposed patch doesn't touch the VESA_* values. It just adds new=20
constants which match the VESA_*+1 convention. That way old apps will=20
continue to work and developers don't have to guess what values are=20
actully legal.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
