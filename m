From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 22 May 2014 08:44:52 +0000
Subject: Re: [PATCH resend 2/4] backlight: Add backlight device (un)registration notification
Message-Id: <537DB904.50901@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400679596-19663-1-git-send-email-hdegoede@redhat.com> <1400679596-19663-3-git-send-email-hdegoede@redhat.com> <82426680.ILvbY8i4gL@vostro.rjw.lan>
In-Reply-To: <82426680.ILvbY8i4gL@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

On 05/22/2014 01:31 AM, Rafael J. Wysocki wrote:
> On Wednesday, May 21, 2014 03:39:54 PM Hans de Goede wrote:
>> Some firmware drivers, ie acpi-video want to get themselves out of the
>> way (in some cases) when their also is a raw backlight device available.
>>
>> Due to module loading ordering being unknown, acpi-video cannot be certain
>> that the backlight_device_registered(BACKLIGHT_RAW) it does for this is
>> the final verdict wrt there being a BACKLIGHT_RAW device.
>>
>> By adding notification acpi-video can listen for backlight devices showing
>> up after it has loaded, and unregister its backlight device if desired.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Backlight maintainer's ACK is requisite here.

Agreed, which is why I send this set to all 3 the backlight maintainers
directly on both postings.

What may be helpful for them is to hear from you if you're ok with the
acpi-video bits which are actually going to use this, since those will
be the only user of the new backlight api (for now).

Thanks & Regardsm

Hans




> 
>> ---
>>  drivers/video/backlight/backlight.c | 40 +++++++++++++++++++++++++++++++++++++
>>  include/linux/backlight.h           |  7 +++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
>> index bd2172c..4280890 100644
>> --- a/drivers/video/backlight/backlight.c
>> +++ b/drivers/video/backlight/backlight.c
>> @@ -23,6 +23,7 @@
>>  
>>  static struct list_head backlight_dev_list;
>>  static struct mutex backlight_dev_list_mutex;
>> +static struct blocking_notifier_head backlight_notifier;
>>  
>>  static const char *const backlight_types[] = {
>>  	[BACKLIGHT_RAW] = "raw",
>> @@ -370,6 +371,9 @@ struct backlight_device *backlight_device_register(const char *name,
>>  	list_add(&new_bd->entry, &backlight_dev_list);
>>  	mutex_unlock(&backlight_dev_list_mutex);
>>  
>> +	blocking_notifier_call_chain(&backlight_notifier,
>> +				     BACKLIGHT_REGISTERED, new_bd);
>> +
>>  	return new_bd;
>>  }
>>  EXPORT_SYMBOL(backlight_device_register);
>> @@ -413,6 +417,10 @@ void backlight_device_unregister(struct backlight_device *bd)
>>  		pmac_backlight = NULL;
>>  	mutex_unlock(&pmac_backlight_mutex);
>>  #endif
>> +
>> +	blocking_notifier_call_chain(&backlight_notifier,
>> +				     BACKLIGHT_UNREGISTERED, bd);
>> +
>>  	mutex_lock(&bd->ops_lock);
>>  	bd->ops = NULL;
>>  	mutex_unlock(&bd->ops_lock);
>> @@ -438,6 +446,36 @@ static int devm_backlight_device_match(struct device *dev, void *res,
>>  }
>>  
>>  /**
>> + * backlight_register_notifier - get notified of backlight (un)registration
>> + * @nb: notifier block with the notifier to call on backlight (un)registration
>> + *
>> + * @return 0 on success, otherwise a negative error code
>> + *
>> + * Register a notifier to get notified when backlight devices get registered
>> + * or unregistered.
>> + */
>> +int backlight_register_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_register(&backlight_notifier, nb);
>> +}
>> +EXPORT_SYMBOL(backlight_register_notifier);
>> +
>> +/**
>> + * backlight_unregister_notifier - unregister a backlight notifier
>> + * @nb: notifier block to unregister
>> + *
>> + * @return 0 on success, otherwise a negative error code
>> + *
>> + * Register a notifier to get notified when backlight devices get registered
>> + * or unregistered.
>> + */
>> +int backlight_unregister_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_unregister(&backlight_notifier, nb);
>> +}
>> +EXPORT_SYMBOL(backlight_unregister_notifier);
>> +
>> +/**
>>   * devm_backlight_device_register - resource managed backlight_device_register()
>>   * @dev: the device to register
>>   * @name: the name of the device
>> @@ -544,6 +582,8 @@ static int __init backlight_class_init(void)
>>  	backlight_class->pm = &backlight_class_dev_pm_ops;
>>  	INIT_LIST_HEAD(&backlight_dev_list);
>>  	mutex_init(&backlight_dev_list_mutex);
>> +	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
>> index 7264742..adb14a8 100644
>> --- a/include/linux/backlight.h
>> +++ b/include/linux/backlight.h
>> @@ -40,6 +40,11 @@ enum backlight_type {
>>  	BACKLIGHT_TYPE_MAX,
>>  };
>>  
>> +enum backlight_notification {
>> +	BACKLIGHT_REGISTERED,
>> +	BACKLIGHT_UNREGISTERED,
>> +};
>> +
>>  struct backlight_device;
>>  struct fb_info;
>>  
>> @@ -133,6 +138,8 @@ extern void devm_backlight_device_unregister(struct device *dev,
>>  extern void backlight_force_update(struct backlight_device *bd,
>>  				   enum backlight_update_reason reason);
>>  extern bool backlight_device_registered(enum backlight_type type);
>> +extern int backlight_register_notifier(struct notifier_block *nb);
>> +extern int backlight_unregister_notifier(struct notifier_block *nb);
>>  
>>  #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
>>  
>>
> 
