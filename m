From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Reading the EDID block for x86 machines
Date: Wed, 12 Mar 2003 20:47:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030312204701.A1279@sci.fi>
References: <1047386934.1113.35.camel@localhost.localdomain> <20030312141022.A6984@sci.fi> <1047490638.1028.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from kura.mail.jippii.net ([195.197.172.113])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tBEG-0000VR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 10:45:28 -0800
Received: from simpukka.saunalahti.fi (simpukka.saunalahti.fi [195.74.0.20])
	by kura.mail.jippii.net (Postfix) with ESMTP id 4FC0B248D1F
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 20:45:25 +0200 (EET)
Received: (from syrjala@localhost) by simpukka.saunalahti.fi (8.8.5/8.8.3) id UAA01903 for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Mar 2003 20:47:01 +0200 (EET)
In-Reply-To: <1047490638.1028.29.camel@localhost.localdomain>; from adaplas@pol.net on Thu, Mar 13, 2003 at 01:38:19AM +0800
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

On Thu, Mar 13, 2003 at 01:38:19AM +0800, Antonino Daplas wrote:
> Matrox users are the fortunate few since the author implemented an i2c
> backend.

;)

> That's okay.  The get_EDID() function can get the EDID block several
> ways.
>=20
> 1.  via the driver if it has its own method of getting the EDID block
> (1st choice)
>=20
> 2.  via userland - EDID block (ie get-edid > edid.dmp) uploaded to
> driver via ioctl (2nd choice)
>=20
> 3.  through an arch-specific method -- VBE for x86, OF for PPC, etc
> (last choice)
>=20
> When a user changes monitors without rebooting, he/she can upload an
> edid block appropriate for the display.

Sounds good.

BTW are there public docs available about EDID & DDC? VESA doesn't like
poor open-source developers :(

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
