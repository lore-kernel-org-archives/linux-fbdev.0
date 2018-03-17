From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 17 Mar 2018 17:33:35 +0000
Subject: Re: [RFC 2/4] sh: ecovec24: conditionally register backlight device
Message-Id: <20180317173335.GA183240@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
 <20180315224202.96668-3-dmitry.torokhov@gmail.com>
 <20180316100748.GH16424@w540>
 <20180316233800.GA32310@dtor-ws>
 <20180317092516.g5p5ybka57abyhex@apu3b>
 <02834805-5053-4BDC-9256-DF1AFFEC8630@physik.fu-berlin.de>
 <20180317171631.GV1436@brightrain.aerifal.cx>
In-Reply-To: <20180317171631.GV1436@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, jacopo mondi <jacopo@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linus Walleij <linus.walleij@linaro.org>

On Sat, Mar 17, 2018 at 01:16:31PM -0400, Rich Felker wrote:
> On Sat, Mar 17, 2018 at 07:21:17PM +0900, John Paul Adrian Glaubitz wrote:
> > 
> > 
> > > On Mar 17, 2018, at 6:25 PM, jacopo mondi <jacopo@jmondi.org> wrote:
> > > 
> > > Hi Dmitry,
> > > 
> > >> On Fri, Mar 16, 2018 at 04:38:00PM -0700, Dmitry Torokhov wrote:
> > >> Hi Jacopo,
> > >> 
> > >>> On Fri, Mar 16, 2018 at 11:07:48AM +0100, jacopo mondi wrote:
> > >>> Hello Dmitry
> > >>> 
> > >>> FYI I am brushing the ecovec board these days as well
> > >>> https://www.spinics.net/lists/linux-sh/msg52536.html
> > >>> 
> > >> 
> > >> What is the ecovec board BTW? Is it some devkit or what? It seems quite
> > >> old to me.
> > > 
> > > Yes, it is a SuperH 4 based development board. It is old for sure. I'm
> > > also working on removing some stuff the ecovec board file is the only
> > > user of...
> > 
> > Umh, but I’m still using the SH7724 Evovec board. Please don’t
> > remove support for that.
> > 
> > The SuperH port of the Linux kernel is still maintained.
> 
> Thanks. At some point it would be nice to remove the board file, but
> only once the conversion to device tree happens. If anyone has a list
> of boards that people are still using or have access to and who can do
> testing, it would be nice to compile that somewhere so we can figure
> out what needs to be tested and who can test it.

For me I simply want to remove the custom "pen down" handler for tsc2007
from ecovec24. Unfortunately it seems with the current code you have to
switch from interrupt delivery to GPIO access on the board and it is not
really compatible with common handler and ecovec24 is the only board
that needs this custom handler support. If we can remove it then we can
switch the driver to use generic device properties only.

Note that the driver is still functional without the pendown handler, it
uses alternative methods for detecting lifting the pen, but they are
less reliable. I wonder how many people use ecovec24 with the
touchscreen.

Thanks.

-- 
Dmitry
