From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Sun, 31 Dec 2017 12:53:26 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <20171231125326.6e4d912b@alans-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
 <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
 <20171219135715.GG26573@phenom.ffwll.local>
 <1513692473.14829.14.camel@suse.com>
In-Reply-To: <1513692473.14829.14.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, Stefan Dirsch <sndirsch@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Max Staudt <mstaudt@suse.de>, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

On Tue, 19 Dec 2017 15:07:53 +0100
Oliver Neukum <oneukum@suse.com> wrote:

> Am Dienstag, den 19.12.2017, 14:57 +0100 schrieb Daniel Vetter:
> > > Would you like me to extend the FB API or not?  
> > 
> > Yes. Well for real I'd like you to do kms, so maybe you need to explain
> > why exactly you absolutely have to use fbdev (aka which driver isn't
> > supported by drm that you want to enable this on).  
> 
> Hi,
> 
> those would be at a minimum efifb, vesafb, xenfb
> Those are obviously not sexy, but from a practical point of view
> they are the minimum you need to support.

I think it's more constructive to look at it the other way around. What
drivers do we have that actually need to be used which don't have DRM
equivalents - and how do we fix that instead ?

Alan
