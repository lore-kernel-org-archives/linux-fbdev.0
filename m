From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linux-fbdev-devel] Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 18:29:47 +0100
Message-ID: <200503091829.48999.arnd@arndb.de>
References: <20050308021706.GH26249@spock.one.pl> <20050308223728.GA11065@spock.one.pl> <9e4733910503090854e245740@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <9e4733910503090854e245740@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Michal Januszewski <spock@gentoo.org>

On Middeweken 09 M=E4rz 2005 17:54, Jon Smirl wrote:

> framebuffer already has a class registered. check out /sys/class/grpa=
hics.
>=20
> You should be able to just call request_firmware and have it download
> your image whenever you need it. It doesn't have to be firmware,
> request_firmware will download anything.

Agreed, request_firmware() would be a really nice way to simplify the i=
nterface.
It might be more practical to use the /sys/class/tty/tty* object instea=
d of
the /sys/class/graphics/fb* one, but I don't know enough about the cons=
ole
subsystem to tell for sure.

 Arnd <><
