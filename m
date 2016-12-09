From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2016 20:29:34 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481315374.17253.17.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
 <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <1481283856.27965.11.camel@kernel.crashing.org>
 <20161209133339.3cpvuxerimoc5huf@phenom.ffwll.local>
 <CANq1E4S51c-fwJMN2P9MnhuErANvwfy41W2WBSSXrFPS3DXPkg@mail.gmail.com>
In-Reply-To: <CANq1E4S51c-fwJMN2P9MnhuErANvwfy41W2WBSSXrFPS3DXPkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2016-12-09 at 14:57 +0100, David Herrmann wrote:
> Despite all of this I still see no reason why a driver could not
> expose the static, real frambuffers via private ioctls. You can get
> all your fancy acceleration that way. Then fix user-space to use this
> API. If enough drivers end up with something similar, move it into the
> core. Just like we always do in DRM.

I don't care so much about userspace in my specific use case, more
about fbcon, which I think can be solved without too many hoops.

As for FB objects, my thinking is we could just use
unmap_mapping_ranges() to effectively change the mapping under the hood
of the app so it alternatively maps a bit of fb or a bit of memory...

Cheers,
Ben.

