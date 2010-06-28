From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 28 Jun 2010 20:26:41 +0000
Subject: [Patch 0/4] HID: Fix PicoLCD to allow it to run fbcon and handle
Message-Id: <20100628222641.489c955a@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home>
	<AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com>
	<20100510080047.5adade6f@pluto.restena.lu>
	<20100526215829.28a4aa47@neptune.home>
	<20100530130945.5c03797f@neptune.home>
	<20100623123225.4c16e653@neptune.home>
	<alpine.LNX.2.00.1006241053360.13809@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1006241053360.13809@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, 24 June 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 23 Jun 2010, Bruno Pr=C3=A9mont wrote:
> > Do you think This patch can be applied as-is or should I break it up
> > into 2 or 3 patches (one for the 8bpp NULL-pointer dereference,
> > one for switch between 1bpp and 8bpp and one for the refcounting of
> > framebuffer to get things polite on unplug while framebuffer is still
> > in use?
>=20
> Hi Bruno,
>=20
> splitting would definitely improve readability and reviewability (even=20
> more so for someone like me, who is not really familiar with the=20
> framebuffer stuff).
>=20
> Still it'd be nice if you could collect Ack from someone more familiar=20
> with the framebuffer code.

Here it comes, split into 4 patches.

Thanks,
Bruno
