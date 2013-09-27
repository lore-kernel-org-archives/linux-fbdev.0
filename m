From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Fri, 27 Sep 2013 06:47:41 +0000
Subject: Re: [PATCH v11 2/8] usb: phy: omap-usb2: use the new generic PHY framework
Message-Id: <5245273D.70903@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377063973-22044-1-git-send-email-kishon@ti.com>
 <1377063973-22044-3-git-send-email-kishon@ti.com>
 <20130926185151.GA8689@kroah.com>
In-Reply-To: <20130926185151.GA8689@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Greg,

On Friday 27 September 2013 12:21 AM, Greg KH wrote:
> On Wed, Aug 21, 2013 at 11:16:07AM +0530, Kishon Vijay Abraham I wrote:
>> Used the generic PHY framework API to create the PHY. Now the power off and
>> power on are done in omap_usb_power_off and omap_usb_power_on respectively.
>> The omap-usb2 driver is also moved to driver/phy.
>>
>> However using the old USB PHY library cannot be completely removed
>> because OTG is intertwined with PHY and moving to the new framework
>> will break OTG. Once we have a separate OTG state machine, we
>> can get rid of the USB PHY library.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> ---
>>  drivers/phy/Kconfig                   |   12 +++++++++
>>  drivers/phy/Makefile                  |    1 +
>>  drivers/{usb => }/phy/phy-omap-usb2.c |   45 ++++++++++++++++++++++++++++++---
>>  drivers/usb/phy/Kconfig               |   10 --------
>>  drivers/usb/phy/Makefile              |    1 -
>>  5 files changed, 54 insertions(+), 15 deletions(-)
>>  rename drivers/{usb => }/phy/phy-omap-usb2.c (88%)
> 
> I tried to apply this to my USB branch, but it fails.
> 
> Kishon, you were going to refresh this patch series, right?  Please do,
> because as-is, I can't take it.

Just sent.

Thanks
Kishon
