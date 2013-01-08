From: "devendra.aaru" <devendra.aaru@gmail.com>
Date: Tue, 08 Jan 2013 04:28:57 +0000
Subject: Re: [PATCH] backlight: check null deference of name when device is registered
Message-Id: <CAHdPZaMDcVsWX8S5Te3nYtWYNqzK4G4+7D9HkE=JFjZ3bHq7KQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000b01cdea55$92725aa0$b7570fe0$%han@samsung.com>
	<20130107160137.dec5098a.akpm@linux-foundation.org>
	<003c01cded3f$0f25a3e0$2d70eba0$%han@samsung.com>
	<20130107173557.dadc0a7a.akpm@linux-foundation.org>
In-Reply-To: <20130107173557.dadc0a7a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jingoo Han <jg1.han@samsung.com>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Mon, Jan 7, 2013 at 8:35 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 08 Jan 2013 10:25:35 +0900 Jingoo Han <jg1.han@samsung.com> wrote:
>
>> On Tuesday, January 08, 2013 9:02 AM, Andrew Morton wrote
>> > On Fri, 04 Jan 2013 17:29:11 +0900
>> > Jingoo Han <jg1.han@samsung.com> wrote:
>> >
>> > > NULL deference of name is checked when device is registered.
>> > > If the name is null, it will cause a kernel oops in dev_set_name().
>> > >
>> > > ...
>> > >
>> > > --- a/drivers/video/backlight/backlight.c
>> > > +++ b/drivers/video/backlight/backlight.c
>> > > @@ -292,6 +292,11 @@ struct backlight_device *backlight_device_register(const char *name,
>> > >   struct backlight_device *new_bd;
>> > >   int rc;
>> > >
>> > > + if (name = NULL) {
>> > > +         pr_err("backlight name is null\n");
>> > > +         return ERR_PTR(-EINVAL);
>> > > + }
>> > > +
>> > >   pr_debug("backlight_device_register: name=%s\n", name);
>> >
>> > I don't understand this.
>> >
>> > Is there some driver which is calling these functions with name=NULL?
>> > If so, which one(s)?
>>
>> No, there is no one.
>>
>> >
>> > If "no" then why don't we declare that "passing name=NULL is a bug" and
>> > leave the code as-is?
>>
>> Do you mean following?
>>
>> +     if (name = NULL)
>> +             pr_err("passing name=NULL is a bug");
>> +
>>       pr_debug("backlight_device_register: name=%s\n", name);
>
> Nope; I'm suggesting we leave the code alone.  If someone passes in
> NULL they will get a nice oops and their bug will then get fixed.
>

We still fail the probe in the patch Jingoo Han sent,
anyways if i catch your point correctly is this the lines you wanted?

+ /**
+  * BUG if the name of the backlight device
+  * is a NULL
+  */
+ BUG_ON(!name);
