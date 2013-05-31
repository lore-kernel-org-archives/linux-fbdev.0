From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 31 May 2013 15:17:43 +0000
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Message-Id: <51A8BF17.4050209@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com> <874ndk5sse.fsf@linaro.org>
In-Reply-To: <874ndk5sse.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Hilman <khilman@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 05/30/2013 07:36 PM, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>
>> When using DT, dss device does not have platform data. However,
>> dss_get_ctx_loss_count() uses dss device's platform data to find the
>> get_ctx_loss_count function pointer.
>>
>> To fix this, dss_get_ctx_loss_count() needs to be changed to get the
>> platform data from the omapdss device, which is a "virtual" device and
>> always has platform data.
> Dumb question (since the DSS device model has always been beyond my
> grasp): how/why does the virtual device still have platform_data on a DT
> boot?
>
> Also, this context_loss_count and DT boot is starting to get cumbersome,
> and there's currently no (good) way of handling the context loss in a
> generic way without pdata function pointers.
>
> I'm starting to think we should move towards dropping this OMAP-specific
> context loss counting, and just assume context is always lost.  If there
> are performance problems, runtime PM autosuspend timeouts can be used to
> avoid the transitions.
>
> Or, on some devices, I suspect comparing a few registers against their
> power-on reset values might be a quicker way of detecting lost context
> and would avoid having to call into platform code all together.
Hi Kevin,
I've a question:
Why don't add API in "Kernel/Base PM" framework for context lost detection?
Like pm_was_ctx_lost().

If this topic has been discussed already (many times)) - sorry for the 
noise.
And I'll be very appreciate if you can point me on corresponding 
discussions.
>
> Kevin
>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 94f66f9..bd01608 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -157,7 +157,8 @@ static void dss_restore_context(void)
>>   
>>   int dss_get_ctx_loss_count(void)
>>   {
>> -	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
>> +	struct platform_device *core_pdev = dss_get_core_pdev();
>> +	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;
>>   	int cnt;
>>   
>>   	if (!board_data->get_context_loss_count)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

