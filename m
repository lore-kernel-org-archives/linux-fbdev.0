From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: ATI Rage XL on x86_64
Date: Wed, 26 Jan 2005 12:54:59 +0200
Message-ID: <20050126105459.GA13231@sci.fi>
References: <200501260910.14102.andrew@walrond.org> <200501260939.48156.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtkpF-0003bH-FK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 02:55:05 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CtkpD-0001eq-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 02:55:05 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 5F1AAA89ED
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Jan 2005 12:55:00 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <200501260939.48156.andrew@walrond.org>
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

On Wed, Jan 26, 2005 at 09:39:48AM +0000, Andrew Walrond wrote:
> On Wednesday 26 January 2005 09:10, Andrew Walrond wrote:
>=20
> Sorry the second parameter line should have been
>  video=3Datyfb:mode:1024x768

atyfb:1024x768 is the correct format.

You can also add depth and/or refresh rate eg. atyfb:1024x768-8@60

> A 1280x1024 TFT screen is attached BTW

Digital or analog? The driver doesn't touch any of the TDMS registers so =
I=20
don't know if digital flat panels will work.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
