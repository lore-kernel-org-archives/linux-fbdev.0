From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fbdev hardware cursor support
Date: Wed, 25 May 2005 10:10:41 -0400
Message-ID: <9e4733910505250710643f8788@mail.gmail.com>
References: <9e473391050524224063df2372@mail.gmail.com>
	 <20050525061628.GA5396@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dawao-0005D8-Eu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 07:10:42 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dawao-0005xI-3R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 07:10:42 -0700
Received: by wproxy.gmail.com with SMTP id 69so686623wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 May 2005 07:10:41 -0700 (PDT)
In-Reply-To: <20050525061628.GA5396@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>

On 5/25/05, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
> On Wed, May 25, 2005 at 01:40:57AM -0400, Jon Smirl wrote:
> > What is the status of fbdev hardware cursor support? I see the ioctl
> > is disabled in the driver.
> >
> > If a driver is using the softcursor support would the ioctl control tha=
t cursor?
> > Does softcursor work in a bitmap graphics mode?
> >
> > The EGL based X server is going to need fbdev hardware cursors working.
>=20
> Why doesn't it draw the cursor using OpenGL? On many cards the hardware
> cursor is too limited to allow nice looking cursors.

Software generated will be supported sooner or later but the code is
not written yet.

What about video overlays? When the cursor goes out of the OpenGL area
and into the video one it has to be hardware generated.

A hardware cursor is also easier for me in the unstable drawing
environment or a server under development.


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
