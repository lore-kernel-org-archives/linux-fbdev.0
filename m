From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] neofb patches
Date: Fri, 30 Apr 2004 18:06:27 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040430150627.GB1543@sci.fi>
References: <Pine.LNX.4.44.0404291740560.1327-100000@phoenix.infradead.org> <1083275840.21436.148.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJZax-0006ez-3f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 08:06:31 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJZaw-0000kk-Jk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 08:06:30 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 3F004F372D1
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 30 Apr 2004 18:06:28 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <1083275840.21436.148.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="windows-1254"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Apr 30, 2004 at 07:57:20AM +1000, Benjamin Herrenschmidt wrote:
>=20
> > > Finally, the geometry of screens is something that has nothing to
> > > do in the kernel imho.
> >=20
> > I don't like micro kernel designs. This is way micro kernels handle t=
his=20
> > problem.
>=20
> This has nothing to do with microkernel design and everything to do wit=
h
> not bloating the kernel with things that don't to be there.

I would like the kernel to handle CRTCs and overlays in the same way, and=
=20
that way IMHO should be to calculate register values in userspace and jus=
t=20
have a few ioctls to have the kernel write them.

Set all registers ioctl:
Nothing special needed here I think.

Set buffer offset (pan/flip) ioctl:
This one should return the current vertical blank counter. It's needed fo=
r=20
proper triple buffering. It should also be able to choose when to flip=20
(immediately or vblank, on top/bottom/any field).

Wait for vertical blank ioctl:
This one should also return the current vblank counter. It should also be=
=20
able to wait for absolute and relative vblank counter values. Waiting for=
=20
relative=3D1 would insure you're at the vblank when it returns and waitin=
g=20
for absolute=3Dlast_flip_counter_value+1 would help with double buffering=
.


The main reason for userspace register calculation is that there are a lo=
t=20
of knobs in some hardware (especially with overlays). Trying to abstract=20
those without loosing any features would be a problem. And even the API=20
would cover all of todays graphics chip something new might come along in=
=20
the future and the API might become too limited.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
