From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 23 Apr 2010 22:52:56 +0000
Subject: Re: [PATCH 10/11] viafb: rework the I2C support in the VIA
Message-Id: <20100423165256.654ca5eb@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271614873-5952-1-git-send-email-corbet@lwn.net>
	<1271614873-5952-11-git-send-email-corbet@lwn.net>
	<4BD20D56.7080402@gmx.de>
	<20100423155725.7d3b2d2d@bike.lwn.net>
	<4BD221E7.7060705@gmx.de>
In-Reply-To: <4BD221E7.7060705@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

On Sat, 24 Apr 2010 00:40:39 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> Actually that is probably a mistake on my side. I had the impression 
> that it was much longer but didn't take into account that the old 
> behaviour allowed the VGA console to work until viafb was completly 
> loaded and fbcon took over while the new one immediately destroys the 
> screen and shows random things until it is completely loaded. 

"New one" being new relative to what?  Is that change the result of the
patches I've posted, or something else?

> > As for #2, I can certainly say that I've never unloaded this code, so
> > that's an untested path.  I'll have a look and see if I can see
> > anything obvious.  
> 
> Well as for the behaviour change described above I think the problem 
> might be in the load path. At least when I faked an exit as when memory 
> size detection or ioremapping fails (which is a very common issue that 
> really needs a workaround) I get the same unusable VGA console. This 
> needs to be fixed.

Interesting.  In the environment I've been working in the whole box is
a brick if the framebuffer doesn't come up right.  But things are
pretty solid on that front here.

> This whole I2C stuff seems incredibly unstable I even have indicators 
> that the current code might be to blame for freezing the machine on some 
> configurations with P4M900 IGP. I just try to prevent it to get even 
> worse...

I have to say that i2c has often been the bane of my existence.  It
seems like something that just barely works most of the time.

That said, it's been a long time since I've seen any trouble I could
blame on i2c in the viafb driver.  It's *really* hard to imagine how
it could free machines.  Unless, maybe, you're hitting some sort of
race condition in all of those indexed I/O port operations.  But that
looks like something which would be hard to do on most machines that
would have these chipsets in them.

The second series adds some locking around i2c port operations, but has
not yet pushed that locking into the framebuffer side of the driver;
that would be a good thing to do.

Meanwhile, I'm a little unsure now...is there an action item for me
with regard to the i2c code?  I've been staring at it since your last
note, but I couldn't find any obvious problems.  I do have to say that
Harald's rework is far cleaner than what came before...

Thanks,

jon
