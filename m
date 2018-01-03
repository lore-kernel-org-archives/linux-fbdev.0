From: Max Staudt <mstaudt@suse.de>
Date: Wed, 03 Jan 2018 17:56:31 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <ebdbab02-a2ab-6250-ee0f-717635f807cd@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
 <20171231123558.7136f0c6@alans-desktop>
In-Reply-To: <20171231123558.7136f0c6@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>

On 12/31/2017 01:35 PM, Alan Cox wrote:
> For embedded every KB counts. That is likely to remain the same for some
> time because at the end of the day small devices are constrained about the
> amount of SRAM you can put on die and the amount of power you can afford
> for DRAM. 

Fascinating, thanks for the insight!

Now I have a really good reason to separate the splash from fbcon.


>>> this by ignoring it an adding a hole new layer on top. That doesn't
>>> sound like any kind of good idea to me.  
>>
>> Yes. It is a vast improvement over the status quo, and people are asking for it. And the bootsplash layer can be moved elsewhere, just change the hooks and keep the loading/rendering.
>>
>> Also, gfx driver loading isn't a dumpster fire, it mostly just works. It just mustn't be done 100% carelessly.
> 
> It's a total mess (the fbcon layer loading and locking that is). Doing all
> this extra kernel stuff is like sitting in a hole and instead of trying to
> climb out digging the hole bigger so you've got more room to sit in it.
I'm not sure what exactly you're unhappy about - are you complaining about the kernel hack in KMS drivers which allows them to kick out vesafb/efifb?



Max
