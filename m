From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Tue, 28 Feb 2017 19:13:32 +0000
Subject: Re: [PATCH 1/5] staging: lustre: Remove unnecessary else after return
Message-Id: <CALrZqyP-BRPj4jEFgU=B_AV7E4-tJfgaXwwxRhUprLg_4gWQkg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488219268-3006-1-git-send-email-singhalsimran0@gmail.com>
 <1488223529.25838.8.camel@perches.com> <CALrZqyMTTk4o5Y5e3DzH_cqXxvHsHDtByG0oYwWMjekZSR7Kkw@mail.gmail.com>
 <1488228200.25838.14.camel@perches.com>
In-Reply-To: <1488228200.25838.14.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, outreachy-kernel@googlegroups.com

On Tue, Feb 28, 2017 at 2:13 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2017-02-28 at 01:51 +0530, SIMRAN SINGHAL wrote:
>> On Tue, Feb 28, 2017 at 12:55 AM, Joe Perches <joe@perches.com> wrote:
>> > On Mon, 2017-02-27 at 23:44 +0530, simran singhal wrote:
>> > > This patch fixes the checkpatch warning that else is not generally
>> > > useful after a break or return.
>> >
>> > checkpatch doesn't actually warn for this style
>> >
>> >         if (foo)
>> >                 return bar;
>> >         else
>> >                 return baz;
>> >
>>
>> ok, My bad
>> so, I have to change commit message as checkpatch doesn't warn for this style.
>
> Perhaps better would be to leave them unchanged instead.
>
>> > > diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
> []
>> > > @@ -1806,8 +1806,7 @@ ksocknal_close_matching_conns(struct lnet_process_id id, __u32 ipaddr)
>> > >
>> > >       if (!count)
>> > >               return -ENOENT;
>> > > -     else
>> > > -             return 0;
>> > > +     return 0;
>
> There might be a case for this one.
> error returns are generally in the form
>
> {
>         [...]
>
>         err = func(...);
>         if (err < 0)
>                 return err;
>
>         return 0;
> }
Not sure, what's the problem in removing else as according to me
there is no use of else.

In this case if (if condition) does not satisfy then else condition will
be satisfied and function will return 0.
