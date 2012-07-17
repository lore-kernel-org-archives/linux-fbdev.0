From: Prashant Gaikwad <pgaikwad@nvidia.com>
Date: Tue, 17 Jul 2012 14:34:12 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <50057514.5070501@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <4FFE4DD0.7020407@nvidia.com> <50035582.9070308@gmail.com>
 <CAJOA=zMKE1Z_AsYeWr22k58EDskx0eshEjv9VbLQHKFsA0uThw@mail.gmail.com>
 <50055C83.7060700@nvidia.com> <20120717132032.GD27595@sirena.org.uk>
In-Reply-To: <20120717132032.GD27595@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 17 July 2012 06:50 PM, Mark Brown wrote:
> On Tue, Jul 17, 2012 at 06:07:23PM +0530, Prashant Gaikwad wrote:
>> On Tuesday 17 July 2012 12:06 AM, Turquette, Mike wrote:
>> reg : operating voltage in microvolt
> What happens if there's more than one supply that needs to be varied?

Each rail's dvfs-table will have OPP nodes defined for different 
voltages and each OPP node contains frequency for all clocks affecting 
that rail.

Just for presentation:

In following example when <&ref 1> clock rate is set to 500000, sm0 need 
to operate at 750000000 micrvolt and sm1 at 800000000.

dvfs-rail-1 {
      reg_id = <&sm0>;
      opp@750000000 {
              frequency-table@102 {
                      frequencies = <&osc 0 314000>, <&ref 1 500000>;
              };
      };
};

dvfs-rail-2 {
     reg_id = <&sm1>;
     opp@800000000 {
             frequency-table@102 {
                       frequencies = <&ref 1 5000000>;
             };
     };
};

>> tolerance : can be used to calculate required voltage. (optional,
>> can be replaced by other relevant parameter to calculate required
>> voltage)
> What are the semantics of this field?

I used "tolerance" just for example to derive the range of voltage.
May be as done for OMAP,
regulator_set_voltage(mpu_reg, volt - tol, volt + tol);

