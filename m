From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Vertical retrace interrupts?
Date: Fri, 31 Jan 2003 13:55:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030131135517.A9655@sci.fi>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org> <1043893384.1052.127.camel@localhost.localdomain> <1043927116.7576.40.camel@thor> <1043968889.1002.40.camel@localhost.localdomain> <1044012272.6540.14.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from velli.mail.jippii.net ([195.197.172.114])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eZkM-0002Xl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Jan 2003 03:54:14 -0800
Received: from simpukka.saunalahti.fi (simpukka.saunalahti.fi [195.74.0.20])
	by velli.mail.jippii.net (Postfix) with ESMTP id 57C2F1C62A5
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Jan 2003 13:54:09 +0200 (EET)
Received: (from syrjala@localhost) by simpukka.saunalahti.fi (8.8.5/8.8.3) id NAA10131 for linux-fbdev-devel@lists.sourceforge.net; Fri, 31 Jan 2003 13:55:17 +0200 (EET)
In-Reply-To: <1044012272.6540.14.camel@thor>; from michel@daenzer.net on Fri, Jan 31, 2003 at 12:24:33PM +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jan 31, 2003 at 12:24:33PM +0100, Michel D=E4nzer wrote:
> > Yes, I've seen the dri list archives, and adding support for this in
> > fbdev will result in code dupliation :-(.
> >=20
> > However, at least 3 people have mailed me that they are using their
> > somewhat old pc as a set top box with mplayer, DirectFB and i810fb. No
> > X.
>=20
> You don't need X to use the DRM, just some privileged client to
> initialize it.

It feels a bit silly to to use drm just for vsync interrupts. Besides
there are a lot of cards that don't have a drm driver but do have an fbdev
driver. IMHO fbdev is the logical place for this stuff.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
http://www.vasoftware.com
