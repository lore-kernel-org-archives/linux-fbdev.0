From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] save_flags/cli in drivers/video/pm3fb.c
Date: Wed, 27 Nov 2002 08:26:21 +0100
Sender: kernel-janitor-discuss-admin@lists.sourceforge.net
Message-ID: <20021127072621.GB781@iliana>
References: <20021125175333.GA5091@iliana> <Pine.LNX.4.44.0211262335060.3719-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <kernel-janitor-discuss-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211262335060.3719-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Romain Dolbeau <dolbeau@irisa.fr>, Chris Wilson <chris@qwirx.com>, Linux Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>, Trivial Patch Monkey <trivial@rustcorp.com.au>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Nov 26, 2002 at 11:38:04PM +0000, James Simmons wrote:
> 
> > I have plans for doing a full rewrite of pm3fb for 2.5, just not really
> > the times right now. I will do it before 2.6 (or 3.0 or whatever) is
> > released though. I have already done some work, just not filled in the
> > mode changes and other such. That said, it may be on the limit of my
> > NDA, which was supposed to be for XFree86 only (altough i guess the
> > current XFree86 code counts as available from other source though.
> 
> I just finished the low level driver api. It pretty much is set in stone. 
> I might remove fg_color and bg_color in struct fb_image but that is a 
> maybe and a small issue. I'm going to add software rotation in tonight. 
> Then after that start cleaning up fbcon.c itself. You can grab the latest 
> patch against 2.5.49 at
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> It works and several drivers work. 

Ok, thanks, i will give it a try.

But right now, i am doing some XFree86 work that need to be finished
before (or shortly after) the 4.3.0 feature freeze.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
