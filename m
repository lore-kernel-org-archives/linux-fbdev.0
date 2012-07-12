From: Peter De Schrijver <pdeschrijver@nvidia.com>
Date: Thu, 12 Jul 2012 14:10:01 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120712141001.GE9437@tbergstrom-lnx.Nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk>
 <20120711200402.GC2772@gmail.com>
In-Reply-To: <20120711200402.GC2772@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 11, 2012 at 10:04:02PM +0200, Mike Turquette wrote:
> On 20120711-15:44, Mark Brown wrote:
> > On Wed, Jul 11, 2012 at 09:03:41AM -0500, Rob Herring wrote:
> > 
> > > I'd expect a single property with freq/volt pairs or 2 properties for
> > > freq and voltage where there is a 1:1 relationship (freq N uses voltage N).
> > 
> > I strongly agree - the current proposal is very hard to read due to the
> > separation between the voltage and frequency values.  Some devices do
> > also need to scale multiple rails together, especially when this gets
> > used for I/O devices.
> > 
> > I'd also expect to see a range of voltages for each frequency rather
> > than a specific voltage; usually things are at least characterised with
> > a specified tolerance.
> 
> Not only should we support multiple voltage rails but also multiple
> clocks.  For some devices a DVFS transition is composed of scaling
> multiple clock rates together.  So some sort of clock identifier
> (phandle?) is needed as well.  (forgive my ignorance on the phandle
> part, as I am a DT noob)

I would say this constraint should be expressed in a seperate DT node. In
short I think we have 3 things to model:

+ frequency/voltage relationships
+ power rail constraints (eg voltage difference limit between 2 rails)
+ clock constraints (eg. clock x frequency must be a fixed ratio of clock y
  frequency)

Cheers,

Peter.
