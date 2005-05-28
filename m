From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fbdev hardware cursor support
Date: Fri, 27 May 2005 20:31:19 -0400
Message-ID: <9e47339105052717311dc73685@mail.gmail.com>
References: <9e473391050524224063df2372@mail.gmail.com>
	 <20050525061628.GA5396@sci.fi>
	 <9e4733910505250710643f8788@mail.gmail.com>
	 <1117032624.5645.368.camel@localhost>
	 <9e47339105052508084ee66dd2@mail.gmail.com>
	 <1117034547.5506.376.camel@localhost>
	 <9e47339105052508301f9aaaa6@mail.gmail.com>
	 <1117035165.5677.386.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbpEZ-0002YK-PL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 17:31:23 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DbpEW-0001Iw-Aw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 17:31:23 -0700
Received: by wproxy.gmail.com with SMTP id 58so1511263wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 May 2005 17:31:19 -0700 (PDT)
In-Reply-To: <1117035165.5677.386.camel@localhost>
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
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 5/25/05, Michel D=E4nzer <michel@daenzer.net> wrote:
> > > David Reveman pointed out that Xglx has working software cursor code.=
 I
> > > can't see that caring about whether glitz uses a GLX or EGL backend.
> >
> > Xglx gets it software cursor support from the nested X server it runs
> > inside of.
>=20
> You didn't even read David's correction of this. Great.

Three days later I have software cursors working. It wasn't anywhere
near as simple as turning on a flag. They're ugly and they lag, but
they can probably be fixed with more effort.  I would have had the
hardware one up in a day at most since I knew exactly what was doing.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
