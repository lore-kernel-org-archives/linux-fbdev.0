From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Redesign of kernel graphics interface
Date: Wed, 12 May 2004 00:29:30 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040511212930.GA6854@sci.fi>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org> <20040510182940.14049.qmail@web14924.mail.yahoo.com> <20040510223950.B2268@armor.freesurf.fr> <20040510204742.GA12863@guug.org> <20040511225711.A7384@armor.freesurf.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNeog-0000m7-6q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 14:29:34 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNeof-0004xe-SY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 14:29:34 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 306AF1142C22
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 May 2004 00:29:31 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20040511225711.A7384@armor.freesurf.fr>
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, May 11, 2004 at 10:57:11PM +0000, Nicolas Souchu wrote:
> On Mon, May 10, 2004 at 02:47:42PM -0600, Otto Solares wrote:
> > On Mon, May 10, 2004 at 10:39:50PM +0000, Nicolas Souchu wrote:
> > > Do apps manage their swap? No. I think the OS should be responsible=
 for
> > > placing the data (vertices, textures, commands) at the right/best p=
lace
> > > for the HW 3D engine and the client should only fill virtual memory=
.
> >=20
> > > http://www.freebsd.org/~nsouch/kgi4BSD
> >=20
> > Browsing through kgi.sf.net I found that they have proper multihead
> > and DDC2 support.
>=20
> True.

What does proper multihead mean here? If it means multihead with separate=
=20
framebuffers it doesn't seem much better than fbdev. Proper multihead wit=
h=20
shared framebuffer is a lot harder get right. It would need video memory=20
management in the kernel.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
