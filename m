From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fbdev hardware cursor support
Date: Wed, 25 May 2005 11:08:53 -0400
Message-ID: <9e47339105052508084ee66dd2@mail.gmail.com>
References: <9e473391050524224063df2372@mail.gmail.com>
	 <20050525061628.GA5396@sci.fi>
	 <9e4733910505250710643f8788@mail.gmail.com>
	 <1117032624.5645.368.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaxVA-0003fk-G2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:08:56 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DaxV8-0004Y0-VV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:08:56 -0700
Received: by wproxy.gmail.com with SMTP id 69so715467wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 08:08:54 -0700 (PDT)
In-Reply-To: <1117032624.5645.368.camel@localhost>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Michel Danzer <mdanzer@ati.com>

On 5/25/05, Michel D=E4nzer <michel@daenzer.net> wrote:
> > Software generated will be supported sooner or later but the code is
> > not written yet.
>=20
> These claims of yours have been refuted on the dri-egl list. Why are you
> repeating them here?

I'm writing the Xegl server and I can tell you for sure that I haven't
written the software cursor support yet. How can you know the status
of the Xgl code when I haven't checked it into CVS yet?

Personally I'd prefer to start with the hardware one which I know will
work. Drawing in Xgl is not stable and there is a good chance a
software generated cursor isn't going to work half of the time until
the code is fixed.

> > What about video overlays? When the cursor goes out of the OpenGL area
> > and into the video one it has to be hardware generated.
>=20
> We can worry about that once we've figured out how to expose video
> overlays in Xgl, especially with compositing...
>=20
>=20
> --
> Earthling Michel D=E4nzer      |     Debian (powerpc), X and DRI develope=
r
> Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenze=
r
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborat=
e
> online with coworkers and clients while avoiding the high cost of travel =
and
> communications. There is no equipment to buy and you can meet as often as
> you want. Try it free.http://ads.osdn.com/?ad_idt02&alloc_id=16135&opclic=
k
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
