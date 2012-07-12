From: Prashant Gaikwad <pgaikwad@nvidia.com>
Date: Thu, 12 Jul 2012 04:29:42 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <4FFE4FE6.20109@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk>
In-Reply-To: <20120711144449.GA23654@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 11 July 2012 08:14 PM, Mark Brown wrote:
> On Wed, Jul 11, 2012 at 09:03:41AM -0500, Rob Herring wrote:
>
>> I'd expect a single property with freq/volt pairs or 2 properties for
>> freq and voltage where there is a 1:1 relationship (freq N uses voltage N).
> I strongly agree - the current proposal is very hard to read due to the
> separation between the voltage and frequency values.  Some devices do
> also need to scale multiple rails together, especially when this gets
> used for I/O devices.

Multiple rails for single clock or would it be multiple clocks?

> I'd also expect to see a range of voltages for each frequency rather
> than a specific voltage; usually things are at least characterised with
> a specified tolerance.

But then how will you determine the operating voltage for a frequency?
