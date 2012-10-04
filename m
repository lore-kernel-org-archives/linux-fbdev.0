From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 04 Oct 2012 01:50:17 +0000
Subject: Re: [PATCH V3] video: exynos_dp: Add device tree support to DP driver
Message-Id: <005f01cda1d2$9b123c00$d136b400$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348515385-22332-1-git-send-email-ajaykumar.rs@samsung.com>
 <50645848.6080102@gmail.com> <000601cd9d0d$c3296ca0$497c45e0$%han@samsung.com>
 <CAEC9eQNFos4Sw57eubX-USEjKBnKf9ETeWCU_sT1vdX3MgN4dA@mail.gmail.com>
In-Reply-To: <CAEC9eQNFos4Sw57eubX-USEjKBnKf9ETeWCU_sT1vdX3MgN4dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Ajay kumar' <ajaynumb@gmail.com>, linux-fbdev@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, FlorianSchandinat@gmx.de, thomas.ab@samsung.com, 'devicetree-discuss' <devicetree-discuss@lists.ozlabs.org>, 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, October 01, 2012 2:40 PM Ajay kumar wrote
> 
> On Fri, Sep 28, 2012 at 5:41 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Thursday, September 27, 2012 10:45 PM Sylwester Nawrocki wrote
> >> On 09/24/2012 09:36 PM, Ajay Kumar wrote:

[...]

> >> > +Example:
> >> > +
> >> > +SOC specific portion:
> >> > +   dptx_phy: dptx_phy@0x10040720 {
> >> > +           compatible = "samsung,dp-phy";
> >> > +           samsung,dptx_phy_reg =<0x10040720>;
> >> > +           samsung,enable_bit =<1>;
> >> > +   };
> >> > +
> >> > +   display-port-controller {
> >> > +           compatible = "samsung,exynos5-dp";
> >> > +           reg =<0x145B0000 0x10000>;
> >> > +           interrupts =<10 3>;
> >> > +           interrupt-parent =<&combiner>;
> >> > +           dp_phy =<&dptx_phy>;
> >>
> >> Shouldn't it be "samsung,dp_phy" ?
> >
> > Do you mean this ? It is not working.
> > +               dp_phy = "samsung,dp_phy";
> I din't get this.
> What do I need to change here?

As Tomasz Figa mentioned, it means that

-+		dp_phy =<&dptx_phy>;
++		samsung,dp_phy =<&dptx_phy>;

It is because this is a Samsung-specific property.

Best regards,
Jingoo Han



