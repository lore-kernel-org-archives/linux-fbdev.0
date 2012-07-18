From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 18 Jul 2012 21:19:57 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120718211957.GA32423@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <4FFE4DD0.7020407@nvidia.com> <50035582.9070308@gmail.com>
 <CAJOA=zMKE1Z_AsYeWr22k58EDskx0eshEjv9VbLQHKFsA0uThw@mail.gmail.com>
 <50055C83.7060700@nvidia.com>
 <20120717132032.GD27595@sirena.org.uk>
 <50057514.5070501@nvidia.com> <20120717143754.GB3107@sirena.org.uk>
 <5006B01E.7020504@nvidia.com>
In-Reply-To: <5006B01E.7020504@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 18, 2012 at 06:16:22PM +0530, Prashant Gaikwad wrote:
> On Tuesday 17 July 2012 08:07 PM, Mark Brown wrote:

> >Right, but some systems have operating points which cover a combination
> >of voltages and frequencies in one operating point.  Your binding seems
> >to define operating points per supply with no tie in between supplies.

> We had discussed this in previous replies and thought that it can be
> expressed in separate DT nodes, may be regulator.

So how are these intended to be tied together?  Is the kernel supposed
to infer the set of possible operating points by looking for overlaps or
does it have a list to work with?
