From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 17 Jul 2012 14:37:54 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120717143754.GB3107@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <4FFE4DD0.7020407@nvidia.com> <50035582.9070308@gmail.com>
 <CAJOA=zMKE1Z_AsYeWr22k58EDskx0eshEjv9VbLQHKFsA0uThw@mail.gmail.com>
 <50055C83.7060700@nvidia.com>
 <20120717132032.GD27595@sirena.org.uk>
 <50057514.5070501@nvidia.com>
In-Reply-To: <50057514.5070501@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 17, 2012 at 07:52:12PM +0530, Prashant Gaikwad wrote:

> >What happens if there's more than one supply that needs to be varied?

> Each rail's dvfs-table will have OPP nodes defined for different
> voltages and each OPP node contains frequency for all clocks
> affecting that rail.

Right, but some systems have operating points which cover a combination
of voltages and frequencies in one operating point.  Your binding seems
to define operating points per supply with no tie in between supplies.
