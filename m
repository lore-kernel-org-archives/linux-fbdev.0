From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 May 2014 14:14:00 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <4580210.sUvVkKflZg@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday 23 May 2014 17:10:35 Tomi Valkeinen wrote:
> On 23/05/14 16:13, Alexander Shiyan wrote:
> 
> >> Would it be possible to add the new driver along the old driver, and use
> >> the new driver only for the boards you have, and for boards for which
> >> it's clear the the old driver is not working? This could be merged for 3.16.
> > 
> > At this time yes, we can. But since I plan to add multiplatform support
> > for this SOC, this seems not possible.
> > I can try to make multiplatform support optional, then it could be done...
> 
> Hmm, why is that not possible with multiplatform support? What do you
> mean with multiplatform support here?

We are migrating all ARM platforms to allow building them into a single
kernel. However, that means that device drivers cannot access platform
specific header files any more and have to get hardware information from
DT or through platform data. The existing driver however uses mach/hardware.h.

	Arnd
