From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Sat, 23 Jul 2005 11:41:23 -0400
Message-ID: <9e473391050723084153d29566@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org>
	 <9e473391050701175679f468ff@mail.gmail.com>
	 <200507231305.59225.adaplas@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_567_20155621.1122133283592"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DwM83-0002PV-1q
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 23 Jul 2005 08:41:31 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DwM81-0005Bu-Nm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 23 Jul 2005 08:41:31 -0700
Received: by wproxy.gmail.com with SMTP id i3so699039wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 23 Jul 2005 08:41:23 -0700 (PDT)
In-Reply-To: <200507231305.59225.adaplas@gmail.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

------=_Part_567_20155621.1122133283592
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This not currently resolved.

From user space we can have two interfaces
1) the current ioctl one
2) the new stuff in sysfs. If the hardware cursor is there you get a sysfs=
=20
attribute named cursor. write x,y to it to move the cursor around. I'll add=
=20
the sysfs support as soon as we decide on the interface.

I'm still at OLS. Missed seeing both of you at KS. fbdev was discussed and=
=20
Linus went with Benh's proposal to move the modesetting API to user space.=
=20
Obviously this will have a lot of impact on fbdev.


On 7/23/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
>=20
> On Saturday 02 July 2005 08:56, Jon Smirl wrote:
> > Another way to think of this, let's make another member variable
> > .fb_hwcursor. When the driver has a hardware cusor is sets
> > .fb_hwcursor. If you want to use the software cursor use the exisiting
> > .fb_cursor.
> >
> > If you think about it every driver is going to have the exact same
> > assignment .fb_cursor =3D soft_cursor. If every driver is going to have
> > exactly the same assignment, why do we need the variable?
> >
> > It's the existence of the hardware cursor that varies from driver to
> > driver, that's the one we need the variable for.
>=20
> Is this resolved? I tend to agree with Jon. Let's just remove all
> references to soft_cursor from all drivers, and let fbcon_cursor() fall=
=20
> back
> to soft_cursor when xxxfb_cursor() is absent. It is a lot cleaner and=20
> saner
> this way, and although it touches all drivers, it is a singe logical=20
> change,
> so it's acceptable.
>=20
> Also, I think it might be preferable to have 2 cursor hooks, one
> is fbcon-specific, and the other is for use only in userspace, which need=
s
> to be more comprehensive. Or if a single but comprehensive cursor API is
> preferred, then we just adapt fbcon_cursor to use the more powerful
> cursor API.
>=20
> So, anyone want to propose a cursor API for fbdev, that is both usable by
> fbcon and userspace?
>=20
> Tony
>=20
>=20
>=20


--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_567_20155621.1122133283592
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This not currently resolved.<br>
<br>
From user space we can have two interfaces<br>
1) the current ioctl one<br>
2) the new stuff in sysfs. If the hardware cursor is there you get a
sysfs attribute named cursor. write x,y to it to move the cursor
around. I'll add the sysfs support as soon as we decide on the
interface.<br>
<br>
I'm still at OLS. Missed seeing both of you at KS. fbdev was discussed
and Linus went with Benh's proposal to move the modesetting API to user
space. Obviously this will have a lot of impact on fbdev.<br>
<br><br><div><span class=3D"gmail_quote">On 7/23/05, <b class=3D"gmail_send=
ername">Antonino A. Daplas</b> &lt;<a href=3D"mailto:adaplas@gmail.com">ada=
plas@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
On Saturday 02 July 2005 08:56, Jon Smirl wrote:<br>&gt; Another way to thi=
nk of this, let's make another member variable<br>&gt; .fb_hwcursor. When t=
he driver has a hardware cusor is sets<br>&gt; .fb_hwcursor. If you want to=
 use the software cursor use the exisiting
<br>&gt; .fb_cursor.<br>&gt;<br>&gt; If you think about it every driver is =
going to have the exact same<br>&gt; assignment .fb_cursor =3D soft_cursor.=
 If every driver is going to have<br>&gt; exactly the same assignment, why =
do we need the variable?
<br>&gt;<br>&gt; It's the existence of the hardware cursor that varies from=
 driver to<br>&gt; driver, that's the one we need the variable for.<br><br>=
Is this resolved?&nbsp;&nbsp;I tend to agree with Jon.&nbsp;&nbsp;Let's jus=
t remove all<br>
references to soft_cursor from all drivers, and let fbcon_cursor() fall bac=
k<br>to soft_cursor when xxxfb_cursor() is absent.&nbsp;&nbsp;It is a lot c=
leaner and saner<br>this way, and although it touches all drivers, it is a =
singe logical change,
<br>so it's acceptable.<br><br>Also, I think it might be preferable to have=
 2 cursor hooks, one<br>is fbcon-specific, and the other is for use only in=
 userspace, which needs<br>to be more comprehensive.&nbsp;&nbsp;Or if a sin=
gle but comprehensive cursor API is
<br>preferred, then we just adapt fbcon_cursor to use the more powerful<br>=
cursor API.<br><br>So, anyone want to propose a cursor API for fbdev, that =
is both usable by<br>fbcon and userspace?<br><br>Tony<br><br><br></blockquo=
te>
</div><br><br clear=3D"all"><br>-- <br>Jon Smirl<br><a href=3D"mailto:jonsm=
irl@gmail.com">jonsmirl@gmail.com</a><br>

------=_Part_567_20155621.1122133283592--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
