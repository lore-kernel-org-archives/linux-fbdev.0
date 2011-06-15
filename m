From: Francis Moreau <francis.moro@gmail.com>
Date: Wed, 15 Jun 2011 07:12:46 +0000
Subject: Re: Possible deadlock when suspending framebuffer
Message-Id: <BANLkTinE+EZ9nr1qGKC0VY0bVHuF8U-R0w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308100165.2113.4.camel@Tux>
	<20110615075803.3348b4ec@pluto.restena.lu>
In-Reply-To: <20110615075803.3348b4ec@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Wanlong Gao <wanlong.gao@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jun 15, 2011 at 7:58 AM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> Hi,
>
> On Wed, 15 Jun 2011 09:09:24 Wanlong Gao <wanlong.gao@gmail.com> wrote:
>> <snip>
>> Hi Francis:
>> can you test this patch?
>
> Do you have a deadlock trace which you are trying to fix?
>
> It's either the caller of unregister_framebuffer() which must be
> changed to not call unregister_framebuffer with info's lock held or
> the code reacting on the notification that must not try to acquire the
> lock again.
>
> The interesting par is if console semaphore has some relation to this
> deadlock as the order for taking both varies... It could be
> lock_fb_info(); console_lock() =A0versus console_lock(); lock_fb_info()
>
> Bruno
>
>
>> Thanks
>>
>> From fe026c42af4cbdce053460a428a445e99071586a Mon Sep 17 00:00:00 2001
>> From: Wanlong Gao <wanlong.gao@gmail.com>
>> Date: Wed, 15 Jun 2011 09:03:41 +0800
>> Subject: [PATCH] test
>>
>>
>>
>> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
>> ---
>> =A0drivers/video/fbmem.c | =A0 =A03 ---
>> =A01 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
>> index 5aac00e..6e6cef3 100644
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -1642,11 +1642,8 @@ static int do_unregister_framebuffer(struct
>> fb_info *fb_info)
>> =A0 =A0 =A0 if (i < 0 || i >=3D FB_MAX || registered_fb[i] !=3D fb_info)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 if (!lock_fb_info(fb_info))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 event.info =3D fb_info;
>> =A0 =A0 =A0 ret =3D fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
>> - =A0 =A0 unlock_fb_info(fb_info);
>
> Not a good idea to stop taking fb_lock here.
> Pretty all calls of fb_notifier_call_chain are protected by info's
> lock, except the one for FB_EVENT_FB_UNREGISTERED a few lines further.
>
> IMHO it wou make sense to add the lock around that last one so all
> notifier chain calls are handled the same.
>
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
>

Well, sorry for the dumb question but the fb/fbcon code is pretty hard
to follow for me.

Why does store_fbstate() and any fb driver's suspsend methods acquire
the console lock at all ?

Thanks
--=20
Francis
