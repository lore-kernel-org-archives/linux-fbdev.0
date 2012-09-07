From: Archit Taneja <a0393947@ti.com>
Date: Fri, 07 Sep 2012 11:48:58 +0000
Subject: Re: [PATCH 12/17] OMAPDSS: clean up dss_mgr_set_timings
Message-Id: <5049DC5A.1060601@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>  <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com> <1347012673.2646.3.camel@deskari>
In-Reply-To: <1347012673.2646.3.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 07 September 2012 03:41 PM, Tomi Valkeinen wrote:
> On Wed, 2012-09-05 at 11:25 +0300, Tomi Valkeinen wrote:
>> dss_mgr_set_timings() can only be called when the output is not active.
>> This means that most of the code in the function is extra, as there's no
>> need to write the values to registers, etc, because that will be handled
>> when the output will be enabled.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/apply.c |   18 ++++++++----------
>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
>> index 53629dd..1b49019 100644
>> --- a/drivers/video/omap2/dss/apply.c
>> +++ b/drivers/video/omap2/dss/apply.c
>> @@ -1314,21 +1314,19 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
>>   		const struct omap_video_timings *timings)
>>   {
>>   	unsigned long flags;
>> -
>> -	mutex_lock(&apply_lock);
>> +	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>>
>>   	spin_lock_irqsave(&data_lock, flags);
>>
>> -	dss_apply_mgr_timings(mgr, timings);
>> -
>> -	dss_write_regs();
>> -	dss_set_go_bits();
>> +	if (mp->enabled) {
>> +		DSSERR("cannot set timings for %s: manager needs to be disabled\n",
>> +			mgr->name);
>> +		goto out;
>> +	}
>
> There was a problem with this one. When using manual update display, we
> call set_timings before each update, and the mgr is enabled at that
> time.
>
> I'll fix this by changing the check from mp->enabled to mp->updating.
> That flag tells if the DISPC channel is actually enabled or not. Enabled
> flag just tells that the channel is being reserved, although for auto
> update displays that also implies "updating".
>
> But do you see any reason to call set_timings before each update? It was
> required when we have partial update support, but now we support only
> full screen updates, so isn't it enough to set the timings just once
> when configuring?

I think we put it there for rotation. We may need to swap manager width 
and height before an update.

Archit

