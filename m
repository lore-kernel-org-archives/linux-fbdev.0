From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: URGENT: status of atyfb
Date: Wed, 4 Aug 2004 01:05:28 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040803220528.GA29548@sci.fi>
References: <1091417497.7393.63.camel@gaston> <1091424085.7387.68.camel@gaston> <200408032257.51111.alex.kern@gmx.de> <1091568340.1900.14.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bs7Pb-0001gl-Jv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 15:05:35 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bs7Pb-00059V-5K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 15:05:35 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 4363647082
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Aug 2004 01:05:29 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <1091568340.1900.14.camel@gaston>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Aug 04, 2004 at 07:25:40AM +1000, Benjamin Herrenschmidt wrote:
>=20
> Also, when just dropping the existing driver into the current linus tre=
e, the
> cursor code is blowing up, I don't know why yet, I suppose some changes=
 to the
> common code in the fbdev tree. I'll have a look.

I had (probably) the same oops when using the driver from bk on 2.6.5-mm6=
.=20
Alex's latest patch fixed it for me.


On a somewhat related note...
I'd like to know if my LT LCD register access patch works correctly. It=20
should allow the generic LCD code to work on LT. It's included in Alex's=20
latest patch. But since parsing the BIOS is out of the question you'd hav=
e=20
to hardcode the LCD parameters. Could you test it?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
