From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: fbdev hardware cursor support
Date: Wed, 25 May 2005 11:22:27 -0400
Message-ID: <1117034547.5506.376.camel@localhost>
References: <9e473391050524224063df2372@mail.gmail.com>
	 <20050525061628.GA5396@sci.fi> <9e4733910505250710643f8788@mail.gmail.com>
	 <1117032624.5645.368.camel@localhost>
	 <9e47339105052508084ee66dd2@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Daxj8-0005Py-Hd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:23:22 -0700
Received: from mail-ash.bigfish.com ([206.16.192.253] helo=mail77-ash-R.bigfish.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Daxj5-0006lW-2N
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 08:23:21 -0700
Received: from mail77-ash.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail77-ash-R.bigfish.com (Postfix) with ESMTP id D272C3C2F69
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 15:23:12 +0000 (UTC)
Received: from mail1.ati.com (mail1.ati.com [209.50.91.165])
	by mail77-ash.bigfish.com (Postfix) with ESMTP id 8ADC43C2ED5
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 15:23:08 +0000 (UTC)
Received: from cvimc02.atitech.com (cvimc02.atitech.com [172.24.5.202])
	by mail1.ati.com (8.12.10/8.12.10) with ESMTP id j4PFMtii010418
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 11:23:05 -0400
Received: from daenzer by localhost with local (Exim 4.50)
	id 1DaxiH-0000qG-22
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 11:22:29 -0400
In-Reply-To: <9e47339105052508084ee66dd2@mail.gmail.com>
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

On Wed, 2005-05-25 at 11:08 -0400, Jon Smirl wrote:
> On 5/25/05, Michel D=C3=A4nzer <michel@daenzer.net> wrote:
> > > Software generated will be supported sooner or later but the code is
> > > not written yet.
> >=20
> > These claims of yours have been refuted on the dri-egl list. Why are yo=
u
> > repeating them here?
>=20
> I'm writing the Xegl server and I can tell you for sure that I haven't
> written the software cursor support yet. How can you know the status
> of the Xgl code when I haven't checked it into CVS yet?

David Reveman pointed out that Xglx has working software cursor code. I
can't see that caring about whether glitz uses a GLX or EGL backend.

> Personally I'd prefer to start with the hardware one which I know will
> work. Drawing in Xgl is not stable and there is a good chance a
> software generated cursor isn't going to work half of the time until
> the code is fixed.

And for the hardware cursor, you only need to:

      * enable/implement/improve (does what is disabled right now even
        remotely fit the needs of an X server? I didn't think so) the
        fbdev hardware cursor support
      * design and implement an EGL extension for it
      * add support for that to glitz
      * add support for that to Xegl

Indeed, that seems much easier and less prone to problems...


PS: Please don't add random e-mail addresses to the CC: list.

--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
