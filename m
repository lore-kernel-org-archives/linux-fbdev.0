From: Jakub Wilk <jwilk@debian.org>
Date: Fri, 30 May 2014 22:26:22 +0000
Subject: Re: [PATCH] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20140530222622.GA1385@jwilk.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, geert@linux-m68k.org, broonie@linaro.org, rdunlap@infradead.org, dh.herrmann@gmail.com, airlied@redhat.com, mtosatti@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

* Manuel Sch=F6lling <manuel.schoelling@gmx.de>, 2014-05-30, 15:27:
>Add a scrollback buffers for each VGA console. The benefit is that the=20
>scrollback history is not flushed when switching between consoles but=20
>is persistent.

Some people rely on this scrollback flushing as a security feature. Is=20
there even another way to clear the scrollback, than to switch to=20
another vt and then back again?

Debian ships this:
http://manpages.debian.org/cgi-bin/man.cgi?query=3Dclear_console
https://sources.debian.net/src/bash/4.2%2Bdfsg-0.1/debian/clear_console.c

--=20
Jakub Wilk
