From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 30 Jan 2017 15:23:37 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <2240649.KotMHs5XVh@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com> <3057141.7Vn8X5ONyT@amdc3058>
 <ae187f91-ca9b-c51a-d7cb-14fd99baa434@mleia.com>
 <CGME20170130152340epcas5p3f68349ef89c5ec902186ae71011c0c4b@epcas5p3.samsung.com>
In-Reply-To: <ae187f91-ca9b-c51a-d7cb-14fd99baa434@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday, January 17, 2017 03:57:33 AM Vladimir Zapolskiy wrote:
> On 01/13/2017 01:08 PM, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Thursday, January 12, 2017 11:26:14 PM Vladimir Zapolskiy wrote:
> >> On 01/12/2017 10:27 AM, Linus Walleij wrote:
> >>> On Thu, Jan 12, 2017 at 1:05 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> >>>> On 01/11/2017 05:16 PM, Linus Walleij wrote:
> >>>>> On Tue, Jan 10, 2017 at 2:47 PM, Vladimir Murzin
> >>>>> <vladimir.murzin@arm.com> wrote:
> >>>>>
> >>>>>> In another thread Benjamin pointed at patch [1] in drm/kms part for noMMU.
> >>>>>>
> >>>>>> [1] https://cgit.freedesktop.org/drm/drm-misc/commit/?idba0d98a188cc4ebd8ea54b37d274ec20465e464
> >>>>>
> >>>>> Problem solved?
> >>>>>
> >>>>> Vladimir: I do not require in any way that you create a CLCD driver for DRM,
> >>>>> I just think it would be very very nice...
> >>>>>
> >>>>
> >>>> I have no other option, this series is unreviewed and thus unlikely it will
> >>>> be applied, still a panel PCB on my board needs power management support.
> >>>
> >>> Hm I can ACK it I guess, but mergeing it into an unmaintained subsystem
> >>> is another issue, just not very optimal. 
> >>
> >> + Bartlomiej
> >>
> >> Linus, your ack is always more than appreciated.
> > 
> > +1
> > 
> >> To all appearance Bartlomiej is a new honoured framebuffer layer maintainer.
> >>
> >> Bartlomiej, do you have the changes under discussion in your mailbox or
> >> should I resend them to you directly for review?
> > 
> > No need for resend, I picked them from the list and they are on TODO.
> > 
> 
> Bartlomiej, Linus,
> 
> I've noticed that 4/4 requires special attention due to the anticipated
> change of devm_get_gpiod_from_child() interface.
> 
> If you have any concerns regarding 4/4, please review and consider to
> apply the first three clean-up patches in the series, basically I've
> achieved my goal of describing a power supply for a panel in DTS by
> introducing a DRM driver (see a note below), however support of
> "enable-gpios" property mentioned in the "panel-dpi" device tree binding
> documentation still is seen as beneficial for the CLCD fbdev driver.

Thanks, I queued patches #1-3 for 4.11.  Please ping me later for
merging patch #4.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

