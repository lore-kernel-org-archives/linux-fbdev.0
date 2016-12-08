From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 08 Dec 2016 14:37:35 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161208153735.74d7d350@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
        <1481158879.26959.41.camel@kernel.crashing.org>
        <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
        <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
        <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
        <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
In-Reply-To: <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

On Thu, 8 Dec 2016 15:22:09 +0100, Geert Uytterhoeven wrote:

> > Wut. We have like 20+ small atomic drivers nowdays.  
> 
> That's fast! Only two weeks ago you said:
> 
> | Bummer, they still haven't landed. But afaik there's at least 4 of
> | them floating around in various places ...

You're not talking about the same thing I believe.

When Daniel says "small atomic drivers", he talks about the relatively
small DRM drivers for SoC display controllers, such as the ones you can
find in ARM SoCs.

When you say "small driver", you're thinking about drivers for I2C or
SPI connected displays.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
