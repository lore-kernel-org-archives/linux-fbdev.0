From: Dave Airlie <airlied@gmail.com>
Date: Mon, 19 Mar 2012 19:17:22 +0000
Subject: Re: Radeon fb issue: invalid framebuffer id kernel 3.2.12
Message-Id: <CAPM=9twxhKWswPiKwdnYE-EnvXHU6eRtZ-ozQx=DCaAfJugZ_g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADpTngU6fL3r3cHsH3B6Hx68Bm4R_baoBeVmvGf6bUJPV3CXbA@mail.gmail.com>
In-Reply-To: <CADpTngU6fL3r3cHsH3B6Hx68Bm4R_baoBeVmvGf6bUJPV3CXbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> Hi all,
> I'm setting up a new laptot with Advanced Micro Devices [AMD] nee ATI
> Seymour [Radeon HD 6400M Series] card, using radeon drivers. I'm
> facing an issue for wich I found a lot of references but no actual
> solution, so I'm asking here for some help

the invalid framebuffer id isn't fatal, however it sounds like you
haven't got CONFIG_FRAMEBUFFER_CONSOLE
or haven't loaded fbcon.

Dave.
