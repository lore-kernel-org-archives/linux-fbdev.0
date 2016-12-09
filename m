From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2016 11:40:26 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481283626.27965.9.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <1481232519.26959.49.camel@kernel.crashing.org>
 <CAPM=9twUSRvfmh2ENMXTwCx-ULGzmPpyHs_wMM0XGDeWHMhnXw@mail.gmail.com>
In-Reply-To: <CAPM=9twUSRvfmh2ENMXTwCx-ULGzmPpyHs_wMM0XGDeWHMhnXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Fri, 2016-12-09 at 10:08 +1000, Dave Airlie wrote:
> What are people using fbcon for that needs acceleration, this is where I get
> a bit lost.
> 
> It's a console, if you aren't sshing into the machine.
> 
> It's main purpose should just be for gathering oopses and you've a lot better
> chance of getting an oops if you don't have some sketchy gpu accel in the way.

There are other uses for systems running Linux than being a server or desktop :-)

> The acceleration that most of the 2D things provide isn't ever that
> great, and shadowing is a lot more effective if done properly.

Not with a 400Mhz ARM9 processor on a fairly high res display. In these
case basic old things like color expansion for font rendering, bit
blits and solid fills for scrolls work beautifully. Anyway I just
realized that the ARM side of the AST GPU doesn't have the accel bits
at all anyway, only the host side, so I'm back to just a dumb FB. I
still want to avoid the copies though.

>  It's a feature
> that kernel ppl obsess over but I don't get a lot of real world feedback,
> (booting 9000 scsi nodes with debug on takes a long time was possibly
> something I heard once, and I think we resolved).

Ben.
