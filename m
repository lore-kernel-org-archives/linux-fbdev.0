From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: fbdev hardware cursor support
Date: Wed, 25 May 2005 11:32:45 -0400
Message-ID: <1117035165.5677.386.camel@localhost>
References: <9e473391050524224063df2372@mail.gmail.com>
	 <20050525061628.GA5396@sci.fi> <9e4733910505250710643f8788@mail.gmail.com>
	 <1117032624.5645.368.camel@localhost>
	 <9e47339105052508084ee66dd2@mail.gmail.com>
	 <1117034547.5506.376.camel@localhost>
	 <9e47339105052508301f9aaaa6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Daxsy-0006qO-AI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:33:32 -0700
Received: from mail-red.bigfish.com ([216.148.222.61] helo=mail79-R-red.bigfish.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Daxsv-0008P4-Ua
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:33:32 -0700
In-Reply-To: <9e47339105052508301f9aaaa6@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2005-05-25 at 11:30 -0400, Jon Smirl wrote:
> On 5/25/05, Michel D=C3=A4nzer <michel@daenzer.net> wrote:
> > On Wed, 2005-05-25 at 11:08 -0400, Jon Smirl wrote:
> > > On 5/25/05, Michel D=C3=A4nzer <michel@daenzer.net> wrote:
> > > > > Software generated will be supported sooner or later but the code=
 is
> > > > > not written yet.
> > > >
> > > > These claims of yours have been refuted on the dri-egl list. Why ar=
e you
> > > > repeating them here?
> > >
> > > I'm writing the Xegl server and I can tell you for sure that I haven'=
t
> > > written the software cursor support yet. How can you know the status
> > > of the Xgl code when I haven't checked it into CVS yet?
> >=20
> > David Reveman pointed out that Xglx has working software cursor code. I
> > can't see that caring about whether glitz uses a GLX or EGL backend.
>=20
> Xglx gets it software cursor support from the nested X server it runs
> inside of.

You didn't even read David's correction of this. Great.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
