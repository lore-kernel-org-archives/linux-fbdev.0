From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 10 Aug 2018 08:50:01 +0000
Subject: Re: [PATCH v2] fbcon: Do not takeover the console from atomic context
Message-Id: <CAKMK7uEOLoCEpaF=ibeXi+Mw3YNB5Dm9vZHzd4ymhfPzCya=2A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180809114215.22028-1-hdegoede@redhat.com>
 <CAKMK7uHNXDkeuyN+TGFqUD+3SB7QU9KJBdQtNQrGWTuY65o2ww@mail.gmail.com>
 <9ddaea15-d206-866a-9ed2-9847fd99fe3c@redhat.com>
In-Reply-To: <9ddaea15-d206-866a-9ed2-9847fd99fe3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Aug 10, 2018 at 10:42 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 09-08-18 15:29, Daniel Vetter wrote:
>>
>> On Thu, Aug 9, 2018 at 1:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Taking over the console involves allocating mem with GFP_KERNEL, talking
>>> to drm drivers, etc. So this should not be done from an atomic context.
>>>
>>> But the console-output trigger deferred console takeover may happen from
>>> an
>>> atomic context, which leads to "BUG: sleeping function called from
>>> invalid
>>> context" errors.
>>>
>>> This commit fixes these errors by doing the deferred takeover from a
>>> workqueue when the notifier runs from an atomic context.
>>>
>>> Note this uses in_atomic, as checkpatch points out this should not be
>>> done from driver code. But the console subsys is not really normal driver
>>> code, specifically it plays some tricks where it disables some locking
>>> when logging an oops, or when logging a lockdep bug when lockdep
>>> debugging
>>> is turned on, so we need to make an exception here.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -Add a comment fbcon.c and the commit message about why we need to use
>>>   in_atomic here, no functional changes
>>> ---
>>>   drivers/video/fbdev/core/fbcon.c | 29 +++++++++++++++++++++++++++--
>>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbcon.c
>>> b/drivers/video/fbdev/core/fbcon.c
>>> index ef8b2d0b7071..31f518f8dde7 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -3592,7 +3592,20 @@ static int fbcon_init_device(void)
>>>   }
>>>
>>>   #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>>> +static void fbcon_register_existing_fbs(struct work_struct *work)
>>> +{
>>> +       int i;
>>> +
>>> +       console_lock();
>>> +
>>> +       for_each_registered_fb(i)
>>> +               fbcon_fb_registered(registered_fb[i]);
>>> +
>>> +       console_unlock();
>>> +}
>>> +
>>>   static struct notifier_block fbcon_output_nb;
>>> +static DECLARE_WORK(fbcon_deferred_takeover_work,
>>> fbcon_register_existing_fbs);
>>>
>>>   static int fbcon_output_notifier(struct notifier_block *nb,
>>>                                   unsigned long action, void *data)
>>> @@ -3607,8 +3620,20 @@ static int fbcon_output_notifier(struct
>>> notifier_block *nb,
>>>          deferred_takeover = false;
>>>          logo_shown = FBCON_LOGO_DONTSHOW;
>>>
>>> -       for_each_registered_fb(i)
>>> -               fbcon_fb_registered(registered_fb[i]);
>>> +       /*
>>> +        * Normally all console output happens in a sleeping context, but
>>> +        * during oopses the kernel goes into a special mode where the
>>> +        * console code may not sleep. We check for this using in_atomic
>>> +        * as the note about in_atomic in preempt.h mentions, in_atomic
>>> +        * does not detect a spinlock being held when non-preemptible, so
>>> +        * we also check for irqs_disabled which covers this case.
>>> +        */
>>
>>
>> If this is only for oopses, then opps_in_progress is what you're
>> looking for.
>
>
> Unfortunately that is not good enough as mentioned in the v2 commit
> message, console output may also happen in atomic context when the
> lockdep code has found an issue (from print_circular_bug).
>
> I've tried replacing:
>
>        if (in_atomic() || irqs_disabled()) {
>
> With:
>
>        if (oops_in_progress) {

You can't use in_atomic() either, because it can't detect atomic
regions on non-preemptible kernels. Unconditionally punting to a
worker is the only solution here I think.

See e.g the entire history around how we call the ->dirty callback in
the drm fbdev emulation. The only generic approach that actually works
is drm_fb_helper_dirty unconditionally offloading everything to a
worker.
-Daniel

> On a system where I know the lockdep code will report a problem
> wrt the bttv driver and here is what happened:
>
> [    7.937690] fbcon: Taking over console
> [    7.937691] BUG: sleeping function called from invalid context at
> mm/slab.h:421
> [    7.937691] in_atomic(): 1, irqs_disabled(): 1, pid: 561, name:
> systemd-udevd
> [    7.937692] INFO: lockdep is turned off.
> [    7.937692] irq event stamp: 196513
> [    7.937692] hardirqs last  enabled at (196513): [<ffffffffbba4314b>]
> _raw_spin_unlock_irqrestore+0x4b/0x60
> [    7.937692] hardirqs last disabled at (196512): [<ffffffffbba43962>]
> _raw_spin_lock_irqsave+0x22/0x81
> [    7.937693] softirqs last  enabled at (196504): [<ffffffffbbe0038c>]
> __do_softirq+0x38c/0x4f7
> [    7.937693] softirqs last disabled at (196401): [<ffffffffbb0c19be>]
> irq_exit+0x10e/0x120
> [    7.937694] CPU: 1 PID: 561 Comm: systemd-udevd Not tainted
> 4.18.0-0.rc8.git1.1.hdg1.fc29.x86_64 #1
> [    7.937694] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./B150M Pro4S/D3, BIOS P7.10 12/06/2016
> [    7.937694] Call Trace:
> [    7.937694]  dump_stack+0x85/0xc0
> [    7.937695]  ___might_sleep.cold.72+0xac/0xbc
> [    7.937695]  kmem_cache_alloc_trace+0x202/0x2f0
> [    7.937695]  ? fbcon_startup+0xae/0x300
> [    7.937695]  fbcon_startup+0xae/0x300
> [    7.937696]  do_take_over_console+0x6d/0x180
> [    7.937696]  do_fbcon_takeover+0x58/0xb0
> [    7.937696]  fbcon_output_notifier.cold.35+0x18/0x44
> [    7.937697]  notifier_call_chain+0x39/0x90
> [    7.937697]  vt_console_print+0x363/0x420
> [    7.937697]  console_unlock+0x422/0x610
> [    7.937697]  vprintk_emit+0x268/0x540
> [    7.937698]  ? kernel_text_address+0xe5/0xf0
> [    7.937698]  printk+0x58/0x6f
> [    7.937698]  print_circular_bug_header.cold.56+0x17/0x9c
> [    7.937698]  print_circular_bug.isra.38+0x7c/0xb0
> [    7.937699]  __lock_acquire+0x139a/0x16c0
> [    7.937699]  lock_acquire+0x9e/0x1b0
> [    7.937699]  ? find_ref_lock+0x21/0x40 [videodev]
> [    7.937699]  ? find_ref_lock+0x21/0x40 [videodev]
> [    7.937700]  __mutex_lock+0x88/0xa10
> [    7.937700]  ? find_ref_lock+0x21/0x40 [videodev]
> [    7.937700]  ? bttv_gpio_bits+0x22/0x60 [bttv]
> [    7.937700]  ? native_sched_clock+0x3e/0xa0
> [    7.937701]  ? mark_held_locks+0x57/0x80
> [    7.937701]  ? _raw_spin_unlock_irqrestore+0x4b/0x60
> [    7.937701]  ? find_ref_lock+0x21/0x40 [videodev]
> [    7.937701]  find_ref_lock+0x21/0x40 [videodev]
> [    7.937702]  v4l2_ctrl_find+0xa/0x20 [videodev]
> [    7.937702]  audio_mute+0x38/0x120 [bttv]
> [    7.937702]  bttv_s_ctrl+0x2d5/0x3b0 [bttv]
> [    7.937702]  __v4l2_ctrl_handler_setup+0xdf/0x130 [videodev]
> [    7.937703]  v4l2_ctrl_handler_setup+0x27/0x40 [videodev]
> [    7.937703]  bttv_probe.cold.45+0x8f4/0xca7 [bttv]
> [    7.937703]  local_pci_probe+0x41/0x90
> [    7.937704]  pci_device_probe+0x118/0x1a0
> [    7.937704]  driver_probe_device+0x2da/0x450
> [    7.937704]  __driver_attach+0xe1/0x110
> [    7.937704]  ? driver_probe_device+0x450/0x450
> [    7.937705]  ? driver_probe_device+0x450/0x450
> [    7.937705]  bus_for_each_dev+0x79/0xc0
> [    7.937705]  ? deferred_probe_initcall+0x30/0x30
> [    7.937705]  bus_add_driver+0x155/0x230
> [    7.937706]  ? 0xffffffffc07a4000
> [    7.937706]  driver_register+0x6b/0xb0
> [    7.937706]  ? 0xffffffffc07a4000
> [    7.937706]  bttv_init_module+0xcd/0xe3 [bttv]
> [    7.937706]  do_one_initcall+0x5d/0x362
> [    7.937707]  ? rcu_read_lock_sched_held+0x6b/0x80
> [    7.937707]  ? kmem_cache_alloc_trace+0x293/0x2f0
> [    7.937707]  ? do_init_module+0x22/0x210
> [    7.937707]  do_init_module+0x5a/0x210
> [    7.937708]  load_module+0x21e6/0x2610
> [    7.937708]  ? ima_post_read_file+0x10c/0x119
> [    7.937708]  ? __do_sys_finit_module+0xad/0x110
> [    7.937708]  __do_sys_finit_module+0xad/0x110
> [    7.937709]  do_syscall_64+0x60/0x1f0
> [    7.937709]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Follow by a printing of the actual lockdep issue.
>
> This is what I wrote this patch for in the first place
> and checking for oops_in_progress does not fix this case.
>
> So I believe we need to keep using the:
>
>        if (in_atomic() || irqs_disabled()) {
>
> Check, Bartlomiej can you apply v2 please, or let me know if
> you want any other changes?
>
>> At least that's what we've switched to in drm_fb_helper.c
>> instead of a cargo-culted pile of in_atimc/irq/kgdb checks. And since
>> the box will die right afterwards, you might as well just bail out
>> directly and not bother with scheduling the worker?
>
>
> Well with a lockdep bug the box won't die, depending on the actual
> locking issue it may be quite harmless.
>
> Regards,
>
> Hans
>
>
>
>
>> Again, that's what
>> we've been doing in the drm fbdev emulation code.
>> -Daniel
>>
>>> +       if (in_atomic() || irqs_disabled()) {
>>> +               schedule_work(&fbcon_deferred_takeover_work);
>>> +       } else {
>>> +               for_each_registered_fb(i)
>>> +                       fbcon_fb_registered(registered_fb[i]);
>>> +       }
>>>
>>>          return NOTIFY_OK;
>>>   }
>>> --
>>> 2.18.0
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
>>
>>
>



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
