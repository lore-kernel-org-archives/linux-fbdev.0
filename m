From: Peter De Schrijver <pdeschrijver@nvidia.com>
Date: Thu, 12 Jul 2012 08:19:15 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120712081915.GD9437@tbergstrom-lnx.Nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk>
In-Reply-To: <20120711144449.GA23654@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 11, 2012 at 04:44:50PM +0200, Mark Brown wrote:
> On Wed, Jul 11, 2012 at 09:03:41AM -0500, Rob Herring wrote:
> 
> > I'd expect a single property with freq/volt pairs or 2 properties for
> > freq and voltage where there is a 1:1 relationship (freq N uses voltage N).
> 
> I strongly agree - the current proposal is very hard to read due to the
> separation between the voltage and frequency values.  Some devices do
> also need to scale multiple rails together, especially when this gets
> used for I/O devices.
> 

I don't think dependencies between rails should be modelled in the same DT
nodes. We have those too in Tegra30, but as this is SoC internal, I am not
sure if it needs to be modelled in DT at all, or if we can leave it in SoC
specific code. While our current dependency is of the form 'voltage difference
between rail x and rail y must be smaller then z mV', I have been told these
dependencies might become more complicated in the future. Hence they might
need to be expressed in code anyway.
Anyway, I think voltage dependencies between rails is a related but seperate
topic from DVFS.

Cheers,

Peter.
