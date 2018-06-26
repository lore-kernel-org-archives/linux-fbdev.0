From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Jun 2018 17:13:45 +0000
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
Message-Id: <CAHp75VeTvdh8Cd9crQzX_sjM1h2Zb1oQQ3VodJgEDhaF1YT2-w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626135535.2990-1-hdegoede@redhat.com>
 <20180626135535.2990-4-hdegoede@redhat.com>
 <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
In-Reply-To: <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, dri-devel@lists.freedesktop.org

On Tue, Jun 26, 2018 at 8:12 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 26, 2018 at 4:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:

>> +       for (i = 0; i < FB_MAX; i++) {
>> +               if (registered_fb[i])
>> +                       fbcon_fb_registered(registered_fb[i]);
>> +       }
>
> Simple git grep shows that we perhaps do
>
> #define for_each_registered_fbcon(i) ...

(Or just ..._fb() since it looks like iteration over framebuffers, not
exactly consoles)

>
> (As an example see for_each_pci_bridge() how it's done there)



-- 
With Best Regards,
Andy Shevchenko
