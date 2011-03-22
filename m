From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Mar 2011 05:40:50 +0000
Subject: Re: [GIT PULL] omap display subsystem changes for 2.6.39
Message-Id: <20110322054049.GB25925@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300701083.2891.77.camel@deskari>
In-Reply-To: <1300701083.2891.77.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Mar 21, 2011 at 11:51:23AM +0200, Tomi Valkeinen wrote:
> One problem I noticed just now, the committer names seem a bit messed
> up. For example, Archit Taneja has three different style names there. Do
> you think I should rebase and fix them? Not a big job, but it'll mean,
> well, rebasing.
> 
No need, this is what .mailmap is for. It seems there are quite a few
variations, I've added entries now for all of:

	Archit Taneja <archit@ti.com>
	Mayuresh Janorkar <mayur@ti.com>
	Mythri P K <mythripk@ti.com>
	Sumit Semwal <sumit.semwal@ti.com>

which traps all of the offenders in these patches. There seems to be a
general issue of author names and sign-offs using reverse order naming, I
assume because this is some absurd convention used by TI's mail servers.

We can of course continue fixing them up as they pop up, but people
should ideally be aware of the need for consistency before committing
things, too. A bit of name mangling is certainly a lesser evil than
rewriting history, though.

> There's a minor conflict in Overo's board file. I have pushed
> "for-paul-merged" branch to gitorious, which contains a merge with
> Linus' tree. I'm not sure that is the best way to show how to fix the
> conflict, but hopefully it'll give the idea.
> 
Seemed pretty straightforward, I took care of it and made sure that it
still built. I assume Tony or someone will yell loudly if I've
inadvertently broken something :-)

Pulled now. I'll send things off to Linus shortly.
