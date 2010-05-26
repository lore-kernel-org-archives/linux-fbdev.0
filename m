From: Nick Piggin <npiggin@suse.de>
Date: Wed, 26 May 2010 00:18:55 +0000
Subject: Re: [RFT PATCH 2/2] fb_defio: redo fix for non-dirty ptes
Message-Id: <20100526001854.GL20853@laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274825820-10246-1-git-send-email-albert_herranz@yahoo.es>
 <1274825820-10246-2-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1274825820-10246-2-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: jayakumar.lkml@gmail.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, May 26, 2010 at 12:17:00AM +0200, Albert Herranz wrote:
> As pointed by Nick Piggin, ->page_mkwrite provides a way to keep a page
> locked until the associated PTE is marked dirty.
> 
> Re-implement the fix by using this mechanism.
> 
> LKML-Reference: <20100525160149.GE20853@laptop>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Thanks for taking a look at this,

Acked-by: Nick Piggin <npiggin@suse.de>

