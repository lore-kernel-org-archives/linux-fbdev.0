From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sat, 12 Mar 2005 12:10:22 -0500
Message-ID: <1110647422.4004.456.camel@localhost>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <20050312151318.GA27200@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAA8M-0007VY-G7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:10:38 -0800
Received: from darkcity.gna.ch ([195.226.6.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAA8K-0002Qj-Vi
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:10:38 -0800
Received: from localhost (localhost [127.0.0.1])
	by darkcity.gna.ch (Postfix) with ESMTP id 408E418B5A8
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 18:10:31 +0100 (CET)
Received: from unknown by localhost (amavisd-new, unix socket)
 id client-XXdF5K55 for <linux-fbdev-devel@lists.sourceforge.net>;
 Sat, 12 Mar 2005 18:10:29 +0100 (CET)
Received: from localhost (CPE001124084852-CM014500006147.cpe.net.cable.rogers.com [65.48.154.37])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by darkcity.gna.ch (Postfix) with ESMTP id 1169B18B58C
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 18:10:27 +0100 (CET)
Received: from daenzer by localhost with local (Exim 4.50)
	id 1DAA87-0003dG-ON
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 12:10:23 -0500
In-Reply-To: <20050312151318.GA27200@sci.fi>
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
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, 2005-03-12 at 17:13 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
>=20
> Also adding support for FB_ACTIVATE_VBL should be quite simple now.

You don't need an interrupt for that. You can choose via the
CRTC_OFFSET_CNTL:CRTC_OFFSET_FLIP_CNTL bit whether the update of the
CRTC offset should take effect immediately or on the next vertical
blank.

Personally, I'm not sure why something that needs this functionality
can't use the DRM...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
