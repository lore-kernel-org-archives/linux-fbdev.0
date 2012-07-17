From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 17 Jul 2012 13:20:32 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120717132032.GD27595@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <4FFE4DD0.7020407@nvidia.com> <50035582.9070308@gmail.com>
 <CAJOA=zMKE1Z_AsYeWr22k58EDskx0eshEjv9VbLQHKFsA0uThw@mail.gmail.com>
 <50055C83.7060700@nvidia.com>
In-Reply-To: <50055C83.7060700@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 17, 2012 at 06:07:23PM +0530, Prashant Gaikwad wrote:
> On Tuesday 17 July 2012 12:06 AM, Turquette, Mike wrote:

> reg : operating voltage in microvolt

What happens if there's more than one supply that needs to be varied?

> tolerance : can be used to calculate required voltage. (optional,
> can be replaced by other relevant parameter to calculate required
> voltage)

What are the semantics of this field?
