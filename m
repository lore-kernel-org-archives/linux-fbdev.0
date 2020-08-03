From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 03 Aug 2020 11:07:18 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <86fc45ac-5bb1-50a2-5f4c-5c2da30f7c3b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
 <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
 <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
 <20200803081823.GD493272@kroah.com>
 <CAKMK7uEV+CV89-L1Y=dijOEy8DKE=juRfQDnNnbhbAJhFh1fYw@mail.gmail.com>
 <CGME20200803094820eucas1p1696af31a3c9a295b7c4a4f478a5bde8d@eucas1p1.samsung.com>
 <20200803094753.GC635660@kroah.com>
In-Reply-To: <20200803094753.GC635660@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg KH <greg@kroah.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Kyungtae Kim <kt0755@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, DRI devel <dri-devel@lists.freedesktop.org>, =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>, Solar Designer <solar@openwall.com>, Anthony Liguori <aliguori@amazon.com>, Yang Yingliang <yangyingliang@huawei.com>, xiao.zhang@windriver.com, Jiri Slaby <jirislaby@kernel.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>


On 8/3/20 11:47 AM, Greg KH wrote:
> On Mon, Aug 03, 2020 at 10:45:07AM +0200, Daniel Vetter wrote:
>> On Mon, Aug 3, 2020 at 10:26 AM Greg KH <greg@kroah.com> wrote:
>>>
>>> On Mon, Aug 03, 2020 at 10:08:43AM +0200, Jiri Slaby wrote:
>>>> Hi,
>>>>
>>>> On 31. 07. 20, 7:22, 张云海 wrote:
>>>>> Remove whitespace at EOL
>>>>
>>>> I am fine with the patch. However it should be sent properly (inline
>>>> mail, having a PATCH subject etc. -- see
>>>> Documentation/process/submitting-patches.rst). git send-email after git
>>>> format-patch handles most of it.
>>>>
>>>> There is also question who is willing to take it?
>>>>
>>>> Bart? Greg? Should we route it via akpm, or will you Linus directly? (I
>>>> can sign off and resend the patch which was attached to the mail I am
>>>> replying to too, if need be.)
>>>
>>> I can take it, if Bart can't, just let me know.
>>
>> Yeah vt stuff and console drivers != fbcon go through Greg's tree past
>> few years ...
>>
>> Greg, should we maybe add a MAINTAINERS entry that matches on all
>> things console? With tty/vt you definitely have the other side of that
>> coin already :-)
> 
> Sure, that would be good as things do fall through the cracks at times.

Since taking over fbdev in 2017 I've tried to act as the last resort
Maintainer for console stuff (AFAIK there are no "lost" patches) but
it really deserves its own entry.

Also most console patches make it through you nowadays anyway:

$ git log --pretty=fuller --since 17 drivers/video/console/|grep "Commit\:"|sort|uniq -cd
      2 Commit:     Arnd Bergmann <arnd@arndb.de>
     11 Commit:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
      2 Commit:     Daniel Vetter <daniel.vetter@ffwll.ch>
      3 Commit:     Dave Airlie <airlied@redhat.com>
     12 Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
      7 Commit:     Linus Torvalds <torvalds@linux-foundation.org>
      2 Commit:     Martin Schwidefsky <schwidefsky@de.ibm.com>

> If you write the patch, I'll merge it :)
ACK from me. :)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
