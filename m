From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb (2.6): Add RGB565 support
Date: Fri, 14 May 2004 07:53:34 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040514045334.GA2693@sci.fi>
References: <20040511213607.GB6854@sci.fi> <Pine.GSO.4.58.0405121110360.19967@waterleaf.sonytel.be> <20040512185724.GA825@sci.fi> <Pine.GSO.4.58.0405131121210.9790@waterleaf.sonytel.be> <40A41CD3.2010908@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUhZ-0005oW-1q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 21:53:41 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUhY-0000Em-QL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 21:53:41 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 6AD471148724
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 07:53:35 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <40A41CD3.2010908@undead.cc>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, May 13, 2004 at 09:11:47PM -0400, John Zielinski wrote:
> Geert Uytterhoeven wrote:
>=20
> >It's always possible there's a bug in fbtest w.r.t. 565 handling, but =
I=20
> >didn't
> >see it.
> >=20
> >
>=20
> It's a bug in fbtest's directcolor routines.   Directcolor sets the clu=
t=20
> using using the min of the RGB sizes so 565 becomes 555.  The problem i=
s=20
> that tests 4, 8 and 9 use the buffer as 565 (VISUAL_GENERIC &=20
> VISUAL_TRUECOLOR) and the directcolor routines don't reset the clut to=20
> it's full range.  Fix attached.

Looks perfect with this patch.

However I just realized that the atyfb patch will not work correctly with=
=20
partial color map updates. Revised patch coming up...

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
