From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: fbdev hardware cursor support
Date: Wed, 25 May 2005 10:50:23 -0400
Message-ID: <1117032624.5645.368.camel@localhost>
References: <9e473391050524224063df2372@mail.gmail.com>
	 <20050525061628.GA5396@sci.fi>  <9e4733910505250710643f8788@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaxE7-0000i0-1Z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 07:51:19 -0700
Received: from mail-haw.bigfish.com ([12.129.199.61] helo=mail1-haw-R.bigfish.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DaxE5-0001VO-6Z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 07:51:18 -0700
Received: from mail1-haw.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail1-haw-R.bigfish.com (Postfix) with ESMTP id 493DB3B6020
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 14:51:08 +0000 (UTC)
Received: from mail1.ati.com (mail1.ati.com [209.50.91.165])
	by mail1-haw.bigfish.com (Postfix) with ESMTP id 9DDA63B62C3
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 14:51:05 +0000 (UTC)
Received: from cvimc02.atitech.com (cvimc02.atitech.com [172.24.5.202])
	by mail1.ati.com (8.12.10/8.12.10) with ESMTP id j4PEopii008565
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 10:51:02 -0400
Received: from daenzer by localhost with local (Exim 4.50)
	id 1DaxDE-0000X5-N5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 10:50:24 -0400
In-Reply-To: <9e4733910505250710643f8788@mail.gmail.com>
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

On Wed, 2005-05-25 at 10:10 -0400, Jon Smirl wrote:
> On 5/25/05, Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi> wrote:
> > On Wed, May 25, 2005 at 01:40:57AM -0400, Jon Smirl wrote:
> > > What is the status of fbdev hardware cursor support? I see the ioctl
> > > is disabled in the driver.
> > >
> > > If a driver is using the softcursor support would the ioctl control t=
hat cursor?
> > > Does softcursor work in a bitmap graphics mode?
> > >
> > > The EGL based X server is going to need fbdev hardware cursors workin=
g.
> >=20
> > Why doesn't it draw the cursor using OpenGL? On many cards the hardware
> > cursor is too limited to allow nice looking cursors.
>=20
> Software generated will be supported sooner or later but the code is
> not written yet.

These claims of yours have been refuted on the dri-egl list. Why are you
repeating them here?


> What about video overlays? When the cursor goes out of the OpenGL area
> and into the video one it has to be hardware generated.

We can worry about that once we've figured out how to expose video
overlays in Xgl, especially with compositing...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
