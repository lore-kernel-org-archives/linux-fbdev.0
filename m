From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 11 Jul 2018 19:41:47 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <ec818015-9fc9-f389-dd06-952953f84068@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
 <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
 <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
 <20180711151911.2ea40200@gandalf.local.home>
In-Reply-To: <20180711151911.2ea40200@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: Petr Mladek <pmladek@suse.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>

Hi,

On 11-07-18 21:19, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 19:56:02 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
>>> Have you seen Steven's suggestion which he send about the same time
>>> as your mail I'm replying to here ? I personally think that doing
>>> something like that makes sense (for as long as we have the need
>>> for the lockless_fb_register debug hack).
>>>
>>> Note I've 2 patches ready to go to only fix this in fbcon.c, but I
>>> think a more thorough fix makes sense.
>>
>> Yeah Steven's suggestion looks reasonable to fix this all for good.
>> The #if 1 predates git history, so no idea why it was added or by whom
>> :-)
> 
> I just sent the patch. If the printk maintainers take it, then you can
> update the fb driver to set the ignore_console_lock_warning when
> lockless_fb_register is set.

Thanks for doing this. I will wait with sending a fbcon / fbdev patch
till the fate of your patch is clear then.

Regards,

Hans
