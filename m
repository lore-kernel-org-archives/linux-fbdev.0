From: Michael Kaufmann <kaufmann@sohard.de>
Subject: Re: Mirrored Display?
Date: Mon, 23 Dec 2002 12:04:39 -0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200212231204.39625.kaufmann@sohard.de>
References: <Pine.LNX.4.44.0212201947290.6471-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [212.123.118.25] (helo=proxy.sohard.de)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18QQPv-0002kU-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Mon, 23 Dec 2002 03:06:39 -0800
In-Reply-To: <Pine.LNX.4.44.0212201947290.6471-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel@lists.sourceforge.net

Dear James,

thanks for your reply.

On Friday 20 December 2002 18:49, you wrote:
> > I've modified existing drivers, and after a lot of work i now have a
> > clear picture on my display. Unfortunately, the complete picture is
> > mirrored. The Bootlogo is top/right instead of top/left and the ascii
> > output starts from right to left.
>
> Some hardware supports mirroring. Sounds like you turned it on by mista=
ke.

No, there is nothing i could turn on/off in my hardware.=20
I have checked the hardware and the datasheets again, and i'm now sure. T=
he=20
display i'm using is a LCD monochrom display. And this type of display wr=
ites=20
the picture date from right to left (mirrored). There is nothing i can do=
=20
against it. My videocontroller has no feature to output every line mirror=
ed.
The videocontroller start sending the picture datastream to the display f=
rom
videobuffer address 0. The first pixel from the picture datastream will b=
e=20
displayed on the right/top edge on my LCD and the second pixel left to th=
e=20
first and so on.=20

First i thought that this behaviour of my display is extremly unusal. Aft=
er=20
looking to other display datasheets i now know, that it is unusal but far=
 not=20
sooo unusual i thought the first time. =20

> > Where is the right place to modify this behaviour?
> > I'm also looking for a possibility to rotate the picture.
> > Because my videocontroller can emulate 15 grayscales, i'm useing 4bpp=
=2E
>
> The latest 2.5.X kernels have hardware hooks for rotation. I haven't ad=
ded
> it yet to the software accel functions. I plan to a soon as I get time.
> Thank you.

Antonino has also answered to my question. And he said that there is noth=
ing=20
i can do, because user apps will directly acces the framebuffer via read/=
write=20
or nmap. I can only patch the console and the show _logo to write the dat=
a=20
mirrored to the videobuffer (a lot of work).
So my user apps (like nanoX or directfb/GTK+) must know about the mirrore=
d=20
display and should write the picturedata mirrored in the framebuffer.=20

I'm know a litte bit amazed about a rotation feature in next versions. Do=
es=20
this mean, that the buffer where user apps (or also the console) are writ=
ing=20
there picture data is not directly the videobuffer anymore? Or how does t=
his=20
rotation feature works?

I think it would be a good feature to have 'something' between the frameb=
uffer=20
and the physical videobuffer to be able to manipulate the picture data (l=
ike=20
rotation, mirroring, etc.). But i don't know how this peace of software=20
should detect, changed data in the 'framebuffer' to e.g. mirror in the=20
videobuffer? Writing the whole buffers from time to time whould be a very
bad solution (performance).

At the moment i plan to do the manipulation in the directfb layer on top =
of=20
the framebuffer device. I 'only' need to run some GTK+ applications. I ne=
ed=20
to mirror the picture, and i also want to rotate the picture from landcap=
e to=20
portrait.

Bye
Michael=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
