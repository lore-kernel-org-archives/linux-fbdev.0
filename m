From: James Simmons <jsimmons@infradead.org>
Subject: Re: [STATUS] fbdev api.
Date: Wed, 4 Dec 2002 15:00:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212041457580.1533-100000@maxwell.earthlink.net>
References: <1038972718.1086.17.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1038972718.1086.17.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux console project <linuxconsole-dev@lists.sourceforge.net>


> Can you apply the following patch to include logo drawing support for all formats :-)?

Applied :-)

> It's not the switch back to text mode, that's very doable (see my other
> reply).  It's during give_up_console() at fbcon module exit.  At this
> point, the console suddenly disappears and freezes the system.  Maybe we
> can save the global "conswitchp" during fbcon module init, then
> something like this at fbcon module exit:
>
> void __exit fb_console_exit(void)
> {
> 	give_up_console(&fbcon);
> 	take_over_console(saved_conswitchp, ...);
> }
>
> Is this feasible?

I thought about it but the solution is not easy. Consider that we have
vgacon and mdacon. Then I load in hgafb. Here the goal is to take over
mdacon. So we have to prevent taking over vgacon. Since there is only on
conswitchp we are in trouble.
