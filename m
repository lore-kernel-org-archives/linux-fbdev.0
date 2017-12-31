From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Sun, 31 Dec 2017 12:35:58 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <20171231123558.7136f0c6@alans-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
In-Reply-To: <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, philm@manjaro.org, Bero =?UTF-8?B?Um9zZW5rcsOkbnplcg==?= <bernhard.rosenkranzer@linaro.org>

On Tue, 19 Dec 2017 19:40:12 +0100
Max Staudt <mstaudt@suse.de> wrote:

> On 12/19/2017 06:26 PM, Daniel Vetter wrote:
> > On Tue, Dec 19, 2017 at 6:04 PM, Max Staudt <mstaudt@suse.de> wrote:  
> >> Well, those could enable fbcon if they want the bootsplash. Shouldn't make a difference anyway if they're powerful enough to run Linux. As long as the bootsplash is shown, no fbcon drawing operations are executed, so there is no expensive scrolling or such to hog the system.  
> > 
> > It's too big, and those folks tend to be super picky about space.  
> 
> I know, they really are.
> 
> However, given just how big and clunky modern systems have become, I raise my doubts about a few extra KB for fbcon code to be relevant.

For embedded every KB counts. That is likely to remain the same for some
time because at the end of the day small devices are constrained about the
amount of SRAM you can put on die and the amount of power you can afford
for DRAM. 

> > this by ignoring it an adding a hole new layer on top. That doesn't
> > sound like any kind of good idea to me.  
> 
> Yes. It is a vast improvement over the status quo, and people are asking for it. And the bootsplash layer can be moved elsewhere, just change the hooks and keep the loading/rendering.
> 
> Also, gfx driver loading isn't a dumpster fire, it mostly just works. It just mustn't be done 100% carelessly.

It's a total mess (the fbcon layer loading and locking that is). Doing all
this extra kernel stuff is like sitting in a hole and instead of trying to
climb out digging the hole bigger so you've got more room to sit in it.

Alan
