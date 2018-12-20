From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 15:42:48 +0000
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
Message-Id: <c5378c0f-d2f8-720c-e633-24673af87a53@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181026140931.15771-1-robdclark@gmail.com>
 <CGME20181218132030epcas4p341162d849e429c85fdd265246aee6630@epcas4p3.samsung.com>
 <CAF6AEGuUXt-c9Bmi8yfU=d_pUvrsXwDq4CzZ9GfrhZBP+zbe-A@mail.gmail.com>
In-Reply-To: <CAF6AEGuUXt-c9Bmi8yfU=d_pUvrsXwDq4CzZ9GfrhZBP+zbe-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Hans de Goede <j.w.r.degoede@gmail.com>, Ulf Magnusson <ulfalizer@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Randy Dunlap <rdunlap@infradead.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>


On 12/18/2018 02:19 PM, Rob Clark wrote:
> On Fri, Oct 26, 2018 at 10:09 AM Rob Clark <robdclark@gmail.com> wrote:
>>
>> BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
>> FB_BACKLIGHT prevents it from being built as a module.  There
>> doesn't seem to be any particularly good reason for this, so
>> switch FB_BACKLIGHT over to tristate.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
> 
> bump

Patch queued for 4.21, thanks (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
