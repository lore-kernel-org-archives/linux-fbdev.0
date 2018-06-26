From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 18:29:44 +0000
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
Message-Id: <ad0becb1-eece-b89c-c77f-273403052491@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626135535.2990-1-hdegoede@redhat.com>
 <20180626135535.2990-4-hdegoede@redhat.com>
 <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
In-Reply-To: <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, dri-devel@lists.freedesktop.org

Hi,

On 26-06-18 19:12, Andy Shevchenko wrote:
> On Tue, Jun 26, 2018 at 4:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:
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
> 
>> +       for (i = 0; i < FB_MAX; i++) {
>> +               if (registered_fb[i])
>> +                       fbcon_fb_registered(registered_fb[i]);
>> +       }
> 
> Simple git grep shows that we perhaps do
> 
> #define for_each_registered_fbcon(i) ...
> 
> (As an example see for_each_pci_bridge() how it's done there)

This is probably a worthwhile cleanup for all the fbdev related
code / drivers. But outside of the scope of this patchset.

Regards,

Hans
