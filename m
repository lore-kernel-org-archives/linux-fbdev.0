From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 21 Aug 2012 12:14:43 +0000
Subject: Re: [PATCH] fbcon: fix race condition between console lock and cursor timer
Message-Id: <1345551283.23018.106.camel@twins>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345531207-24926-1-git-send-email-airlied@redhat.com>
In-Reply-To: <1345531207-24926-1-git-send-email-airlied@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Linus <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Randy Dunlap <rdunlap@xenotime.net>, Josh Boyer <jwboyer@gmail.com>

On Tue, 2012-08-21 at 16:40 +1000, Dave Airlie wrote:
> So after much tracing with direct netconsole writes (printks
> under console_lock not so useful) 

I always use earlyprintk on serial.. 
