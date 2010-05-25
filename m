From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Tue, 25 May 2010 23:40:13 +0000
Subject: Re: [RFT PATCH 2/2] fb_defio: redo fix for non-dirty ptes
Message-Id: <AANLkTikQ2cf_9P1DIVw5CV6NKHVhp10WyFBJW6J1yZY5@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274825820-10246-1-git-send-email-albert_herranz@yahoo.es>
	 <1274825820-10246-2-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1274825820-10246-2-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: npiggin@suse.de, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, May 26, 2010 at 6:17 AM, Albert Herranz <albert_herranz@yahoo.es> wrote:
> As pointed by Nick Piggin, ->page_mkwrite provides a way to keep a page
> locked until the associated PTE is marked dirty.
>
> Re-implement the fix by using this mechanism.
>
> LKML-Reference: <20100525160149.GE20853@laptop>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Looks good to me. Thanks.

Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>
