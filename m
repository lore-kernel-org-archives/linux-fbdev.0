From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 29 Nov 2012 13:18:24 +0000
Subject: Re: [PATCH] backlight: corgi_lcd: Fix WARN_ON() when calling corgi_bl_set_intensity.
Message-Id: <20121129131824.GJ19440@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1354139201-12834-1-git-send-email-dromede@gmail.com>
 <001501cdcdf2$b3f8f730$1beae590$%han@samsung.com>
 <CAHod+Gd3UU7NdRLAAbsX6TUugnjKBwUsDy7yBQzyykuf5GHMVQ@mail.gmail.com>
In-Reply-To: <CAHod+Gd3UU7NdRLAAbsX6TUugnjKBwUsDy7yBQzyykuf5GHMVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 29, 2012 at 02:09:51PM +0100, Marko Kati=C4=87 wrote:
> Well, the commit message was short because i thought it was a quick
> and obvious fix.

Don't always expect the person who ends up applying your patch to know
what your patch is doing.  Don't expect people who are looking back
through the git history to look at the patch to work out whether your
commit is relevant to them.  I suspect Andrew Morton doesn't know what
a "SCOOP" or "AKITA" is...

Commit messages are there not only to describe the change, but also say
why the change is necessary.  Think about it as your chance to "sell"
the patch.

One good step would be to include the warning message dump from the
kernel (your subject line says you're hitting a WARN_ON so include
that.)  At least then people can see your starting point for the patch.
