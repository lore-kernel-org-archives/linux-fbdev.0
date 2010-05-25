From: Albert Herranz <albert_herranz@yahoo.es>
Date: Tue, 25 May 2010 22:13:49 +0000
Subject: Re: [Bulk] Re: page_mkwrite vs pte dirty race in fb_defio
Message-Id: <4BFC4B9D.1080902@yahoo.es>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100525160149.GE20853@laptop> <4BFC1657.5000707@yahoo.es> <20100525184700.GJ20853@laptop>
In-Reply-To: <20100525184700.GJ20853@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@suse.de>
Cc: aya Kumar <jayakumar.lkml@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 05/25/2010 08:47 PM, Nick Piggin wrote:
>>> I hope that should provide a more elegant solution to your problem. I
>>> would really like you to take a look at that, because we already have
>>> filesystem code (NFS) relying on it, and more code we have relying on
>>> this synchronization, the more chance we would find a subtle problem
>>> with it (also it should be just nicer).
>>
>> So if I undestand it correctly, using the "new" calling convention I should just lock the page on fb_deferred_io_mkwrite() and return VM_FAULT_LOCKED to fix the described race for fb_defio.
> 
> As far as I can see from quick reading of the fb_defio code, yes
> that should solve it (provided you lock the page inside the mutex,
> of course).
> 

Ok, thanks. I'm posting a new version as RFT.

Cheers,
Albert

