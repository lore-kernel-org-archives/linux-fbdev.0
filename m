From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 13:42:42 +0000
Subject: Re: [PATCH v2] console/fbcon: Add support for deferred console takeover
Message-Id: <3ac0d198-7d51-ddf4-0344-d103965a78ae@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626104103.12208-1-hdegoede@redhat.com>
 <CACvgo52oB4xZ3XeNsDcLcjrEr7Xzk=CMGymGtxPs-1GJ_W1b2w@mail.gmail.com>
In-Reply-To: <CACvgo52oB4xZ3XeNsDcLcjrEr7Xzk=CMGymGtxPs-1GJ_W1b2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,

On 26-06-18 15:11, Emil Velikov wrote:
> Hi Hans,
> 
> On 26 June 2018 at 11:41, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>> +               if (!strcmp(options, "nodefer")) {
>> +                       deferred_takeover = false;
>> +                       continue;
>> +               }
>> +#endif
> Can we please have some documentation about "nodefer".
> I may have missed something, but it seems like the only instance of it
> is in this hunk.
> 
> If you prefer, the documentation can be a separate commit.

Good point, fixed for v3 (and kept in the same commit).

Regards,

Hans
