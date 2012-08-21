From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Tue, 21 Aug 2012 11:18:22 +0000
Subject: Re: [PATCH V5 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Message-Id: <CAF0AtAtvyKdW-J97NJ+YNi5pUGQFyxk=B2Eqn_74MZD4dWebEA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1343912532.git.cmahapatra@ti.com>
	<cover.1345468541.git.cmahapatra@ti.com>
	<94a123bbc0a4ecd48fc71275fd5efbe0aac93b87.1345468541.git.cmahapatra@ti.com>
	<1345545312.4085.46.camel@deskari>
In-Reply-To: <1345545312.4085.46.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Aug 21, 2012 at 4:05 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-08-20 at 18:53 +0530, Chandrabhanu Mahapatra wrote:
>> All the cpu_is checks have been moved to dss_init_features function providing a
>> much more generic and cleaner interface. The OMAP version and revision specific
>> initializations in various functions are cleaned and the necessary data are
>> moved to dss_features structure which is local to dss.c.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dss.c |  117 ++++++++++++++++++++++++++---------------
>>  1 file changed, 76 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 10566ae..f6d3d0a 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/gfp.h>
>>
>>  #include <video/omapdss.h>
>>
>> @@ -65,6 +66,12 @@ struct dss_reg {
>>  static int dss_runtime_get(void);
>>  static void dss_runtime_put(void);
>>
>> +struct dss_features {
>> +     u16 fck_div_max;
>> +     int dss_fck_multiplier;
>> +     char *clk_name;
>
> const char *
>
>  Tomi
>

All the values are const. So we have a const pointer dss.feat to hold
this structure. Is a separate
const char *clk_name required?

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
