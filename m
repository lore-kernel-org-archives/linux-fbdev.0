From: Mike Turquette <mturquette@ti.com>
Date: Thu, 12 Jul 2012 17:01:51 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120712170151.GK2772@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk> <4FFE4FE6.20109@nvidia.com>
In-Reply-To: <4FFE4FE6.20109@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 20120712-09:47, Prashant Gaikwad wrote:
> On Wednesday 11 July 2012 08:14 PM, Mark Brown wrote:
> >On Wed, Jul 11, 2012 at 09:03:41AM -0500, Rob Herring wrote:
> >
> >>I'd expect a single property with freq/volt pairs or 2 properties for
> >>freq and voltage where there is a 1:1 relationship (freq N uses voltage N).
> >I strongly agree - the current proposal is very hard to read due to the
> >separation between the voltage and frequency values.  Some devices do
> >also need to scale multiple rails together, especially when this gets
> >used for I/O devices.
> 
> Multiple rails for single clock or would it be multiple clocks?
> 

Voltage rails do not correspond to clocks.  They correspond to the IP
block in question (e.g. the "module" or "device" that consumes clocks
and voltage).

Regards,
Mike
