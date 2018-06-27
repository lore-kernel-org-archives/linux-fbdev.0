From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Jun 2018 14:15:45 +0000
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console takeover
Message-Id: <CAKMK7uFZ4MmUMbPn_V84brvVnv0sqdW30FGaYmqn2CSAyTYwiw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626183612.321-1-hdegoede@redhat.com>
 <CGME20180627091530epcas1p4bcb4d5421da77cd2e262e839dd50e5dc@epcas1p4.samsung.com>
 <20180627091520.GI13978@phenom.ffwll.local> <66532157.tkLS2buF0U@amdc3058>
 <84977ce7-bfee-523a-852f-defc0243b520@redhat.com>
In-Reply-To: <84977ce7-bfee-523a-852f-defc0243b520@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>

On Wed, Jun 27, 2018 at 1:13 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 27-06-18 11:47, Bartlomiej Zolnierkiewicz wrote:
>>
>> On Wednesday, June 27, 2018 11:15:20 AM Daniel Vetter wrote:
>>>
>>> On Tue, Jun 26, 2018 at 08:36:09PM +0200, Hans de Goede wrote:
>>>>
>>>> Hi All,
>>>>
>>>> Here is v4 of my patch-set, to delay fbcon taking over the console (and
>>>> binding to fbdev devices) until there actually is some text output to
>>>> the
>>>> console. This is intended for use with the "quiet" cmdline option, in
>>>> combination with a bootloader which leaves the vendor's logo /
>>>> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
>>>>
>>>> The end goal here is a boot where the firmware shows its boot graphics
>>>> and these stay in place for a couple of seconds until the GUI loads and
>>>> the GUI then smoothly takes over the framebuffer without any
>>>> distruptions.
>>>>
>>>> This patch-set spans 2 subsystems.
>>>>
>>>> Petr, the printk subsys change is really trivial (1 line addition) can
>>>> we
>>>> get your Acked-by for merging all 3 patches through the fbdev tree?
>>>>
>>>> Changelog:
>>>>
>>>> Changes in v4:
>>>> -Keep the comments about which fbcon functions need locks in place
>>>>
>>>> Changes in v3:
>>>> -Export is_console_locke() for use in modules (as fbcon may be built as
>>>> a .ko)
>>>> -Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to
>>>> assert
>>>>   proper locking (requested by Daniel)
>>>> -Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by
>>>> Daniel)
>>>> -Document the fbcon=nodefer commandline option (req. by Emil)
>>>>
>>>> Changes in v2:
>>>> -Check the whole string when checking for erases in putcs, instead of
>>>> just
>>>>   the first char
>>>> -Make dummycon_blank return 1, so that a redraw gets triggered and any
>>>> text
>>>>   rendered while blanked gets output so that it can trigger a deferred
>>>>   takeover if one is pending
>>>
>>>
>>> Wrt merging I think it'd be best if we stuff this into drm-misc-next -
>>> that will increase testing by gpu drivers a lot, instead of a suprise
>>> when
>>> the fbdev pull lands in upstream.
>>>
>>> Bart, is that ok with you?
>>
>>
>> Not really, since there are efifb changes in the queue which depend
>> on this series I would really prefer to merge all patches through
>> fbdev tree.
>>
>> Also fbdev tree is pulled into -next kernels so testing coverage
>> should be okay (I assume that everybody are testing -next kernels in
>> addition to their own branches :-)..

Ime this is a rather unrealistic assumption ...

> If you are talking about the "efifb: Copy the ACPI BGRT boot graphics to the
> framebuffer" series, I could push those to drm-misc-next too (once acked).
>
> I think most GPU driver developers are running drm-tip and not
> -next, so putting things in drm-misc-next would give the changes somewhat
> more test-exposure on a wider range of GPUs I believe. Where as -next
> testing will likely be more server use-case oriented.
>
> Alternatively you could merge things in the fbdev tree, do an
> unmutable branch and then that could be merged into drm-misc-next by
> the drm-misc-next maintainers.
>
> Note either way is fine with me. This is up to you and Daniel.

Yeah pull request for a topic branch works too.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
