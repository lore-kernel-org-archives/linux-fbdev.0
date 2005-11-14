From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: fbcon bug?
Date: Mon, 14 Nov 2005 21:13:40 +0200
Message-ID: <20051114191340.GA12139@sci.fi>
References: <4377F564.6000704@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ebjm7-0001A7-FE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:13:55 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ebjm4-000693-T8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:13:55 -0800
Content-Disposition: inline
In-Reply-To: <4377F564.6000704@comcast.net>
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

On Sun, Nov 13, 2005 at 09:24:36PM -0500, Zack Smith wrote:
> Hi all,
>=20
> I've noticed that 2.6.14, when a console switch occurs going
> from a console that is KD_TEXT to one that is KD_GRAPHICS,
> fbcon doesn't seem to immediately shut down the cursor. It appears
> to draw or undraw the cursor at least once before it disables
> cursor activity due to graphics mode.
>=20
> Does anybody know if this bug has been corrected in 14.1 or .2,
> or if anyone would mind if I go in and fix it?

I'm not sure if it's related but there is a cursor problem with atyfb.=20
When doing ioctl(... KD_GRAPHICS) the cursor remains visible in most=20
cases. Sometimes it does disappear properly but that is quite rare.=20
However doing a vt switch to another vt and back again seems to fix it=20
every time so I'm not sure it's the same problem you're seeing. None of=20
the other fb drivers I use implement a hardware cursor which is probably=20
the reason I'm only seeing it on atyfb.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
