From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fbdev hardware cursor support
Date: Wed, 25 May 2005 11:52:32 -0400
Message-ID: <9e4733910505250852597a5cd5@mail.gmail.com>
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
	id 1DayBQ-0000r6-78
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:52:36 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DayBP-0005vd-HU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:52:35 -0700
Received: by wproxy.gmail.com with SMTP id 69so738603wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 08:52:34 -0700 (PDT)
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
> On Wed, 2005-05-25 at 11:30 -0400, Jon Smirl wrote:
> > On 5/25/05, Michel D=E4nzer <michel@daenzer.net> wrote:
> > > On Wed, 2005-05-25 at 11:08 -0400, Jon Smirl wrote:
> > > > On 5/25/05, Michel D=E4nzer <michel@daenzer.net> wrote:
> > > > > > Software generated will be supported sooner or later but the co=
de is
> > > > > > not written yet.
> > > > >
> > > > > These claims of yours have been refuted on the dri-egl list. Why =
are you
> > > > > repeating them here?
> > > >
> > > > I'm writing the Xegl server and I can tell you for sure that I have=
n't
> > > > written the software cursor support yet. How can you know the statu=
s
> > > > of the Xgl code when I haven't checked it into CVS yet?
> > >
> > > David Reveman pointed out that Xglx has working software cursor code.=
 I
> > > can't see that caring about whether glitz uses a GLX or EGL backend.
> >
> > Xglx gets it software cursor support from the nested X server it runs
> > inside of.
>=20
> You didn't even read David's correction of this. Great.

If there is a working software cursor implementation in Xgl I'm yet to
find it. Of course I am looking at 5,000+ lines of code without a
single comment other than the copyright notice. On the other hand I
can definitely see how the xnest cursor implementation is working.

Feel free to help with Xegl. I have stated several times that I know
nothing about the X input system. I've identified exactly where to
hook up hardware cursor support and that would let me proceed from
where I am at.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
