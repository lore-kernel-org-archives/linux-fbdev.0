From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Compiling Rage xlinit.c
Date: Sat, 15 May 2004 03:42:51 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040515004251.GA24091@sci.fi>
References: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org> <40A14FFC.102@bitworks.com> <40A520E8.20702@bitworks.com> <40A539EE.5050008@mvista.com> <40A54546.7080400@bitworks.com> <40A54CBC.8020603@mvista.com> <40A55CFB.60803@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOnGQ-0008BI-2J
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 17:42:54 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOnGP-00063i-NK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 17:42:53 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id B3F905440
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 May 2004 03:42:51 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <40A55CFB.60803@bitworks.com>
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

On Fri, May 14, 2004 at 06:57:47PM -0500, Richard Smith wrote:
> Steve Longerbeam wrote:
>=20
> >Is the M1 Rage XL? If not, I'm not sure xlinit.c will be of much use
> >to you. Keep in mind that xlinit.c was a serious reverse engineering
> >hack job. I used a PCI bus analyzer to capture the bus I/O activity
>=20
> Its not a XL directly but the programming manual is the same for all th=
e=20
> Rage based chips.  I haven't done a register to register compare but=20
> most every thing seems to jive with the docs I have.

Looking at the specs the chips look quite similar. XC is the basic model,=
=20
XL has a TDMS transmitter and Mobility has an LVDS transmitter + CRTC2.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
