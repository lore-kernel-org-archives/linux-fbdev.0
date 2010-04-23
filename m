From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Apr 2010 23:21:58 +0000
Subject: Re: [PATCH 10/11] viafb: rework the I2C support in the VIA framebuffer
Message-Id: <4BD22B96.5020102@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271614873-5952-1-git-send-email-corbet@lwn.net>	<1271614873-5952-11-git-send-email-corbet@lwn.net>	<4BD20D56.7080402@gmx.de>	<20100423155725.7d3b2d2d@bike.lwn.net>	<4BD221E7.7060705@gmx.de> <20100423165256.654ca5eb@bike.lwn.net>
In-Reply-To: <20100423165256.654ca5eb@bike.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Jonathan Corbet schrieb:
> On Sat, 24 Apr 2010 00:40:39 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> Actually that is probably a mistake on my side. I had the impression 
>> that it was much longer but didn't take into account that the old 
>> behaviour allowed the VGA console to work until viafb was completly 
>> loaded and fbcon took over while the new one immediately destroys the 
>> screen and shows random things until it is completely loaded. 
> 
> "New one" being new relative to what?  Is that change the result of the
> patches I've posted, or something else?

Relative to the patch we are talking about. With patches 01-09 applied 
it just works fine as it always did (no screen "destruction" on load, a 
working VGA console if unloaded as described earlier). With additionally 
patch 10 applied I get the weird behaviour I'm talking about.

>>> As for #2, I can certainly say that I've never unloaded this code, so
>>> that's an untested path.  I'll have a look and see if I can see
>>> anything obvious.  
>> Well as for the behaviour change described above I think the problem 
>> might be in the load path. At least when I faked an exit as when memory 
>> size detection or ioremapping fails (which is a very common issue that 
>> really needs a workaround) I get the same unusable VGA console. This 
>> needs to be fixed.
> 
> Interesting.  In the environment I've been working in the whole box is
> a brick if the framebuffer doesn't come up right.  But things are
> pretty solid on that front here.

Well the ioremapping fails when huge amount of video memory is available 
(128 MB and up) if no extra space is allocated the "vmalloc=" kernel 
option. To not require it we (a) should only remap the needed memory or 
(b) reduce the memory to be remapped until we succeed (or hit a too low 
value).

>> This whole I2C stuff seems incredibly unstable I even have indicators 
>> that the current code might be to blame for freezing the machine on some 
>> configurations with P4M900 IGP. I just try to prevent it to get even 
>> worse...
> 
> I have to say that i2c has often been the bane of my existence.  It
> seems like something that just barely works most of the time.
> 
> That said, it's been a long time since I've seen any trouble I could
> blame on i2c in the viafb driver.  It's *really* hard to imagine how
> it could free machines.  Unless, maybe, you're hitting some sort of
> race condition in all of those indexed I/O port operations.  But that
> looks like something which would be hard to do on most machines that
> would have these chipsets in them.

I don't know but a freeze reported due to viafb with viafb itself 
exiting due to ioremap failure can't have so much causes. Either we do 
something terribly wrong on the error out side (this might be possible 
regarding the current condition of error handling) or in the I2C setup 
which is done prior to remapping. The full story can be read on
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/539020

> The second series adds some locking around i2c port operations, but has
> not yet pushed that locking into the framebuffer side of the driver;
> that would be a good thing to do.
> 
> Meanwhile, I'm a little unsure now...is there an action item for me
> with regard to the i2c code?  I've been staring at it since your last
> note, but I couldn't find any obvious problems.  I do have to say that
> Harald's rework is far cleaner than what came before...

Well the main question is probably:
How does it change the behaviour towards the hardware?
I tend to think that OLPC might not be the only ones who did something 
weird with it....and we already know that we shouldn't trust the 
documentation too much.


Thanks,

Florian Tobias Schandinat
