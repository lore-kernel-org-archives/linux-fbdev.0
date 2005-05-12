From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Mapping the framebuffer into kernel space
Date: Thu, 12 May 2005 16:12:31 -0400
Message-ID: <9e473391050512131268248c3f@mail.gmail.com>
References: <9e473391050428205517f3c8c0@mail.gmail.com>
	 <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org>
	 <9e47339105050517083fadaee0@mail.gmail.com>
	 <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org>
	 <9e47339105050615097bdfcdcb@mail.gmail.com>
	 <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org>
	 <Pine.LNX.4.62.0505121112320.15959@numbat.sonytel.be>
	 <Pine.LNX.4.56.0505121648020.19137@pentafluge.infradead.org>
	 <9e47339105051210385a41e54e@mail.gmail.com>
	 <Pine.LNX.4.62.0505122151530.16269@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWK9J-0007Eb-9k
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 13:19:13 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DWK9H-00025A-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 13:19:13 -0700
Received: by wproxy.gmail.com with SMTP id 69so613138wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 May 2005 13:19:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0505122151530.16269@numbat.sonytel.be>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On 5/12/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Before we get too far into this, has anyone determined if any user
> > space app exists that does read/write from fbdev? I can't see a real
> > need to keep this feature if no one is using it. If no one is using
> > it, it would be much simpler just to remove the functions.
>=20
> I think the only programs really using this are some screenshot programs,=
 like
> cfb8toppm (which I wrote as a frame buffer sample program many years ago)=
,
> fbshot, and fbgrap (in Debian).
>=20
> Of course these can be converted to use mmap().

Seems to me that it would be easier to drop the feature and update the apps=
.


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
