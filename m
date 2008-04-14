From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] OLPC: gxfb/lxfb: add DCON panel modes to framebuffer drivers
Date: Mon, 14 Apr 2008 10:33:58 +0200
Message-ID: <200804141033.59998.arnd@arndb.de>
References: <20080414035302.794dcd7a@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760248AbYDNIfX@vger.kernel.org>
In-Reply-To: <20080414035302.794dcd7a@ephemeral>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, jordan.crouse@amd.com, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

On Monday 14 April 2008, Andres Salomon wrote:
> Since there's no way to autodetect panel modes, we're forced to hardc=
ode
> them in the driver and add a big fat #ifdef. =A0The OLPC DCON needs a
> specific mode line (at 1200x900). =A0This adds it to both gxfb and lx=
fb.
>=20
> Signed-off-by: Andres Salomon <dilinger@debian.org>

Since the XO is based on Open Firmware, shouldn't the panel size really=
 be
a property in the device tree that can be read by this driver?

	Arnd <><
