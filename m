From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Tue, 08 May 2012 10:29:47 +0000
Subject: Re: ASoC: wm9712: Microphone doesn't work, "Capture Volume" inverted
Message-Id: <20120508102947.GA8226@lovely.krouter>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<1335513602.3504.4.camel@mars>
	<20120427134638.GI18260@opensource.wolfsonmicro.com>
	<20120504132845.GA24245@lovely.krouter>
	<20120507215506.GA5063@lovely.krouter>
In-Reply-To: <20120507215506.GA5063@lovely.krouter>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>, linux-fbdev@vger.kernel.org

On Mon, May 07, 2012 at 11:55:06PM +0200, Christoph Fritz wrote:
> On Fri, May 04, 2012 at 03:28:45PM +0200, Christoph Fritz wrote:
> > On Fri, Apr 27, 2012 at 02:46:39PM +0100, Mark Brown wrote:
> > > On Fri, Apr 27, 2012 at 10:00:02AM +0200, Christoph Fritz wrote:
> > > > On Thu, 2012-04-26 at 22:37 +0100, Mark Brown wrote:
> > > 
> > > > >   The write will be suppresed if the register contents don't
> > > > > change which looks like what you're seeing here - 
> > > 
> > > > Can you imagine why the registers don't change?
> > > 
> > > I can't immediately think of any reason, no - I'd step through or
> > > annotate the code and have a look.
> > 
> > I'm still on.
> > 
> > And while testing WM9712 its touchpad interface, connecting a 800x600
> > display (instead of the default 640x480 one) results in a gone sound and
> > input-device - pretty queer:
> > 
> > WM9711/WM9712 SoC Audio Codec 0.4
> > asoc: platform pcm constructor failed
> > asoc: can't create pcm HiFi
> > asoc: failed to instantiate card PhyCORE-ac97-audio: -12
> > 
> > I have to admit that I used this time a 3.2 kernel. I'll test with
> > current later these days.
> 
> Same behaviour with 3.4.0-rc6:
> 
> Framebuffer driver mx3fb configured for a 800x600 display:
> 
>   soc-audio soc-audio: ASoC machine PhyCORE-ac97-audio should use snd_soc_register_card()
>   asoc: platform pcm constructor failed
>   asoc: can't create pcm HiFi :-12
>   asoc: failed to instantiate card PhyCORE-ac97-audio: -12

When I do decrease from 800x600 to 800x594, wm9712 works. 

Any ideas?

> 
> 
> mx3fb configured for a 640x480 display:
>   soc-audio soc-audio: ASoC machine PhyCORE-ac97-audio should use
>   snd_soc_register_card()
>   asoc: wm9712-hifi <-> imx-ssi.0 mapping ok
> 
>  
> Thanks,
>  -- Christoph
