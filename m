From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Fw: atyfb doesn't work for me
Date: Tue, 4 Apr 2006 20:22:10 +0300
Message-ID: <20060404172210.GA7425@sci.fi>
References: <20060404030318.3c80b12a.akpm@osdl.org> <20060404151655.GA28811@sci.fi> <87d5fxb7zp.fsf@stark.xeocode.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQpEQ-0003eM-0C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 10:22:18 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FQpEO-0000z7-KS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 10:22:18 -0700
Content-Disposition: inline
In-Reply-To: <87d5fxb7zp.fsf@stark.xeocode.com>
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
To: Greg Stark <gsstark@mit.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Apr 04, 2006 at 12:50:18PM -0400, Greg Stark wrote:
>=20
> Ville Syrj=E4l=E4 <syrjala@sci.fi> writes:
>=20
> > Unfortunately atyfb relies on the BIOS to initialize the card. You se=
em=20
> > to have multiple cards in your system which won't work.
>=20
> Hum. And I was trying it out in the hopes of working around a bug in th=
e X
> server that's preventing it from initializing those cards (neither are =
the
> primary card).
>=20
> There isn't some standalone user-space program to initialize them out t=
here is
> there? Or anything else maybe that would help?

There's vbetool but I don't think it handles secondary cards.

IIRC SciTech had some solution to the problem... and google found it :)
http://www.scitechsoft.com/ftp/snap/linux/videoboot/

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
