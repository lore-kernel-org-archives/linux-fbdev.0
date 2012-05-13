From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Sun, 13 May 2012 03:56:53 +0000
Subject: Re: ASoC: wm9712: Microphone doesn't work: Mux handling broken?
Message-Id: <20120513035652.GA3532@lovely.krouter>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<1335513602.3504.4.camel@mars>
	<20120427134638.GI18260@opensource.wolfsonmicro.com>
	<20120504132845.GA24245@lovely.krouter>
	<20120507215506.GA5063@lovely.krouter>
	<20120508102947.GA8226@lovely.krouter>
	<20120512001556.GA26105@mars>
	<20120512115130.GI1781@opensource.wolfsonmicro.com>
In-Reply-To: <20120512115130.GI1781@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>, linux-fbdev@vger.kernel.org

On Sat, May 12, 2012 at 12:51:31PM +0100, Mark Brown wrote:
> On Sat, May 12, 2012 at 02:15:56AM +0200, Christoph Fritz wrote:
> 
> > They refuse to change their Item0 because they are defined as
> > SND_SOC_DAPM_MUX without a correlating path->name so that
> > snd_soc_dapm_mux_update_power() (in sound/soc/soc-dapmc) doesn't
> > change anything.
> 
> A route into a mux without a path name (other than a supply) just isn't
> meaningful and I'm surprised it ever worked.
> 
> > It works in 2.6.33, but current kernel has different mux handling and
> > it seems that no one since cared that much about microphone support.
> 
> It's nothing to do with microphones really, it's more that AC'97 CODECs
> are rarely used with modern kernels as the boards that use AC'97 are
> mostly quite old and suffer performance issues with modern software
> stacks so newer kernels haven't been getting much testing with them.
> 
> > Mark, can you confirm this, purpose a fix or even come up with
> > a patch?
> 
> Just filling in the appropriate mux value in the relevant route should
> do the trick.  Looking at the code it looks like the widget isn't hooked
> into the audio routing map at all so I'm a little surprised.  I'm out of
> the office at the minute and so can't readily set up a test system
> myself.

Thanks Mark, I'm pretty interested in testing too :-)

 -- Christoph

