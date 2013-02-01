From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 01 Feb 2013 08:21:43 +0000
Subject: Re: Revert "console: implement lockdep support for console_lock"
Message-Id: <CA+icZUW5tBotrZT9QtNPao-3rEccohBW8a4diS2nJ+ONgTWLaQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>

Hi Dave,

people having the fbcon-locking-fixes [1] in their local GIT tree can
revert this change?

commit ff0d05bf73620eb7dc8aee7423e992ef87870bdf
Refs: v3.8-rc5-194-gff0d05b
Author:     Dave Airlie <airlied@gmail.com>
AuthorDate: Thu Jan 31 14:27:03 2013 +1100
Commit:     Dave Airlie <airlied@gmail.com>
CommitDate: Thu Jan 31 15:46:56 2013 +1100

    Revert "console: implement lockdep support for console_lock"

    This reverts commit daee779718a319ff9f83e1ba3339334ac650bb22.

    I'll requeue this after the console locking fixes, so lockdep
    is useful again for people until fbcon is fixed.

    Signed-off-by: Dave Airlie <airlied@redhat.com>

Thanks!

Regards,
- Sedat

[1] http://cgit.freedesktop.org/~airlied/linux/log/?h=FBcon-locking-fixes
