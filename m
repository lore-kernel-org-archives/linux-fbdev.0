From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 14:16:25 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <0bb4de88-77f4-8c6a-d8df-e418e9f29e78@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
 <20171220094355.GJ26573@phenom.ffwll.local>
 <e9734508-9b2c-0c18-f6ef-6ca984a33b32@baylibre.com>
In-Reply-To: <e9734508-9b2c-0c18-f6ef-6ca984a33b32@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>, philm@manjaro.org

On 12/20/2017 11:06 AM, Neil Armstrong wrote:
> My 2cents about this patchset:
> You did a good job about all the animation and splash logic, but for me all this fbcon
> stuff is a huge hack, please use a standard and modern display subsystem en leave fbcon
> die alone....

Thanks for the compliment!

As for fbcon: I think you're confusing things. fbcon is not the same as fbdev.

I've hooked into the terminal emulator because it allows me to hide exactly the thing I want to hide (text), it allows me to show what I want when I want (splash or text), and it spares me from defining a third competing user of the device.

I understand that you want old code to die, and as it is now, catering for the old code will cater for everyone, including the new style drivers (via their legacy interface).


> My DRM ARM systems would love to have such bootsplash, so please, make it happen using DRM
> then leave the fbcon based stuff like efifb migrate to DRM in a second time !
The current solution will "just work" on your systems as it is. I'm not ignoring them. If you've ever used a kernel console on your DRM ARM device, then the current splash will work exactly as good.



Max
