From: Max Staudt <mstaudt@suse.de>
Date: Wed, 03 Jan 2018 18:00:43 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <3f50c7ba-f55a-30a4-6285-010a9d0e4dd2@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
 <20171220094355.GJ26573@phenom.ffwll.local>
 <e9734508-9b2c-0c18-f6ef-6ca984a33b32@baylibre.com>
 <20171220101421.GM26573@phenom.ffwll.local>
 <5dc7f218-9113-fad3-c0a8-883c4bae4e02@suse.de>
 <CAKMK7uE+4LrX0U6JWgQuFD3RLVOoNOi8oTAs8N3QjwqULv-fCQ@mail.gmail.com>
 <20171231124457.12e954f8@alans-desktop>
In-Reply-To: <20171231124457.12e954f8@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Daniel Vetter <daniel@ffwll.ch>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>, philm@manjaro.org

On 12/31/2017 01:44 PM, Alan Cox wrote:
>> So fundamentally I don't think an in-kernel bootsplash is a bad idea.
>> But most likely you want this on a highly embedded system, which
> 
> It wouldn't be in kernel on such a device, it'll be in the bootstrap
> before (or on a dual core device quite possibly while) the kernel data is
> being uncompressed. Most displays need some time to stabilize clocks and
> PLLs so you have to get the mode set up really really early on embedded
> devices where in some cases you've got regulatory requirements to show
> something on the display really really quickly. Consumers perceive a
> second from on to displaying something as sluggish on a fixed function
> device.

Oh no. Thanks for the input, that changes my perspective a bit.

So unless we could show it quickly enough, the kernel splash would be useful either as an addition on top of the bootloader's splash, or really aimed at fatter distros which wish to use something simple and kernel based.



Max
