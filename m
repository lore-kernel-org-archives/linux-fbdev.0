From: Romain Dolbeau <dolbeau@irisa.fr>
Subject: Re: [PATCH] save_flags/cli in drivers/video/pm3fb.c
Date: Mon, 25 Nov 2002 11:01:15 +0100
Sender: kernel-janitor-discuss-admin@lists.sourceforge.net
Message-ID: <3DE1F4EB.2050207@irisa.fr>
References: <Pine.LNX.4.44.0211232001050.15858-200000@top.qwarx.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitor-discuss-admin@lists.sourceforge.net>
Errors-To: kernel-janitor-discuss-admin@lists.sourceforge.net
List-Help: <mailto:kernel-janitor-discuss-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:kernel-janitor-discuss@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kernel-janitor-discuss>,
	<mailto:kernel-janitor-discuss-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kernel-janitor-discuss>,
	<mailto:kernel-janitor-discuss-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=kernel-janitor-discuss>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Chris Wilson <chris@qwirx.com>
Cc: Linux Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>, Trivial Patch Monkey <trivial@rustcorp.com.au>, linux-fbdev-devel@lists.sourceforge.net

Chris Wilson wrote:

> Since I can't compile this driver on my architecture, I'm afraid I haven't 
> been able to test this patch at all.

This patch is relevant for 2.5.x only, and pm3fb can't compile
and work on 2.5.x. The FB API was changed, and FB drivers
need to be rewritten. As I never found a 2.5.x release that
would compile on my box (no x86 here), I didn't port pm3fb.

BTW, pm3fb should not be integrated in 2.5.x, it was submitted
only to 2.4.x and somehow found its way in 2.5.x. I don't
maintain pm3fb on 2.5.x, never has, and likely never will.

The proper fix for pm3fb in 2.5 is to delete it, at least
until someone else rewrite it or until 2.5.x can actually
compile and work on PowerPC and I can rewrite it myself.

-- 
romain



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
