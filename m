From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sat, 12 Mar 2005 17:12:36 +0000
Message-ID: <1110647557.5997.98.camel@atlantis.netenviron.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <20050312151318.GA27200@sci.fi>  <1110647422.4004.456.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAAAR-0007a0-I8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:12:47 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAAAO-0007ft-3c
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:12:47 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 6F5D970
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 12:12:33 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 190EA8B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 12:12:32 -0500 (EST)
In-Reply-To: <1110647422.4004.456.camel@localhost>
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

On Sat, 2005-03-12 at 12:10 -0500, Michel D=E4nzer wrote:
> On Sat, 2005-03-12 at 17:13 +0200, Ville Syrj=E4l=E4 wrote:
> >=20
> > Also adding support for FB_ACTIVATE_VBL should be quite simple now.
>=20
> You don't need an interrupt for that. You can choose via the
> CRTC_OFFSET_CNTL:CRTC_OFFSET_FLIP_CNTL bit whether the update of the
> CRTC offset should take effect immediately or on the next vertical
> blank.
>=20
> Personally, I'm not sure why something that needs this functionality
> can't use the DRM...

My interest for adding this is video playback. It's kind of hard to do
through the DRM.

--=20
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
