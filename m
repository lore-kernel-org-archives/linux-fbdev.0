From: Heiko Schocher <hs@denx.de>
Date: Tue, 26 May 2015 03:56:41 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <5563EEF9.3080901@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de> <5562B9CE.7050807@ti.com>
In-Reply-To: <5562B9CE.7050807@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hello Tomi,

Am 25.05.2015 07:57, schrieb Tomi Valkeinen:
>
>
> On 06/05/15 10:09, Heiko Schocher wrote:
>> commit 92b004d1aa9f ("video/logo: prevent use of logos after they have been freed")
>>
>> added a late_initcall function to mark the logos as freed. In reality
>> the logos are freed later, and fbdev probe may be ran between this
>> late_initcall and the freeing of the logos. In that case the logos
>> would not be drawn. To prevent this introduced a new system_state
>> SYSTEM_FREEING_MEM and set this state before freeing memory. This
>> state could be checked now in fb_find_logo(). This system state
>> is maybe useful on other places too.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>
>> ---
>> Found this issue on an imx6 based board with a display which needs
>> a spi initialization. With 3.18.2 I see a perfect logo, but with
>> current ml, bootlogo is missing, because drm gets probed before
>> spi display, which leads in drm probing is deferred until the
>> spi display is probed. After that drm is probed again ... but
>> this is too late for showing the bootlogo.
>> With this patch, bootlogo is drawn again. I am not sure, if it
>> is so easy to add a new system state ... but we should have a
>> possibility to detect if initdata is freed or not. this is maybe
>> also for other modules interesting. Maybe we add a
>> kernel_initdata_freed()
>> function instead of a new system state?
>>
>>   drivers/video/logo/logo.c | 15 ++++-----------
>>   include/linux/kernel.h    |  1 +
>>   init/main.c               |  1 +
>>   3 files changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
>> index 10fbfd8..d798a9f 100644
>> --- a/drivers/video/logo/logo.c
>> +++ b/drivers/video/logo/logo.c
>> @@ -26,16 +26,6 @@ MODULE_PARM_DESC(nologo, "Disables startup logo");
>>    * Use late_init to mark the logos as freed to prevent any further use.
>>    */
>>
>> -static bool logos_freed;
>> -
>> -static int __init fb_logo_late_init(void)
>> -{
>> -	logos_freed = true;
>> -	return 0;
>> -}
>> -
>> -late_initcall(fb_logo_late_init);
>> -
>>   /* logo's are marked __initdata. Use __init_refok to tell
>>    * modpost that it is intended that this function uses data
>>    * marked __initdata.
>> @@ -44,7 +34,10 @@ const struct linux_logo * __init_refok fb_find_logo(int depth)
>>   {
>>   	const struct linux_logo *logo = NULL;
>>
>> -	if (nologo || logos_freed)
>> +	if (system_state >= SYSTEM_FREEING_MEM)
>> +		return NULL;
>> +
>> +	if (nologo)
>>   		return NULL;
>>
>>   	if (depth >= 1) {
>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>> index 3a5b48e..e5875bf 100644
>> --- a/include/linux/kernel.h
>> +++ b/include/linux/kernel.h
>> @@ -462,6 +462,7 @@ extern bool early_boot_irqs_disabled;
>>   /* Values used for system_state */
>>   extern enum system_states {
>>   	SYSTEM_BOOTING,
>> +	SYSTEM_FREEING_MEM,
>>   	SYSTEM_RUNNING,
>>   	SYSTEM_HALT,
>>   	SYSTEM_POWER_OFF,
>> diff --git a/init/main.c b/init/main.c
>> index 2115055..4965ed0 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -931,6 +931,7 @@ static int __ref kernel_init(void *unused)
>>   	kernel_init_freeable();
>>   	/* need to finish all async __init code before freeing the memory */
>>   	async_synchronize_full();
>> +	system_state = SYSTEM_FREEING_MEM;
>>   	free_initmem();
>>   	mark_rodata_ro();
>>   	system_state = SYSTEM_RUNNING;
>
> Without locking, the initmem may be freed while fb_find_logo() is running.

Yes, you are right, that must be added ... but has such a change a
chance to go in mainline?

BTW: Could this not be currently a problem on multicore systems?
If lets say core 2 just draws the logo, another core 1 calls
fb_logo_late_init() and later core 1 free_initmem(), while the core 2
still draws it?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
