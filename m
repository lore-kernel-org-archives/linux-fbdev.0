From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 08/16] viafb: Do not probe for LVDS/TMDS on OLPC XO-1.5
Date: Fri, 9 Apr 2010 18:19:42 -0600
Message-ID: <20100409181942.175b375a@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<1270746946-12467-9-git-send-email-corbet@lwn.net>
	<4BBF9EE7.50707@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBF9EE7.50707@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 09 Apr 2010 23:40:55 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> I don't like the idea of OLPC specific code. Isn't there any way to 
> speed this up in general?

Architecture-specific code happens.  OLPCs are wired differently; if
you go trying to do LVDS out those GPIO ports on an OLPC, you'll not
end up talking to the hardware you think you're talking to.  The best
thing to do is to avoid it altogether.

> There is not yet even an option for OLPC_XO_1_5 (in contrast to 
> CONFIG_OLPC) in mainline. Is such a thing planned?

Yes, it is.  That's part of the remaining OLPC support code which has
also been brought forward to 2.6.34 with the intention of mainlining it.

> I can't really see anything that would speak for accepting this patch 
> now in current mainline, sorry.

If you can come up with a better solution to the problem, I'm all
ears.  But without it you'll have a hard time running mainline kernels
on XO 1.5 systems.  It is all coming, but the OLPC folks are scrambling
to get everything together; I don't think we really need to make things
harder for them.

That said, machine_is_olpc() is properly defined for all
configurations, so the #ifdefs can (and should) come out.

jon
