From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Sat, 07 Feb 2015 16:05:03 +0000
Subject: Re: [PATCH 5/8] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <20150207170503.045490aa@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de>
	<20150207112043.GO2079@lukather>
In-Reply-To: <20150207112043.GO2079@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Am Sat, 7 Feb 2015 12:20:43 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Fri, Feb 06, 2015 at 11:28:11PM +0100, niederp@physik.uni-kl.de
> wrote:
> > From: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
> >=20
> > This patch adds a module parameter 'bitsperpixel' to adjust the
> > colordepth of the framebuffer. All values >1 will result in memory
> > map of the requested color depth. However only the MSB of each
> > pixel will be sent to the device. The framebuffer identifies itself
> > as a grayscale display with the specified depth.
>=20
> I'm not sure this is the right thing to do.
>=20
> The bits per pixel for this display is rightfully defined, used and
> reported to the userspace, why would you want to change that?
>=20

You are right of course. The display is 1bpp and it reports to be 1
bpp. The problem is that there is almost no userspace library that can
handle 1 bit framebuffers correctly. So it is nice if the framebuffer
(optionally) can expose itself as 8 bits per pixel grayscale to the
userspace program. As an example this allows to run DirectFB on the
framebuffer, which is not possible out of the box for 1bpp.

Also note that if do not set the module parameter at load time
the framebuffer will be 1bpp. So you have to actively set that module
parameter to make the framebuffer pretend to be more than 1bpp.

In any case I don't cling to that patch, I just thought it was a nice
feature.

> Maxime
>=20

