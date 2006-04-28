From: "Jorge Luis Zapata Muga" <jorgeluis.zapata@gmail.com>
Subject: Re: geode problem
Date: Fri, 28 Apr 2006 03:25:51 +0200
Message-ID: <eb77d7060604271825r6ed1213dx9412810f5c9a01d6@mail.gmail.com>
References: <eb77d7060604261806y4faa1107l5464316fa005266e@mail.gmail.com>
	 <4450E412.9080801@gmail.com>
	 <eb77d7060604271156n1c72fd90l19abd8a8e5da65da@mail.gmail.com>
	 <44514E3B.5060601@gmail.com>
	 <eb77d7060604271610q62827dfdsf67db58231aeb347@mail.gmail.com>
	 <44515B69.8010303@gmail.com>
	 <eb77d7060604271724k3dd8c9c4w4ddf22bfc7ee6acd@mail.gmail.com>
	 <44516155.6090304@gmail.com>
	 <eb77d7060604271734x3a393a24ja42886c05130bc3b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZIe6-0000pN-Us
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 19:23:50 -0700
Received: from pproxy.gmail.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZIe6-0002fA-Iv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 19:23:50 -0700
Received: by pproxy.gmail.com with SMTP id i49so2265360pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Apr 2006 19:23:48 -0700 (PDT)
In-Reply-To: <eb77d7060604271734x3a393a24ja42886c05130bc3b@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 4/28/06, Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com> wrote:
> On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > Jorge Luis Zapata Muga wrote:
> > > On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > >> Jorge Luis Zapata Muga wrote:
> > >>> On 4/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > >>>> Jorge Luis Zapata Muga wrote:
> > >>>>> On 4/27/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > >>>>>> Jorge Luis Zapata Muga wrote:
> > >>>> Where are the timings?
> > >>> sorry!  ok here they are:
> > >>> 2.4:
> > >>> mode "640x480-60"
> > >>>     # D: 25.175 MHz, H: 31.469 kHz, V: 60.055 Hz
> > >>>     geometry 640 480 640 480 16
> > >>>     timings 39722 36 36 21 21 88 2
> > >>>     accel true
> > >>>     rgba 5/11,6/5,5/0,0/0
> > >>> endmode
> > >>>
> > >>> 2.6:
> > >>> mode "640x480-60"
> > >>>     # D: 25.200 MHz, H: 31.500 kHz, V: 60.001 Hz
> > >>>     geometry 640 480 640 480 16
> > >>>     timings 39682 48 16 33 10 96 2
> > >>>     rgba 5/11,6/5,5/0,0/0
> > >>> endmode
> > >>>
> > >> Your timings for 2.4 and 2.6 are slightly different. Have you
> > >> tried using the 2.4 timings with 2.6?  Though they have the same
> > >> refresh and resolutions, the horizontal and vertical porches and
> > >> sync lengths are different, and VGA is very sensitive to these
> > >> values.
> > >>
> > >> Add (or replace the entry with) this in /etc/fb.modes:
> > >>
> > >> mode "640x480-60"
> > >>     # D: 25.175 MHz, H: 31.469 kHz, V: 60.055 Hz
> > >>     geometry 640 480 640 480 16
> > >>     timings 39722 36 36 21 21 88 2
> > >> endmode
> > >>
> > >> Then do an 'fbset 640x480-60'
> > >
> > > it didnt work.
> >
> > Did the driver accept the new timings (do an fbset -i afterwards)?
> > I want to know before delving on the hardware internals...
>
> yes it did, the fbset -i show up the same values as the mode on
> fb.modes, just to note that after i set it the console switching had
> errors (monitor off, switching to another console and then back fix
> the problem)
>

it is working in some way,
1. change to other mode (like the one you sent), the monitor powers
off, so several console  switches able again the screen
2. set the attribute 0x10 register to the value 0x01 (enable the graphics m=
ode)
INB(0x3BA);
INB(0x3DA);
OUTB(0x3C0, 0x10);
OUTB(0x3C0, 0x01);
and it works correctly. this is an empiric solution and i dont know
what is the functional error,
maybe some theory might be helpfull.

PS. i suppose this register should be filled with the correct value
while writing the GX registers, maybe the VSA code i have is wrong,
just a guess ...

> >
> > Tony
> >
>


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
