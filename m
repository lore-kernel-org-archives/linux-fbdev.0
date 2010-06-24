From: Jiri Kosina <jkosina@suse.cz>
Date: Thu, 24 Jun 2010 08:54:41 +0000
Subject: Re: [Patch] HID: Fix PicoLCD to allow it to run fbcon and handle
Message-Id: <alpine.LNX.2.00.1006241053360.13809@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home> <AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com> <20100510080047.5adade6f@pluto.restena.lu> <20100526215829.28a4aa47@neptune.home> <20100530130945.5c03797f@neptune.home>
 <20100623123225.4c16e653@neptune.home>
In-Reply-To: <20100623123225.4c16e653@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 23 Jun 2010, Bruno Pr=C3=A9mont wrote:

> Do you think This patch can be applied as-is or should I break it up
> into 2 or 3 patches (one for the 8bpp NULL-pointer dereference,
> one for switch between 1bpp and 8bpp and one for the refcounting of
> framebuffer to get things polite on unplug while framebuffer is still
> in use?

Hi Bruno,

splitting would definitely improve readability and reviewability (even=20
more so for someone like me, who is not really familiar with the=20
framebuffer stuff).

Still it'd be nice if you could collect Ack from someone more familiar=20
with the framebuffer code.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
