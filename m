From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Jun 2018 18:49:33 +0000
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
Message-Id: <CAHp75Vf2x00AdgWj_zuKGkkBGV8HiZHrfHeMx+AAx0ToaxMF4A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626135535.2990-1-hdegoede@redhat.com>
 <20180626135535.2990-4-hdegoede@redhat.com>
 <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
 <ad0becb1-eece-b89c-c77f-273403052491@redhat.com>
In-Reply-To: <ad0becb1-eece-b89c-c77f-273403052491@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <xieyisheng1@huawei.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, dri-devel@lists.freedesktop.org

On Tue, Jun 26, 2018 at 9:29 PM, Hans de Goede <hdegoede@redhat.com> wrote:

>>> +       for (i = 0; i < FB_MAX; i++) {
>>> +               if (registered_fb[i])
>>> +                       fbcon_fb_registered(registered_fb[i]);
>>> +       }

>> Simple git grep shows that we perhaps do
>>
>> #define for_each_registered_fbcon(i) ...
>>
>> (As an example see for_each_pci_bridge() how it's done there)
>
>
> This is probably a worthwhile cleanup for all the fbdev related
> code / drivers. But outside of the scope of this patchset.

True.

Yisheng, in case you are interested in doing such clean up...

-- 
With Best Regards,
Andy Shevchenko
