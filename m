From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Fri, 24 Jun 2011 13:57:06 +0000
Subject: Re: [PATCH] ARM: amba: Link fb device to its parent
Message-Id: <alpine.LFD.2.00.1106240949590.2142@xanadu.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-959370788-1308923467=:2142"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308602657-28783-1-git-send-email-loic.minier@linaro.org>
	<20110624080721.GC24184@linux-sh.org>
In-Reply-To: <20110624080721.GC24184@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-959370788-1308923467=:2142
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-ID: <alpine.LFD.2.00.1106240951351.2142@xanadu.home>

On Fri, 24 Jun 2011, Paul Mundt wrote:

> On Mon, Jun 20, 2011 at 10:44:17PM +0200, Lo??c Minier wrote:
> > Some pieces of userspace like debian-installer expect to find the fb0
> > driver name by readlink-ing /sys/class/graphics/fb0/device/driver but
> > this was broken with amba-clcd as it sets up fb_info manually and missed
> > the .device parent pointer.
> >=20
> > Signed-off-by: Lo??c Minier <loic.minier@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > ---
> >  drivers/video/amba-clcd.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >=20
> While this is titled as an ARM patch it's certainly fbdev-specific. I'll
> apply it barring any objections from Russell.

BTW this should be "Lo=EFc Minier" not "Lo??c Minier" The original email=20
was fine with proper UTF-8 in that regard.  Maybe you should have a look=20
at your MUA config so the resulting patch log going into git is not=20
dammaged.


Nicolas
--8323328-959370788-1308923467=:2142--
