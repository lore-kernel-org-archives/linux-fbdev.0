From: Luc Verhaegen <libv@skynet.be>
Date: Mon, 29 Sep 2014 22:02:50 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929220250.GD5599@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
In-Reply-To: <20140929165842.GC5599@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 29, 2014 at 06:58:42PM +0200, Luc Verhaegen wrote:
> 
> In the 2nd round of this discussion, i stated that another fb or even a 
> drm driver altogether seemed to be the sensible way out of this mess.
> 
> I suggest drm_rescue.
> 
> Very early on, now almost two months back, i used the word "denialfb".
> rpifb is the real name of this thing though, but then the dt binding 
> names would have to change and whatnot.
> 
> I don't get the resistance, at least not from a technical point of view. 
> And i do not care enough to get properly involved in this pointless and 
> endless discussion. drm_rescue it is.
> 
> Luc Verhaegen.

So Thierry, let's review what we have achieved here.

1) you keep simplefb absolutely true to the name. Congratulations.
2) Simplefb will only have a single user: the rpi. As the only other 
users i can think of, which does not have a full driver and which does 
not have clocks automatically disabled, are discrete cards. And they do 
not really tend to happen with dt or platform devices.
3) a competing driver will be created, which will do these dt-ishy 
things.
4) it's just a matter of time before the rpi either gets a full driver, 
or switches over to the driver that everyone else is actually using. And 
then the misnomer gets deprecated.

Was that the outcome you were looking for? I think not.

Luc Verhaegen.
