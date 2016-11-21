From: Adam Borowski <kilobyte@angband.pl>
Date: Mon, 21 Nov 2016 20:17:04 +0000
Subject: Re: [PATCH v5 2/2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161121201704.GA29655@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161118005309.GC26324@dell-m4800.home>
 <1479679088-3015-1-git-send-email-manuel.schoelling@gmx.de>
 <1479679088-3015-3-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1479679088-3015-3-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey_utkin@fastmail.com

On Sun, Nov 20, 2016 at 10:58:08PM +0100, Manuel Sch=F6lling wrote:
> Add a scrollback buffers for each VGA console. The benefit is that
> the scrollback history is not flushed when switching between consoles
> but is persistent.
> The buffers are allocated on demand when a new console is opened.
>=20
> This breaks tools like clear_console that rely on flushing the
> scrollback history by switching back and forth between consoles
> which is why this feature is disabled by default.
> Use the escape sequence \e[3J instead for flushing the buffer.
>=20
> Signed-off-by: Manuel Sch=F6lling <manuel.schoelling@gmx.de>
> ---

First, big thanks for this fix, it's something that greatly annoyed me
since forever!

The thing about clear_console is unfortunate: they abused the bug you're
fixing.  I've asked to use \e[3J (https://bugs.debian.org/845177) so there's
hope it'll be applied in stretch; with Debian configuring its glibc to
support only kernels from two releases before (in jessie that's 2.6.32, in
stretch 3.2)[1] there's hope we can flip the default in several years.

Do you suspect any other program relies on VT switch to clear the
scrollback?


But alas, this commit breaks that very \e[3J.  It does only a \e[2J, leaving
the scrollback uncleared.  For comparison, both mainline and with just your
preparatory commit, \e[3J works as expected.


Meow!

[1]. Well, the dependency goes the other way, but suggestions I'm
intentionally making this error to push an agenda are evil lies. :p
--=20
A true bird-watcher waves his tail while doing so.
