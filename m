From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Current discussion about the future of free software graphics
Date: Mon, 10 May 2004 18:15:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084205711.804.43.camel__30238.6499628939$1084206537@thor.asgaard.local>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
To: xserver@freedesktop.org, mesa3d-dev@lists.sf.net, dri-devel@lists.sf.net, linux-fbdev-devel@lists.sf.net


[ Apologies for the broad cross-post; I'd like to reach anyone
potentially interested ]


First of all, it should be fairly obvious to anyone that ideally only a
single kernel driver should muck with the hardware directly. However,
I'd like to point out again that it doesn't follow that the DRM and the
framebuffer device must merge to a single entity (which 'has to be' the
DRM if you ask some people, the framebuffer device if you ask
others...). E.g., they could both use the same mini-driver which deals
with the hardware. Let's try and keep our minds open to all possible
solutions.


I'd also like to comment on some points I noticed in the
ksummit-2004-discuss archives:

In http://thunk.org/pipermail/ksummit-2004-discuss/2004-May/000388.html,
Jim Gettys wrote:

> In short, the X server would put a sequence of commands into a piece
> of memory also visible by the graphics card, set up the DMA
> transfer, tell it to go, and then continue setting up a second buffer,
> and call into the UNIX kernel with the transfer address of the
> second buffer, that transfer to be initiated at interrupt time
> when the first buffer's commands had been processed; this then blocked
> the X server, so it had good "interactive" behavior under many
> circumstances.
>=20
> It may be that system calls are now cheap enough to do this rather than
> having to do it in user space [...]

Yes, that's basically what the r128 and radeon X drivers do when the DRI
is enabled, and it's considerably faster than direct register banging.


In http://thunk.org/pipermail/ksummit-2004-discuss/2004-May/000391.html,
Jon Smirl wrote:

> The modelines would be passed into the plug-in libs which would turn them=
 into
> register values. Finally the plug-in lib would use a private IOCTL to set=
 the
> state into the video hardware.=20
>=20
> There are numerous pros and cons for both a both schemes. The user space =
code is
> swappable, easier to debug, and does not need to be run as root.

It does, or the ioctl must verify the register data, which could require
about the same amount of code as computing it in the kernel in the first
place (possibly even more; the problem changes from computing a valid
combination of register values for a specific requested mode to limiting
the huge number of register value combinations to those that don't lock
up the chip or worse). I've pointed this out several times before, but
nobody has presented a solution yet. Will the userspace code live in a
daemon that runs as root? Or will only privileged processes be allowed
to change display properties?


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to=20
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=3Dosdnemail3
