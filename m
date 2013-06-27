From: Yijing Wang <wangyijing@huawei.com>
Date: Thu, 27 Jun 2013 01:51:56 +0000
Subject: Re: [PATCH 9/9] radeon: use pdev->pm_cap instead of pci_find_capability(..,PCI_CAP_ID_PM)
Message-Id: <51CB9ABC.20704@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372209221-16492-1-git-send-email-wangyijing@huawei.com> <51CAE967.7080704@ti.com>
In-Reply-To: <51CAE967.7080704@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

On 2013/6/26 21:15, Tomi Valkeinen wrote:
> On 26/06/13 04:13, Yijing Wang wrote:
>> Pci core has been saved pm cap register offset by pdev->pm_cap in pci_pm_init()
>> in init path. So we can use pdev->pm_cap instead of using
>> pci_find_capability(pdev, PCI_CAP_ID_PM) for better performance and simplified code.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/video/aty/radeon_pm.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
>> index 92bda58..f7091ec 100644
>> --- a/drivers/video/aty/radeon_pm.c
>> +++ b/drivers/video/aty/radeon_pm.c
>> @@ -2805,7 +2805,7 @@ static void radeonfb_early_resume(void *data)
>>  void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlist, int force_sleep)
>>  {
>>  	/* Find PM registers in config space if any*/
>> -	rinfo->pm_reg = pci_find_capability(rinfo->pdev, PCI_CAP_ID_PM);
>> +	rinfo->pm_reg = rinfo->pdev->pm_cap;
>>  
>>  	/* Enable/Disable dynamic clocks: TODO add sysfs access */
>>  	if (rinfo->family = CHIP_FAMILY_RS480)
> 
> I couldn't find the rest of this series, and I'm not familiar with PCI.
> So: is this patch and "aty128fb: use pdev->pm_cap instead of
> pci_find_capability(..,PCI_CAP_ID_PM)" safe to apply for fbdev-3.11
> without anything else? I.e. has the PCI core changes been merged in 3.10
> or ealier?

Hi Tomi,
   Thanks for your reply. Yes, it's safe, because PCI core has been use pdev->pm_cap to save
the pm capability offset already. And PCI core changes related this pm init code has been merged
long long ago(since year 2008). This series changes just to simplifier driver code about pm code.
It's not necessary to access pci device register to get pm cap again, drivers can use pci device pm_cap
member. and this series had no changes in PCI core. The rest of this series like for bnx2, bnx2x etc has
been tested and accepted by other subsystems.

link:
https://patchwork.kernel.org/patch/2739861/
https://patchwork.kernel.org/patch/2739761/
https://patchwork.kernel.org/patch/2739771/
https://patchwork.kernel.org/patch/2739801/


Thanks!
Yijing

> 
>  Tomi
> 
> 


-- 
Thanks!
Yijing

