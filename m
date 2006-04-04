From: Greg Stark <gsstark@mit.edu>
Subject: Re: Fw: atyfb doesn't work for me
Date: 04 Apr 2006 12:50:18 -0400
Message-ID: <87d5fxb7zp.fsf@stark.xeocode.com>
References: <20060404030318.3c80b12a.akpm@osdl.org>
	<20060404151655.GA28811@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQojj-0008Q0-UN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 09:50:35 -0700
Received: from stark.xeocode.com ([216.58.44.227])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FQoji-00025E-Sj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 09:50:36 -0700
In-Reply-To: <20060404151655.GA28811@sci.fi>
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
To: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev-devel@lists.sourceforge.net, Greg Stark <gsstark@mit.edu>


Ville Syrj=E4l=E4 <syrjala@sci.fi> writes:

> Unfortunately atyfb relies on the BIOS to initialize the card. You seem=
=20
> to have multiple cards in your system which won't work.

Hum. And I was trying it out in the hopes of working around a bug in the =
X
server that's preventing it from initializing those cards (neither are th=
e
primary card).

There isn't some standalone user-space program to initialize them out the=
re is
there? Or anything else maybe that would help?


--=20
greg



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
