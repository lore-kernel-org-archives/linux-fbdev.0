From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Current discussion about the future of free software graphics
Date: Tue, 11 May 2004 15:24:24 +0200
Sender: xserver-bounces-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org
Message-ID: <1084281863.807.73.camel@thor.asgaard.local>
References: <A98078D7EF5BEA4D8D8FD797FFBBC75F0742A3A6@fmsmsx402.fm.intel.com>
	<200405102120.48640.ajax@nwnk.net>
Reply-To: "Xserver development list." <xserver-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xserver-bounces-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>
In-Reply-To: <200405102120.48640.ajax-TAsg7VrFCGc@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://freedesktop.org/mailman/listinfo/xserver>,
	<mailto:xserver-request-CC+yJ3UmIYr06gljFB5M2x44fDD1xmscxSRez2wfwdukMgtKGq/v6w@public.gmane.org>
List-Archive: <http://freedesktop.org/pipermail/xserver>
List-Post: <mailto:xserver-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>
List-Help: <mailto:xserver-request-CC+yJ3UmIYr06gljFB5M2x44fDD1xmsccn+ig0pBZCw@public.gmane.org>
List-Subscribe: <http://freedesktop.org/mailman/listinfo/xserver>,
	<mailto:xserver-request-CC+yJ3UmIYr06gljFB5M2x44fDD1xmscuCKOA6ERizqzQB+pC5nmwQ@public.gmane.org>
Errors-To: xserver-bounces-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org
Content-Type: text/plain; charset="iso-8859-1"
To: Adam Jackson <ajax-TAsg7VrFCGc@public.gmane.org>
Cc: xserver-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org, "Sottek, Matthew J" <matthew.j.sottek-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dri-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mesa3d-dev-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org


[ Please remove any subject tags when following up ]

On Tue, 2004-05-11 at 04:20, Adam Jackson wrote:
>=20
> You only need to trust the user if the operation could have security=20
> implications.

[...]

> mode setting isn't sensitive because changing the display mode isn't goin=
g=20
> to stomp on kernel data structures or on the address space of other runni=
ng=20
> processes.

You're assuming that the user programs a valid mode, but the proposed
interface allows to program any combination of mode register values, of
which valid modes are probably just a small subset, depending on the
hardware. Combinations outside that set might cause unwanted effects
such as lockups or even hardware damage, which is bad enough IMHO.
System RAM access via DMA probably isn't an issue here with the hardware
I'm familiar with, but it might be with others.


> The mechanism _should_ be masked behind a library that abstracts away=20
> the device and implementation details as much as possible so the user=20
> (where here "user" equals X11 Classic, Y-Windows, Mesa Solo, whatever)=20
> doesn't have to care, and also so each new user doesn't have to write=20
> the same code again.

Yes, an ALSA-style model is probably the way to go. I'm just pointing
out that the interface between the library and the kernel probably can't
be simply an unrestricted ioctl to dump a bunch of register values.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
