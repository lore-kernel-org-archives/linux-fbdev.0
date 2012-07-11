From: Peter De Schrijver <pdeschrijver@nvidia.com>
Date: Wed, 11 Jul 2012 13:49:00 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120711134900.GA9437@tbergstrom-lnx.Nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20748722.319671342012092123.JavaMail.weblogic@epml17>
In-Reply-To: <20748722.319671342012092123.JavaMail.weblogic@epml17>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 11, 2012 at 03:08:14PM +0200, 함명주 wrote:
> > Hi,
> >
> > I am working on DT binding for Tegra DVFS.
> >
> > For Tegra, DVFS node mainly consists of frequency and voltage pairs. 
> > Frequency in the pair may change for different process. E.g. for process 
> > 1 CPU clock frequency could be 900MHz at 1V while for process 2 it could 
> > be 1GHz at 1V.
> > Tegra uses vendor specific ids to identify the correct frequency table.
> 
> Hello,
> 
> It seems that in the example, the values in "voltage-array" and
> "frequencies" are switched.
> 
> Anyway, what about SoCs that reads information from IEM (or any other module)
>  to measure gate delays or some other value to set the appriorate voltage values
>  for every possible frequency? I remember some of Exynos SoCs have been doing
>  it; dynamically measure the characteristics at boot-up time and apply voltages
>  accordingly; they couldn't identify it based on the chip-id or simply by reading
>  a single register.

But in that case you would have a nominal voltage for each OPP which gets
adjusted at boottime or runtime depending on the exact silicon characteristics?
I would say the DT binding should then specify 1 table with the nominal values
and leave the dynamics to the driver.

Cheers,

Peter.
