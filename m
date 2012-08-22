From: Dave Airlie <airlied@gmail.com>
Date: Wed, 22 Aug 2012 04:00:05 +0000
Subject: Re: [PATCH] fbcon: fix race condition between console lock and cursor timer
Message-Id: <CAPM=9tzv=YKEfvmN+18huXGd7ZO-AGvcAsrD8m7NQh5twEfbhw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345531207-24926-1-git-send-email-airlied@redhat.com>
	<20120821101505.61c0221a@pyramind.ukuu.org.uk>
In-Reply-To: <20120821101505.61c0221a@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, dri-devel@lists.sf.net, Dave Airlie <airlied@redhat.com>, Josh Boyer <jwboyer@gmail.com>, Linus <torvalds@linux-foundation.org>

On Tue, Aug 21, 2012 at 7:15 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> So after much tracing with direct netconsole writes (printks
>> under console_lock not so useful), I think I found the race.
>
> Direct netconsole write would be a useful patch to have mainline I think
> 8)

Well I used a one line wrapper around the netconsole write_msg, which
just passed
NULL as the first arg, then sprinkled netconsole_write_msg around the
place, not having
printf stuff could be an annoyance for some people, for this it didn't matter.

Peter I wish I had a serial port to work with :-)

>
> Not really the proper fix but its clear and is probably the best thing to
> go in initially with a cc: stable. Can you at least stick a large
>
> + /* FIXME: we should sort out the unbind locking instead */

Done, and cc stable, I'll send this to Linus via my tree as its fairly
urgent from my pov.

Dave.
