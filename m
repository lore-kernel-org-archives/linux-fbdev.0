From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Fw: atyfb doesn't work for me
Date: Tue, 4 Apr 2006 18:16:55 +0300
Message-ID: <20060404151655.GA28811@sci.fi>
References: <20060404030318.3c80b12a.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQnHE-00059F-Dt
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 08:17:04 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FQnHB-000706-Pk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 08:17:04 -0700
Content-Disposition: inline
In-Reply-To: <20060404030318.3c80b12a.akpm@osdl.org>
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
Cc: Greg Stark <gsstark@mit.edu>

On Tue, Apr 04, 2006 at 03:03:18AM -0700, Andrew Morton wrote:
>=20
> Begin forwarded message:
>=20
> Date: 04 Apr 2006 01:18:44 -0400
> From: Greg Stark <gsstark@mit.edu>
> To: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: atyfb doesn't work for me
>=20
>=20
>=20
> When I try to load atyfb I get messages about "unsupported xclk source"=
 and
> "vclk out of range" and the fb devices don't seem to be active. That is=
,=20
>   fbset -fb /dev/fb?
> all say "no such device"
>=20
> I see there are module parameters to override some of these settings bu=
t I'm
> not clear where I would find the correct values to use. And surely the =
fb
> driver ought to be able to come up usable values on its own?\

Unfortunately atyfb relies on the BIOS to initialize the card. You seem=20
to have multiple cards in your system which won't work.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
