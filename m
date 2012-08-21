From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 21 Aug 2012 09:15:05 +0000
Subject: Re: [PATCH] fbcon: fix race condition between console lock and cursor timer
Message-Id: <20120821101505.61c0221a@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345531207-24926-1-git-send-email-airlied@redhat.com>
In-Reply-To: <1345531207-24926-1-git-send-email-airlied@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Linus <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Josh Boyer <jwboyer@gmail.com>

> So after much tracing with direct netconsole writes (printks
> under console_lock not so useful), I think I found the race.

Direct netconsole write would be a useful patch to have mainline I think
8)

> Hopefully this fixes the problem for anyone seeing vesafb->kms
> driver handoff.

Not really the proper fix but its clear and is probably the best thing to
go in initially with a cc: stable. Can you at least stick a large 

+ /* FIXME: we should sort out the unbind locking instead */

on the patch however.
