From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: PATCH Proposal make FB_ACCEL_ private to the driver
Date: Mon, 28 Feb 2005 15:40:56 +0200
Message-ID: <20050228134056.GA5942@sci.fi>
References: <20050227032611.GB14968@systol.god.lan> <Pine.LNX.4.62.0502271926560.3143@numbat.sonytel.be> <20050227221715.GA16837@systol.god.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5l8v-0003Zq-Ev
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 05:41:01 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D5l8t-0001Q3-Ts
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 05:41:01 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 24482B9FF7
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Feb 2005 15:40:57 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20050227221715.GA16837@systol.god.lan>
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

On Sun, Feb 27, 2005 at 11:17:15PM +0100, Henk Vergonet wrote:
> On Sun, Feb 27, 2005 at 07:28:47PM +0100, Geert Uytterhoeven wrote:
> > On Sun, 27 Feb 2005, Henk Vergonet wrote:
> > I'm afraid you will never see this reply, as rememberme@systol.god.la=
n won't
> > resolve....
>=20
> It is intentional, but if it's a problem I can fix it.
>=20
> >=20
> > > I want to propose to localize the maintenance and registration of t=
he
> > > FB_ACCEL_ id's and remove it from the public fb.h include file.
> > >=20
> > > Motivation:
> > > - This removes an unneeded dependency to fb.h if an additional card=
s/chips are
> > >   introduced. (These id's are only interesting for the driver anyho=
w.=20
> > >   Only fbset will print out the id, but I'll doubt this is used by =
anyone.)
> >=20
> > Yes, it's used by userspace apps that need to know the graphics card =
type (e.g.
> > DirectFB and the good old XF68_FBDev).
>=20
> My point is not that there are no userspace utils that use it. But that
> we should lose this identifier in the public interface eventually becau=
se it introduces unneeded dependencies as stated in my earlier post.
>=20
> If it's used by userspace in any other way than for pure informational =
purposes:
> For example to make certain assumptions on hardware capabilities, locat=
ions of specific hardware registers ...) then that's ok but should be con=
sidered as a make-shift solution until we have found a better solution dr=
ivers/API.

And that is exactly how DirectFB uses it. Case closed :)

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
