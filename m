From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Dec 2016 20:36:14 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <CAHp75VdUzTojreu=fBQSaEySVjVWAAPa4oB9adPf3bZDhmtO0g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123085234.GB3122@kroah.com>
 <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
 <20161123110529.289a1c7f@free-electrons.com>
In-Reply-To: <20161123110529.289a1c7f@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Wed, Nov 23, 2016 at 12:05 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Wed, 23 Nov 2016 11:12:32 +0200, Tomi Valkeinen wrote:

>> Or do you mean that we should keep the drivers in staging until there's
>> a matching DRM driver, but drop any plans to move the drivers from
>> staging to drivers/video/? If so, I'm fine with that. This is an RFC,
>> mostly to raise some discussion and push people to actually write those
>> DRM drivers =).
>
> The very reason why I submitted those drivers for staging is because
> lots and lots of people were using out of tree kernel modules for these
> drivers, which was really a pain.
>
> If you now remove those drivers from staging, then those folks will be
> back in the situation they originally were, using annoying out of tree
> modules.
>
> I'm all for removing fbtft drivers progressively as a matching
> DRM-based driver is available for the same hardware. However, if there
> is no DRM-based support for a given piece of hardware supported by
> fbtft, I'd prefer if we kept the fbtft driver for this hardware.

Too many people are playing with big things, I vote +1 to *leave*
fbtft for people who prefer small on big.

-- 
With Best Regards,
Andy Shevchenko
