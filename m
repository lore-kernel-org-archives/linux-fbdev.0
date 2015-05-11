From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Mon, 11 May 2015 13:56:53 +0000
Subject: Re: [PATCHv3 0/4] add devm_of_phy_get_by_index and update platform drivers
Message-Id: <5550B255.3040404@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.44L0.1504231031170.1529-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1504231031170.1529-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Thursday 23 April 2015 08:01 PM, Alan Stern wrote:
> On Wed, 22 Apr 2015, Arun Ramamurthy wrote:
>
>> This patch set adds a new API to get phy by index when multiple
>> phys are present. This patch is based on discussion with Arnd Bergmann
>> about dt bindings for multiple phys.
>>
>> History:
>> v1:
>>      - Removed null pointers on Dmitry's suggestion
>>      - Improved documentation in commit messages
>>      - Exported new phy api
>> v2:
>>      - EHCI and OHCI platform Kconfigs select Generic Phy
>>        to fix build errors in certain configs.
>> v3:
>>      - Made GENERIC_PHY an invisible option so
>>      that other configs can select it
>>      - Added stubs for devm_of_phy_get_by_index
>>      - Reformated code
>>
>> Arun Ramamurthy (4):
>>    phy: phy-core: Make GENERIC_PHY an invisible option
>>    phy: core: Add devm_of_phy_get_by_index to phy-core
>>    usb: ehci-platform: Use devm_of_phy_get_by_index
>>    usb: ohci-platform: Use devm_of_phy_get_by_index
>
> For patches 3 and 4:
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

merged this to linux-phy.

Thanks
Kishon
