From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 21 Aug 2012 12:15:45 +0000
Subject: Re: [PATCH] fbcon: fix race condition between console lock and cursor timer
Message-Id: <1345551345.23018.107.camel@twins>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345531207-24926-1-git-send-email-airlied@redhat.com>
	 <20120821101505.61c0221a@pyramind.ukuu.org.uk>
In-Reply-To: <20120821101505.61c0221a@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Linus <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Josh Boyer <jwboyer@gmail.com>

On Tue, 2012-08-21 at 10:15 +0100, Alan Cox wrote:
> > So after much tracing with direct netconsole writes (printks
> > under console_lock not so useful), I think I found the race.
> 
> Direct netconsole write would be a useful patch to have mainline I think
> 8) 

could we make that use the earlyprintk infrastructure?
