From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: OLPC: gxfb/lxfb: add DCON panel modes to framebuffer drivers
Date: Mon, 14 Apr 2008 09:18:56 -0600
Message-ID: <20080414151856.GA10111@cosmic.amd.com>
References: <20080414035302.794dcd7a@ephemeral> <200804141033.59998.arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760199AbYDNPMy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200804141033.59998.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andres Salomon <dilinger@queued.net>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

On 14/04/08 10:33 +0200, Arnd Bergmann wrote:
> On Monday 14 April 2008, Andres Salomon wrote:
> > Since there's no way to autodetect panel modes, we're forced to har=
dcode
> > them in the driver and add a big fat #ifdef. =A0The OLPC DCON needs=
 a
> > specific mode line (at 1200x900). =A0This adds it to both gxfb and =
lxfb.
> >=20
> > Signed-off-by: Andres Salomon <dilinger@debian.org>
>=20
> Since the XO is based on Open Firmware, shouldn't the panel size real=
ly be
> a property in the device tree that can be read by this driver?

Andre's description was slightly misleading.  We could probably detect
the panel mode, but there isn't any reason to since the panel timings
are well known and won't change.  While OFW detection would be good
computer science fu, it would be a wasted effort since its so easy to h=
ard
code them into the table.

Jordan

--=20
Jordan Crouse
Systems Software Development Engineer=20
Advanced Micro Devices, Inc.
