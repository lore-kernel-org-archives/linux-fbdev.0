From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] save_flags/cli in drivers/video/pm3fb.c
Date: Mon, 25 Nov 2002 18:53:33 +0100
Sender: kernel-janitor-discuss-admin@lists.sourceforge.net
Message-ID: <20021125175333.GA5091@iliana>
References: <Pine.LNX.4.44.0211232001050.15858-200000@top.qwarx.com> <3DE1F4EB.2050207@irisa.fr>
Mime-Version: 1.0
Return-path: <kernel-janitor-discuss-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DE1F4EB.2050207@irisa.fr>
Errors-To: kernel-janitor-discuss-admin@lists.sourceforge.net
List-Help: <mailto:kernel-janitor-discuss-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:kernel-janitor-discuss@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kernel-janitor-discuss>,
	<mailto:kernel-janitor-discuss-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kernel-janitor-discuss>,
	<mailto:kernel-janitor-discuss-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=kernel-janitor-discuss>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Romain Dolbeau <dolbeau@irisa.fr>
Cc: Chris Wilson <chris@qwirx.com>, Linux Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>, Trivial Patch Monkey <trivial@rustcorp.com.au>, linux-fbdev-devel@lists.sourceforge.net

On Mon, Nov 25, 2002 at 11:01:15AM +0100, Romain Dolbeau wrote:
> Chris Wilson wrote:
> 
> >Since I can't compile this driver on my architecture, I'm afraid I haven't 
> >been able to test this patch at all.
> 
> This patch is relevant for 2.5.x only, and pm3fb can't compile
> and work on 2.5.x. The FB API was changed, and FB drivers
> need to be rewritten. As I never found a 2.5.x release that
> would compile on my box (no x86 here), I didn't port pm3fb.
> 
> BTW, pm3fb should not be integrated in 2.5.x, it was submitted
> only to 2.4.x and somehow found its way in 2.5.x. I don't
> maintain pm3fb on 2.5.x, never has, and likely never will.
> 
> The proper fix for pm3fb in 2.5 is to delete it, at least
> until someone else rewrite it or until 2.5.x can actually
> compile and work on PowerPC and I can rewrite it myself.

I have plans for doing a full rewrite of pm3fb for 2.5, just not really
the times right now. I will do it before 2.6 (or 3.0 or whatever) is
released though. I have already done some work, just not filled in the
mode changes and other such. That said, it may be on the limit of my
NDA, which was supposed to be for XFree86 only (altough i guess the
current XFree86 code counts as available from other source though.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
