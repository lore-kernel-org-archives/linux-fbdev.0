From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Wed, 16 Nov 2016 09:43:58 +0000
Subject: Re: [RFCv2 PATCH 1/5] video: add HDMI state notifier support
Message-Id: <87cc4a9c-bc1b-173e-693c-17a270fbed6b@xs4all.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479136968-24477-1-git-send-email-hverkuil@xs4all.nl>
 <1479136968-24477-2-git-send-email-hverkuil@xs4all.nl>
 <1479234278.2456.49.camel@pengutronix.de>
 <00ad0ddf-3e52-62e6-f863-cae6eefd08c9@xs4all.nl>
In-Reply-To: <00ad0ddf-3e52-62e6-f863-cae6eefd08c9@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, Hans Verkuil <hans.verkuil@cisco.com>

On 11/15/16 21:41, Hans Verkuil wrote:
> Hi Philipp,
>
> On 11/15/2016 07:24 PM, Philipp Zabel wrote:
>> Hi Hans,
>>
>> Am Montag, den 14.11.2016, 16:22 +0100 schrieb Hans Verkuil:
>>> From: Hans Verkuil <hans.verkuil@cisco.com>
>>>
>>> Add support for HDMI hotplug and EDID notifiers, which is used to convey
>>> information from HDMI drivers to their CEC and audio counterparts.
>>>
>>> Based on an earlier version from Russell King:
>>>
>>> https://patchwork.kernel.org/patch/9277043/
>>>
>>> The hdmi_notifier is a reference counted object containing the HDMI state
>>> of an HDMI device.
>>>
>>> When a new notifier is registered the current state will be reported to
>>> that notifier at registration time.
>>>
>>> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
>>> ---
>>>  drivers/video/Kconfig         |   3 +
>>>  drivers/video/Makefile        |   1 +
>>>  drivers/video/hdmi-notifier.c | 136 ++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/hdmi-notifier.h |  43 +++++++++++++
>>>  4 files changed, 183 insertions(+)
>>>  create mode 100644 drivers/video/hdmi-notifier.c
>>>  create mode 100644 include/linux/hdmi-notifier.h
>>>
>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>> index 3c20af9..1ee7b9f 100644
>>> --- a/drivers/video/Kconfig
>>> +++ b/drivers/video/Kconfig
>>> @@ -36,6 +36,9 @@ config VIDEOMODE_HELPERS
>>>  config HDMI
>>>  	bool
>>>
>>> +config HDMI_NOTIFIERS
>>> +	bool
>>> +
>>>  if VT
>>>  	source "drivers/video/console/Kconfig"
>>>  endif
>>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>>> index 9ad3c17..65f5649 100644
>>> --- a/drivers/video/Makefile
>>> +++ b/drivers/video/Makefile
>>> @@ -1,5 +1,6 @@
>>>  obj-$(CONFIG_VGASTATE)            += vgastate.o
>>>  obj-$(CONFIG_HDMI)                += hdmi.o
>>> +obj-$(CONFIG_HDMI_NOTIFIERS)      += hdmi-notifier.o
>>>
>>>  obj-$(CONFIG_VT)		  += console/
>>>  obj-$(CONFIG_LOGO)		  += logo/
>>> diff --git a/drivers/video/hdmi-notifier.c b/drivers/video/hdmi-notifier.c
>>> new file mode 100644
>>> index 0000000..c2a4f1b
>>> --- /dev/null
>>> +++ b/drivers/video/hdmi-notifier.c
>>> @@ -0,0 +1,136 @@
>>> +#include <linux/export.h>
>>> +#include <linux/hdmi-notifier.h>
>>> +#include <linux/string.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/list.h>
>>> +
>>> +struct hdmi_notifiers {
>>> +	struct list_head head;
>>> +	struct device *dev;
>>> +	struct hdmi_notifier *n;
>>> +};
>>
>> This struct is not used, can be removed.
>
> Indeed.
>
>>
>>> +static LIST_HEAD(hdmi_notifiers);
>>> +static DEFINE_MUTEX(hdmi_notifiers_lock);
>>> +
>>> +struct hdmi_notifier *hdmi_notifier_get(struct device *dev)
>>> +{
>>> +	struct hdmi_notifier *n;
>>> +
>>> +	mutex_lock(&hdmi_notifiers_lock);
>>> +	list_for_each_entry(n, &hdmi_notifiers, head) {
>>> +		if (n->dev = dev) {
>>> +			mutex_unlock(&hdmi_notifiers_lock);
>>> +			kref_get(&n->kref);
>>> +			return n;
>>> +		}
>>> +	}
>>> +	n = kzalloc(sizeof(*n), GFP_KERNEL);
>>> +	if (!n)
>>> +		goto unlock;
>>> +	mutex_init(&n->lock);
>>> +	BLOCKING_INIT_NOTIFIER_HEAD(&n->notifiers);
>>> +	kref_init(&n->kref);
>>
>> +	n->dev = dev;
>>
>> Currently n->dev is never set, so every caller of this function gets its
>> own hdmi_notifier.
>
> Oops! Well, I did say it was compile-tested only :-)
>
>>
>>> +	list_add_tail(&n->head, &hdmi_notifiers);
>>> +unlock:
>>> +	mutex_unlock(&hdmi_notifiers_lock);
>>> +	return n;
>>> +}
>>> +EXPORT_SYMBOL_GPL(hdmi_notifier_get);
>>> +
>>> +static void hdmi_notifier_release(struct kref *kref)
>>> +{
>>> +	struct hdmi_notifier *n >>> +		container_of(kref, struct hdmi_notifier, kref);
>>> +

I also forgot to remove this notifier from the global list.

I've updated my git branch to fix this.

	Hans
