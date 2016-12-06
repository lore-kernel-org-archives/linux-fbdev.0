From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Tue, 06 Dec 2016 16:32:52 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1481041972.1420.3.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1480848836-11330-1-git-send-email-manuel.schoelling@gmx.de>
         <20161206100243.GA15139@kroah.com>
In-Reply-To: <20161206100243.GA15139@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, andrey_utkin@fastmail.com, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Greg,

On Di, 2016-12-06 at 11:02 +0100, Greg KH wrote:
> On Sun, Dec 04, 2016 at 11:53:53AM +0100, Manuel Sch=C3=B6lling wrote:
> > Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
> > Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
> > Tested-by: Adam Borowski <kilobyte@angband.pl>
> >=20
> > --
> > Changes in v7:
> >   - Add new callback to consw struct for flushing video console driver's
> >     scrollback buffer. Fixes issues with escape sequence '\e[3J' report=
ed
> >     by Adam Borowski (kilobyte@angband.pl).
> >   - Fix style issues
>=20
> But this is now v8, right?  I see two v7 patch series in my inbox :(
>=20
> confused,
Sorry for causing confusion. I wasn't sure about the workflow so asked
on #kernelnewbies a few days ago but apparently I misunderstood the
advice I got there:

This is just the same patch (v7) as I sent before, but I added the
Tested-By/Reviewed-By tags.


