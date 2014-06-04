From: Dave Airlie <airlied@gmail.com>
Date: Wed, 04 Jun 2014 03:07:56 +0000
Subject: Re: [PATCH v2 1/5] gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
Message-Id: <CAPM=9tzMXBSFUicLVpfi1QqJq5U53pt-zpWXu8nbFyggma+mbg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
 <1401113983-23132-2-git-send-email-p.zabel@pengutronix.de>
 <20140528211342.GA18203@kroah.com>
 <1401726982.4173.58.camel@paszta.hi.pengutronix.de>
 <20140602170650.GA31142@kroah.com>
In-Reply-To: <20140602170650.GA31142@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, kernel@pengutronix.de, dri-devel <dri-devel@lists.freedesktop.org>, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Airlie <airlied@redhat.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On 3 June 2014 03:06, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Mon, Jun 02, 2014 at 06:36:22PM +0200, Philipp Zabel wrote:
>> Am Mittwoch, den 28.05.2014, 14:13 -0700 schrieb Greg Kroah-Hartman:
>> > On Mon, May 26, 2014 at 04:19:39PM +0200, Philipp Zabel wrote:
>> > > The i.MX Image Processing Unit (IPU) contains a number of image processing
>> > > blocks that sit right in the middle between DRM and V4L2. Some of the modules,
>> > > such as Display Controller, Processor, and Interface (DC, DP, DI) or CMOS
>> > > Sensor Interface (CSI) and their FIFOs could be assigned to either framework,
>> > > but others, such as the dma controller (IDMAC) and image converter (IC) can
>> > > be used by both.
>> > > The IPUv3 core driver provides an internal API to access the modules, to be
>> > > used by both DRM and V4L2 IPUv3 drivers.
>> > >
>> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> > > ---
>> > > Changes since RFC:
>> > >  - Rebased onto current staging-next
>> > >  - Removed an unrelated change to ipu_pixelformat_to_colorspace
>> > >  - Avoided moving around the IPU_PIX_FMT_GBR24 #define
>> >
>> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Thank you. My favourite next step would be to send a pull request and
>> have this merged into drm-next. Dave, Greg would you be ok with this?
>
> No objection from me, it's up to Dave what he wants for this.

Yes please send me a pull req for this.

Dave.
