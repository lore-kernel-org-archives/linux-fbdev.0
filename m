From: Timur Tabi <timur@freescale.com>
Date: Wed, 14 Sep 2011 21:47:09 +0000
Subject: Re: [REPOST][PATCH 1/2] fbdev: fix indentation in modedb.c
Message-Id: <4E7120DD.7040600@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315929909-26311-1-git-send-email-timur@freescale.com>
In-Reply-To: <1315929909-26311-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:
> Applied this patch, although I do not like this sort of patches very much. Well,
> I guess it's an improvement, are you doing some real work on this code?

Ugh, please ignore my previous reply.  For some reason, I thought you were
talking about my second patch.

To answer your question properly: no, I'm not doing any real work on this code.
 I noticed the bad indentation, and I decided that maybe it was worth fixing.
Yes, it might cause some pain with diffs, but these functions have been around a
long time and haven't been touched in while.  Also, a similar patch to mine was
applied recently: "video: tidy up modedb formatting."

-- 
Timur Tabi
Linux kernel developer at Freescale

