From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 20 Dec 2017 11:22:36 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <CAPj87rPvfvYP8WsUuQ4rq58-2qbqCkDztowAMUW7oJa6Bw1TnQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <20171220110809.u7bf6miyiorio6bz@linux-x5ow.site>
In-Reply-To: <20171220110809.u7bf6miyiorio6bz@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Max Staudt <mstaudt@suse.de>, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

Hi Johannes,

On 20 December 2017 at 11:08, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On Tue, Dec 19, 2017 at 05:16:30PM +0100, Daniel Vetter wrote:
>> Ok I've realized that my assumptions about why you need this aren't
>> So from reading these patches it sounded like you want an in-kernel boot
>> splash because that would be on the display faster than a userspace one
>> like plymouth. That's the only reasons I can see for this (if there's
>> another good justification, please bring it up).
>>
>> I only know of very embedded setups (tv top boxes, in vehicle
>> entertainment) where that kind of "time to first image" really matters,
>> and those systems:
>> - have a real hw kms driver
>> - don't have fbcon or fbdev emulation enabled (except for some closed
>>   source stacks that are a bit slow to adapt to the new world, and we
>>   don't care about those in gfx).
>>
>> But from discussions it sounds like you very much want to use this on
>> servers, which makes 0 sense to me. On a server something like plymouth
>> should do a perfectly reasonable job.
>
> For _one_ reason we'd like to see this is (I was one of the requesters of this
> implementation), plymouth in it's infinite wisdom also grabs the serial (IPMI)
> console and escape characters in a screen log are (you can think of the rest
> of this sentence yourself I think).

You can set 'plymouth.ignore-serial-consoles' on your boot line to
disable this behaviour.

> Also plymouth grabs the escape character of HPE iLOs, which is a serious
> no-go.

I'm not entirely sure what this means, but maybe it's best addressed
as a bug report to the Plymouth developers? One of them is in this
thread.

Cheers,
Daniel
