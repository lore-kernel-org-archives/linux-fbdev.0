From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 17:51:39 +0200
Message-ID: <20050312155139.GA28135@sci.fi>
References: <1110636406.5997.86.camel@atlantis.netenviron.com> <9e473391050312073314dcb39f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA8u5-0003Zt-Fr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 07:51:49 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DA8u2-0004TU-V6
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 07:51:49 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id D9583B9E9F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 17:51:39 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <9e473391050312073314dcb39f@mail.gmail.com>
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

On Sat, Mar 12, 2005 at 10:33:45AM -0500, Jon Smirl wrote:
> You can't do this without coordination from X and DRM. If either of
> those are in use you will lock the machine with this patch.  DRM also
> implements WAITFORVSYNC as well as other interrupts. If you clear the
> ISR DRM is going to stop working.
>=20
> X is a bigger problem. If the radeonfb adapter is not the primary X
> adapter, X is going to disable its IO/MEM access at the PCI level on
> VT switch. Your radeonfb will then take an interrupt and not be able
> to acknowledge it. This results in an interrupt loop and you rebooting
> your machine.
>=20
> See the "Who is stomping PCI config space?" thread in the x.org xserver=
 list.
>=20
> Because of these issues WAITFORVSYNC in radeondb has to wait for
> merged DRM/fbdev to be implemented.

It's not a problem if one doesn't use X.Org/XFree86. Also this patch=20
should not affect X.Org/XFree86 users unless they manage to call the=20
FBIO_WAITFORVSYNC ioctl. matroxfb and atyfb both have similar interrupt=20
support and X can still be used with both.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
