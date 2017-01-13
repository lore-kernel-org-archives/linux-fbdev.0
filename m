From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 13 Jan 2017 11:08:47 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <3057141.7Vn8X5ONyT@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <CGME20170112212713epcas2p108e55dc682911981f750f197f30c7d5f@epcas2p1.samsung.com>
 <d1534f4b-e564-d87e-b408-9b7215a90de2@mleia.com>
In-Reply-To: <d1534f4b-e564-d87e-b408-9b7215a90de2@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi,

On Thursday, January 12, 2017 11:26:14 PM Vladimir Zapolskiy wrote:
> On 01/12/2017 10:27 AM, Linus Walleij wrote:
> > On Thu, Jan 12, 2017 at 1:05 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> >> On 01/11/2017 05:16 PM, Linus Walleij wrote:
> >>> On Tue, Jan 10, 2017 at 2:47 PM, Vladimir Murzin
> >>> <vladimir.murzin@arm.com> wrote:
> >>>
> >>>> In another thread Benjamin pointed at patch [1] in drm/kms part for noMMU.
> >>>>
> >>>> [1] https://cgit.freedesktop.org/drm/drm-misc/commit/?idba0d98a188cc4ebd8ea54b37d274ec20465e464
> >>>
> >>> Problem solved?
> >>>
> >>> Vladimir: I do not require in any way that you create a CLCD driver for DRM,
> >>> I just think it would be very very nice...
> >>>
> >>
> >> I have no other option, this series is unreviewed and thus unlikely it will
> >> be applied, still a panel PCB on my board needs power management support.
> > 
> > Hm I can ACK it I guess, but mergeing it into an unmaintained subsystem
> > is another issue, just not very optimal. 
> 
> + Bartlomiej
> 
> Linus, your ack is always more than appreciated.

+1

> To all appearance Bartlomiej is a new honoured framebuffer layer maintainer.
> 
> Bartlomiej, do you have the changes under discussion in your mailbox or
> should I resend them to you directly for review?

No need for resend, I picked them from the list and they are on TODO.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> > If you get it working on your system I can look into migrating all the old
> > users to DRM as well.
> > 
> 
> Sure, I started development of a simple CLCD DRM driver as an own attractive
> exercise, I'll keep you informed of the progress.
> 
> --
> With best wishes,
> Vladimir

