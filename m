From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Fri, 24 Jun 2005 12:27:33 -0400
Message-ID: <9e47339105062409276fcd5223@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be>
	 <9e47339105061518346d1df105@mail.gmail.com>
	 <200506161111.27115.adaplas@hotpop.com>
	 <9e4733910506152037193300fa@mail.gmail.com>
	 <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
	 <9e473391050620173132ea1ce6@mail.gmail.com>
	 <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org>
	 <9e473391050624052640aa5279@mail.gmail.com>
	 <Pine.LNX.4.56.0506241713210.14981@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dlr1k-0007xX-8p
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 09:27:36 -0700
Received: from wproxy.gmail.com ([64.233.184.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dlr1i-0003KW-FT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 09:27:36 -0700
Received: by wproxy.gmail.com with SMTP id 69so433225wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jun 2005 09:27:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0506241713210.14981@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 6/24/05, James Simmons <jsimmons@www.infradead.org> wrote:
>=20
> > >         Now I was thinking instead of a massive move of the the softw=
are
> > > cursor we add a flag FBINFO_HWACCEL_CURSOR to tell us if we are using=
 a
> > > hardware cursor. This way for the sysfs interface you can test to see=
 if
> > > it is a hardware cursor and only allow userland to access a hardware
> > > cursor. Here is a patch for that. People please try it out.
> >
> > Your code will work, but it is conceptually what we want to do?
> > Software cursors are application specific. The soft cursor implemented
> > in fbdev really belongs to fbconsole.  If we get another in-kernel
> > user with a different update pattern (maybe they use the GPU) they
> > will want a different soft cursor. Shouldn't we just move the current
> > soft cursor into fbconsole? Given that software cursors are
> > application specific fbdev should not contain one.
>=20
> The only reason I'm against that is then when the developer with the
> different update pattern will create a new fbconsole. We could end up
> with several fbconsoles. I really like to keep it down to one. So I rathe=
r
> deal with several cursor implementation instead of several fbconsoles.
> Also remember that the software cursor is generically wrapped around the
> the imageblit function. Since imageblit is independent of the update
> pattern we will be okay.

To address your concern, leave softcursor as an fbdev module. But we
do need to remove all of those .fb_cursor =3D softcursor from all of the
fbdev modules. As long as those are there we can only have one
softcursor implementation.

Then any in-kernel user does this:
       /* First try the hardware cursor */
       if (info->fbops->fb_cursor)
               err =3D info->fbops->fb_cursor(info, &cursor);
       /* if that doesn't exist or didn't work, use the software one */
       if (err)
               soft_cursor(info, &cursor);

I want to remove the fallback to softcursor logic from fbdev, I don't
care if the softcursor modules stays part of fbdev, it's the fallback
logic that doesn't belong in the drivers. There is no need for all of
the drivers to reference softcursor.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
