From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 11:00:56 -0500
Message-ID: <9e47339105031208003cd3d834@mail.gmail.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <9e473391050312073314dcb39f@mail.gmail.com>
	 <20050312155139.GA28135@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA932-00044a-5R
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:01:04 -0800
Received: from rproxy.gmail.com ([64.233.170.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DA930-0001pE-O8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:01:04 -0800
Received: by rproxy.gmail.com with SMTP id z35so1851484rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 08:00:57 -0800 (PST)
In-Reply-To: <20050312155139.GA28135@sci.fi>
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

On Sat, 12 Mar 2005 17:51:39 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrot=
e:
> It's not a problem if one doesn't use X.Org/XFree86. Also this patch
> should not affect X.Org/XFree86 users unless they manage to call the
> FBIO_WAITFORVSYNC ioctl. matroxfb and atyfb both have similar interrupt
> support and X can still be used with both.

Almost all PPC Linux boxes are running radeonfb with Xorg.

>=20
> --
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&opclick
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
