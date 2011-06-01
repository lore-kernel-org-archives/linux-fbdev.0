From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 01 Jun 2011 18:43:45 +0000
Subject: Re: Mirror "module" for framebuffer
Message-Id: <20110601204345.6129d6a1@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DE67493.6090708@daccii.it>
In-Reply-To: <4DE67493.6090708@daccii.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Daniele,

On Wed, 01 June 2011 Daniele Salvatore Albano <info@daccii.it> wrote:
> In short i should start to work to an application to remote control an 
> android phone, just using the browser (video stream plus a lot of 
> javascript).
> While this is partially working right now, as you can imagine, phone is 
> slow, a lot slow, so, while the framebuffer is little in most cases 
> (320x256x2/320x256x4/800x480x2/800x480x4) a simple comparison, using 
> neon extension too, if avaiable, is too slow, so the screen is refreshed 
> too few times in a sec.
> 
> On windows exists Mirror Drivers infrastructure that supply a list of 
> changed parts of the screen and more (mouse events too if i'm not 
> wrong), but looking around on the web i didn't founded anything related 
> to this stuff (or similar) for linux.
> 
> So, before i start scrambling docs and source code (i've really little 
> experience with kernel module programming, i've done simply things), i 
> want to ask a simple question: can be done using a sort of hooking of 
> internal framebuffer function calls (fb_ops for example) or it's 
> impossible because apps write directly into the framebuffer memory?

fbdefio probably is the nearest to what you are looking for.

It catches changes to the framebuffer (at page level) and calls back to
driver at regular intervals to react on those changes.

Though if your Andriod has some video HW acceleration you are going to
be lost here unless you can get change notification from the hardware
itself and then read back the changes.

Bruno
