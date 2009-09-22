From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [GIT PULL]: OMAP2/3 Display Subsystem
Date: Tue, 22 Sep 2009 15:33:45 +0300
Message-ID: <4AB8C429.60804@gmail.com>
References: <1253622588.25232.11.camel@tubuntu>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1253622588.25232.11.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: torvalds@linux-foundation.org
Cc: tomi.valkeinen@nokia.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On 09/22/2009 03:29 PM, Tomi Valkeinen wrote:
> Linus,
>
> Here's the new display subsystem and framebuffer driver for OMAP2/3.
>
> The driver has been reviewed on linux-omap and linux-fbdev-devel, and=
 is in
> use, for example, on N900, Beagle Board and Overo boards. We have an =
ACK for
> the OMAP parts from Tony Lindgren, who maintains the OMAP platform.
>
> We have gotten positive feedback about the driver, for example in thi=
s thread:
> http://marc.info/?l=3Dlinux-kernel&m=3D125171081901820&w=3D2
>
> The driver is actively maintained and developed further, and I have a=
lready a
> bunch of patches on top of these patches, but I would like to get the=
 big core
> driver merged first. After the driver is merged, other people can sen=
d patches
> to LCD drivers and board files to enable the new display subsystem on=
 their
> boards.
>
> Andrew said 2-3 weeks ago that he'll merge the driver (after he has l=
ooked
> through it), but he hasn't responded since then. I'm guessing he's qu=
ite busy.

Just in case it matters, here is my redundant confirmation that we are
successfully using this piece of software for about a year.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
