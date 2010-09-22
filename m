From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 22 Sep 2010 18:39:27 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <20100922203927.6ff60f7b@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home>
	<4C963E99.9080207@gmx.de>
	<20100919190240.65762511@neptune.home>
	<4C97B079.8050707@gmx.de>
	<20100920213258.1218b284@neptune.home>
	<4C97BF40.6030708@gmx.de>
	<20100920223608.19b4d177@neptune.home>
	<4C97E00B.6090103@gmx.de>
	<20100921075610.1c016c12@pluto.restena.lu>
	<4C985309.5020205@gmx.de>
	<20100921090255.410da2d7@pluto.restena.lu>
	<alpine.LFD.2.00.1009221829590.25874@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1009221829590.25874@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

On Wed, 22 September 2010 James Simmons <jsimmons@infradead.org> wrote:
> > This year someone said he/she would look at making it possible to have
> > multiple concurrently active consoles on distinct framebuffers.
> > Hopefully something is happening on that front (that would certainly
> > also include some fbcon cleanup)
> 
> That would be me.

Thanks for showing up (I didn't find the matching thread, probably
subject and my search terms were no good friends :)

> I have a tree at
> 
> http://git.infradead.org/users/jsimmons/linuxconsole-2.6.git
> 
> but currently fbcon is broken so I'm tracing down the problem.

Thanks for the reference to your tree!

What's you opinion regarding my changes to fbcon in my RFC patch?
Are they ok or would you prefer having fbcon changed to stop peeking
at registered_fb list and just operate directly on fb_info everywhere
it needs it? (that is let con2fb_map[] point to fb_info instead of
indexes into registered_fb? (I have a preference for the second one
and will try it out)

Thanks,
Bruno
