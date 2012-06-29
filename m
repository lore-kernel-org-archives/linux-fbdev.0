From: Archit Taneja <a0393947@ti.com>
Date: Fri, 29 Jun 2012 10:40:08 +0000
Subject: Re: [PATCH 07/12] OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface drive
Message-Id: <4FED8338.5060606@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340893842-10626-1-git-send-email-archit@ti.com>  <1340893842-10626-9-git-send-email-archit@ti.com> <1340964745.1866.26.camel@lappyti>
In-Reply-To: <1340964745.1866.26.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 29 June 2012 03:42 PM, Tomi Valkeinen wrote:
> On Thu, 2012-06-28 at 20:00 +0530, Archit Taneja wrote:
>> Replace the DISPC fuctions used to configure LCD channel related manager
>> parameters with dss_mgr_set_lcd_config() in APPLY. This function ensures that
>> the DISPC registers are written at the right time by using the shadow register
>> programming model.
>>
>> The LCD manager configurations is stored as a private data of manager in APPLY.
>> It is treated as an extra info as it's the panel drivers which trigger this
>> apply via interface drivers, and not a DSS2 user like omapfb or omapdrm.
>>
>> Storing LCD manager related properties in APPLY also prevents the need to refer
>> to the panel connected to the manager for information. This helps in making the
>> DSS driver less dependent on panel.
>>
>> A helper function is added to check whether the manager is LCD or TV. The direct
>> DISPC register writes are removed from the interface drivers.
>
>
>
>> +static void dss_apply_mgr_lcd_config(struct omap_overlay_manager *mgr,
>> +		struct dss_lcd_mgr_config config)
>> +{
>
> This one should take a pointer to the config, not a copy (and const).
>
>> +	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>> +
>> +	mp->lcd_config = config;
>> +	mp->extra_info_dirty = true;
>> +}
>> +
>> +void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
>> +		struct dss_lcd_mgr_config config)
>
> And this.

Will fix these.

>
>> +{
>> +	unsigned long flags;
>> +	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>> +
>> +	mutex_lock(&apply_lock);
>> +
>> +	if (mp->enabled)
>> +		goto out;
>
> Hmm. Should we print a warning or such here? Isn't it a bug in the
> interface driver, if it tries to set the lcd config when the output is
> enabled?

Yes, we should add an error here. Will add it.

Archit
