From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 13:44:37 +0000
Subject: Re: [PATCH v2] console/fbcon: Add support for deferred console takeover
Message-Id: <95541276-87bc-c566-3abf-be0ac654df0a@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626104103.12208-1-hdegoede@redhat.com>
 <20180626120159.GA13978@phenom.ffwll.local>
In-Reply-To: <20180626120159.GA13978@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,

On 26-06-18 14:01, Daniel Vetter wrote:
> On Tue, Jun 26, 2018 at 12:41:03PM +0200, Hans de Goede wrote:
>> Currently fbcon claims fbdevs as soon as they are registered and takes over
>> the console as soon as the first fbdev gets registered.
>>
>> This behavior is undesirable in cases where a smooth graphical bootup is
>> desired, in such cases we typically want the contents of the framebuffer
>> (typically a vendor logo) to stay in place as is.
>>
>> The current solution for this problem (on embedded systems) is to not
>> enable fbcon.
>>
>> This commit adds a new FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER config option,
>> which when enabled defers fbcon taking over the console from the dummy
>> console until the first text is displayed on the console. Together with the
>> "quiet" kernel commandline option, this allows fbcon to still be used
>> together with a smooth graphical bootup, having it take over the console as
>> soon as e.g. an error message is logged.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Check the whole string when checking for erases in putcs, instead of just
>>   the first char
>> -Make dummycon_blank return 1, so that a redraw gets triggered and any text
>>   rendered while blanked gets output so that it can trigger a deferred
>>   takeover if one is pending
>> ---
>>   drivers/video/console/Kconfig    | 11 ++++++
>>   drivers/video/console/dummycon.c | 67 ++++++++++++++++++++++++++++----
>>   drivers/video/fbdev/core/fbcon.c | 65 +++++++++++++++++++++++++++++++
>>   include/linux/console.h          |  5 +++
>>   4 files changed, 140 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
>> index 4110ba7d7ca9..e91edef98633 100644
>> --- a/drivers/video/console/Kconfig
>> +++ b/drivers/video/console/Kconfig
>> @@ -150,6 +150,17 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>>            such that other users of the framebuffer will remain normally
>>            oriented.
>>   
>> +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>> +	bool "Framebuffer Console Deferred Takeover"
>> +	depends on FRAMEBUFFER_CONSOLE=y && DUMMY_CONSOLE=y
>> +	help
>> +	  If enabled this defers the framebuffer console taking over the
>> +	  console from the dummy console until the first text is displayed on
>> +	  the console. This is useful in combination with the "quiet" kernel
>> +	  commandline option to keep the framebuffer contents initially put up
>> +	  by the firmware in place, rather then replacing the contents with a
>> +	  black screen as soon as fbcon loads.
>> +
>>   config STI_CONSOLE
>>           bool "STI text console"
>>   	depends on PARISC && HAS_IOMEM
>> diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
>> index f2eafe2ed980..45ad925ad5f8 100644
>> --- a/drivers/video/console/dummycon.c
>> +++ b/drivers/video/console/dummycon.c
>> @@ -26,6 +26,65 @@
>>   #define DUMMY_ROWS	CONFIG_DUMMY_CONSOLE_ROWS
>>   #endif
>>   
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>> +/* These are both protected by the console_lock */
>> +static RAW_NOTIFIER_HEAD(dummycon_output_nh);
>> +static bool dummycon_putc_called;
>> +
>> +void dummycon_register_output_notifier(struct notifier_block *nb)
>> +{
>> +	raw_notifier_chain_register(&dummycon_output_nh, nb);
>> +
>> +	if (dummycon_putc_called)
>> +		nb->notifier_call(nb, 0, NULL);
>> +}
>> +
>> +void dummycon_unregister_output_notifier(struct notifier_block *nb)
>> +{
>> +	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
>> +}
>> +
>> +static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
>> +{
>> +	dummycon_putc_called = true;
>> +	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
>> +}
>> +
>> +static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
>> +			   int count, int ypos, int xpos)
>> +{
>> +	int i;
>> +
>> +	if (!dummycon_putc_called) {
>> +		/* Ignore erases */
>> +		for (i = 0 ; i < count; i++) {
>> +			if (s[i] != vc->vc_video_erase_char)
>> +				break;
>> +		}
>> +		if (i = count)
>> +			return;
>> +
>> +		dummycon_putc_called = true;
>> +	}
>> +
>> +	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
>> +}
>> +
>> +static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
>> +{
>> +	/* Redraw, so that we get putc(s) for output done while blanked */
>> +	return 1;
>> +}
>> +#else
>> +static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
>> +static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
>> +			   int count, int ypos, int xpos) { }
>> +static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>   static const char *dummycon_startup(void)
>>   {
>>       return "dummy device";
>> @@ -44,9 +103,6 @@ static void dummycon_init(struct vc_data *vc, int init)
>>   static void dummycon_deinit(struct vc_data *vc) { }
>>   static void dummycon_clear(struct vc_data *vc, int sy, int sx, int height,
>>   			   int width) { }
>> -static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
>> -static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
>> -			   int count, int ypos, int xpos) { }
>>   static void dummycon_cursor(struct vc_data *vc, int mode) { }
>>   
>>   static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
>> @@ -61,11 +117,6 @@ static int dummycon_switch(struct vc_data *vc)
>>   	return 0;
>>   }
>>   
>> -static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
>> -{
>> -	return 0;
>> -}
>> -
>>   static int dummycon_font_set(struct vc_data *vc, struct console_font *font,
>>   			     unsigned int flags)
>>   {
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index c910e74d46ff..12d947bc0f0b 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -129,6 +129,12 @@ static inline void fbcon_map_override(void)
>>   }
>>   #endif /* CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY */
>>   
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>> +static bool deferred_takeover = true;
>> +#else
>> +#define deferred_takeover false
>> +#endif
>> +
>>   /* font data */
>>   static char fontname[40];
>>   
>> @@ -499,6 +505,12 @@ static int __init fb_console_setup(char *this_opt)
>>   				margin_color = simple_strtoul(options, &options, 0);
>>   			continue;
>>   		}
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>> +		if (!strcmp(options, "nodefer")) {
>> +			deferred_takeover = false;
>> +			continue;
>> +		}
>> +#endif
>>   	}
>>   	return 1;
>>   }
>> @@ -3094,6 +3106,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>>   {
>>   	int i, idx;
>>   
>> +	if (deferred_takeover)
>> +		return 0;
>> +
>>   	idx = info->node;
>>   	for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>   		if (con2fb_map[i] = idx)
>> @@ -3131,6 +3146,14 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>>   static void fbcon_remap_all(int idx)
>>   {
>>   	int i;
>> +
>> +	if (deferred_takeover) {
>> +		for (i = first_fb_vc; i <= last_fb_vc; i++)
>> +			con2fb_map_boot[i] = idx;
>> +		fbcon_map_override();
>> +		return;
>> +	}
>> +
>>   	for (i = first_fb_vc; i <= last_fb_vc; i++)
>>   		set_con2fb_map(i, idx, 0);
>>   
>> @@ -3180,6 +3203,11 @@ static int fbcon_fb_registered(struct fb_info *info)
>>   	idx = info->node;
>>   	fbcon_select_primary(info);
>>   
>> +	if (deferred_takeover) {
>> +		pr_info("fbcon: Deferring console take-over\n");
>> +		return 0;
>> +	}
>> +
>>   	if (info_idx = -1) {
>>   		for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>   			if (con2fb_map_boot[i] = idx) {
>> @@ -3555,8 +3583,45 @@ static int fbcon_init_device(void)
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>> +static struct notifier_block fbcon_output_nb;
>> +
>> +/* called with console_lock held */
>> +static int fbcon_output_notifier(struct notifier_block *nb,
>> +				 unsigned long action, void *data)
>> +{
>> +	int i;
>> +
>> +	pr_info("fbcon: Taking over console\n");
>> +
>> +	dummycon_unregister_output_notifier(&fbcon_output_nb);
>> +	deferred_takeover = false;
>> +	logo_shown = FBCON_LOGO_DONTSHOW;
>> +
>> +	for (i = 0; i < FB_MAX; i++) {
>> +		if (registered_fb[i])
>> +			fbcon_fb_registered(registered_fb[i]);
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static void fbcon_register_output_notifier(void)
>> +{
>> +	fbcon_output_nb.notifier_call = fbcon_output_notifier;
>> +	dummycon_register_output_notifier(&fbcon_output_nb);
>> +}
>> +#else
>> +static inline void fbcon_register_output_notifier(void) {}
>> +#endif
>> +
>>   static void fbcon_start(void)
>>   {
>> +	if (deferred_takeover) {
>> +		fbcon_register_output_notifier();
> 
> Nothing seems to unregister the notifier in fbcon_exit. Not likely in your
> use-case, but let's make sure this is correct.
> 
> Another request: Please create a console_lock_assert_held() in printk.c
> (or export the existing is_console_locked to make WARN_CONSOLE_UNLOCKED
> work properly in modules),

I've exported the existing is_console_locked() for v3 of my patchset
(in a separate prep. patch).

> and then sprinkle those into
> fbcon_fb_(un)registered.

Also done for v3, also in a separate prep. patch.

> fbcon and console subsystem locking is a major
> headache, I want to at least annotate stuff for when I have to review
> things again.

Ack.

> On that note: Notifiers are a real pain, but since there's only a BKL for
> everything console related the usual locking inversions between
> registering and callbacks can't happen. If dummycon and fbcon would each
> have their own locks, the simple notifier wouldn't work.
> 
> With the above addressed:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks, added for v3 which I will send out after some testing.

Regards,

Hans


> 
>> +		return;
>> +	}
>> +
>>   	if (num_registered_fb) {
>>   		int i;
>>   
>> diff --git a/include/linux/console.h b/include/linux/console.h
>> index dfd6b0e97855..f59f3dbca65c 100644
>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -21,6 +21,7 @@ struct console_font_op;
>>   struct console_font;
>>   struct module;
>>   struct tty_struct;
>> +struct notifier_block;
>>   
>>   /*
>>    * this is what the terminal answers to a ESC-Z or csi0c query.
>> @@ -220,4 +221,8 @@ static inline bool vgacon_text_force(void) { return false; }
>>   
>>   extern void console_init(void);
>>   
>> +/* For deferred console takeover */
>> +void dummycon_register_output_notifier(struct notifier_block *nb);
>> +void dummycon_unregister_output_notifier(struct notifier_block *nb);
>> +
>>   #endif /* _LINUX_CONSOLE_H */
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
