From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 05 Feb 2013 10:47:25 +0000
Subject: Re: Revert "console: implement lockdep support for console_lock"
Message-Id: <CA+icZUU4JMfws_jFpoCaXnSNJeigONSEik_oGSa_ZQ=uJ_GJOA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUW5tBotrZT9QtNPao-3rEccohBW8a4diS2nJ+ONgTWLaQ@mail.gmail.com>
	<CAKMK7uEFCm5JPD9bg4uO9K_q-w0=9GWzRLoB9H-_=ZR7NxA9=A@mail.gmail.com>
In-Reply-To: <CAKMK7uEFCm5JPD9bg4uO9K_q-w0=9GWzRLoB9H-_=ZR7NxA9=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Fri, Feb 1, 2013 at 9:42 AM, Daniel Vetter <daniel.vetter@ffwll.ch> wrot=
e:
> On Fri, Feb 1, 2013 at 9:21 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> people having the fbcon-locking-fixes [1] in their local GIT tree can
>> revert this change?
>
> Yeah, if you have all the fixes reverting this is fine and appreciated
> to increase testing. Dave will probably push the revert himself to
> drm-next soon.

When will that happen: drm-next inclusion?

Just FYI:
Pulling fbcon-locking-fixes into Linux-Next (next-20130205) shows some
ugly UTF-8 mismatch, means "fb: rework locking to fix lock ordering on
takeover" is not the same patch as in -next.
Just wanna let you know.

It would be good to inform Andrew and Stephen when this happened, so
Andrew can drop the two fb-fixes from his mmotm-tree.

Thanks!

- Sedat -

> -Daniel
>
>>
>> commit ff0d05bf73620eb7dc8aee7423e992ef87870bdf
>> Refs: v3.8-rc5-194-gff0d05b
>> Author:     Dave Airlie <airlied@gmail.com>
>> AuthorDate: Thu Jan 31 14:27:03 2013 +1100
>> Commit:     Dave Airlie <airlied@gmail.com>
>> CommitDate: Thu Jan 31 15:46:56 2013 +1100
>>
>>     Revert "console: implement lockdep support for console_lock"
>>
>>     This reverts commit daee779718a319ff9f83e1ba3339334ac650bb22.
>>
>>     I'll requeue this after the console locking fixes, so lockdep
>>     is useful again for people until fbcon is fixed.
>>
>>     Signed-off-by: Dave Airlie <airlied@redhat.com>
>>
>> Thanks!
>>
>> Regards,
>> - Sedat
>>
>> [1] http://cgit.freedesktop.org/~airlied/linux/log/?h=FBcon-locking-fixes
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
