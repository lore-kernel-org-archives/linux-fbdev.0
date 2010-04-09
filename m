From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC] Initial OLPC Viafb merge
Date: Fri, 9 Apr 2010 12:46:26 -0600
Message-ID: <20100409124626.0b150104@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<4BBEBE87.4000809@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBEBE87.4000809@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 09 Apr 2010 07:43:35 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> Thanks a lot for your work I appreciate it very much.
> However there are 2 things I'd like to ask for:
> 
> Could you please forward port them to latest mainline? There went some 
> changes in for 2.6.34 that break some of your patches (but not many and 
> at least the first conflict is easy to fix) as I generally prefer to 
> test a version that does not contain too much changes from myself.

The OLPC tree is currently based on 2.6.34-rc1.  I forgot that your
stuff went in after that; pulling things forward would make sense.

> Please make checkpatch happy where appropriate. (whitespaces, ...)

Hmm, will check again.

> Fortunately I still have a bit time left to finish the review of the 
> remaining patches in the next days but I would really appreciate it very 
> much if you could publish your work more frequently in the future.

Sorry, the only working platform I had was the OLPC 2.6.31 tree, and
there was little point in publishing that by the time it was ready to
be seen.  That said, I *did* point out the tree where the work could be
seen for anybody who was interested.

In any case, it's very much my intent to get this stuff out there and
in for the next merge window.

Thanks for the reviews, I'll get to the specific issues in a bit.

jon
