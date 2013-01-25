From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 Jan 2013 00:50:55 +0000
Subject: Re: [git pull] fbcon locking fixes.
Message-Id: <20130124165055.0bceb033.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.00.1301250041001.25545@skynet.skynet.ie>
In-Reply-To: <alpine.DEB.2.00.1301250041001.25545@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@linux-foundation.org, DRI mailing list <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Maarten Lankhorst <m.b.lankhorst@gmail.com>

On Fri, 25 Jan 2013 00:42:37 +0000 (GMT)
Dave Airlie <airlied@linux.ie> wrote:

> These patches have been sailing around long enough, waiting for a maintainer
> to reappear, so I've decided enough is enough, lockdep is kinda useful to have.
> 
> Thanks to Daniel for annoying me enough :-)

Me too, but the patches broke Maarten's EFI driver setup:
https://lkml.org/lkml/2013/1/15/203.
