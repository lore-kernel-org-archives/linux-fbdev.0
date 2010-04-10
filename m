From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC] Initial OLPC Viafb merge
Date: Fri, 9 Apr 2010 18:27:22 -0600
Message-ID: <20100409182722.3080bb2d@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<4BBEBE87.4000809@gmx.de>
	<20100409124626.0b150104@bike.lwn.net>
	<4BBFB914.1020600@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBFB914.1020600@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

On Sat, 10 Apr 2010 01:32:36 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> Please correct me if I am wrong but the remaining 6 patches concerning 
> suspend&resume look like a real big FIXME. So at the end it is expected 
> to work only on VX855 and needs something called OFW?

OFW = OpenFirmware.  You could say BIOS instead.  It's pretty normal to
expect the BIOS to put things into a semi-rational state at resume time.

> It doesn't seem to make much sense to review each of them because the 
> following patches might or might not correct some of the issues of the 
> other. It is really a pain to have 6 patches trying to add a single 
> feature. Is there any way to fix this mess. (I assume you didn't merge 
> them due to authorship issues?)

It's true that one needs to look at the end product.  I only looked at
the S/R code recently, and tried to fix some of the biggest issues that
would keep it out of the mainline.

> I think it might be better to drop those for now and wait for viafb to 
> be in a better shape before adding this feature. The mode setting should 
> be in a pretty good shape just 1 or 2 kernel versions ahead so that the 
> dependency on OFW can be dropped I think.
> 
> Sorry but I really think this is not in a shape where merging it is an 
> option. I think it would be better to skip those suspend/resume patches 
> for the next merge window.

Well, if we want to keep s/r out of tree, we can do that.  It will
complicate the merge of the other stuff, since it's got hooks into the
GPIO and camera code too.  But, like everything else I've posted so
far, it's not the work that I personally set out to do.  I can push
that work on others :)

That said, the suspend/resume support in this patch set makes suspend
work on one chipset, and probably comes pretty close on the others
without breaking anything there.  I don't see the harm in merging it;
it makes the code better than it is now.  I would rather not have to
separate it out from the rest.  But I'll not fight over this one; if
there's real opposition then we can force OLPC to continue to carry it
out of tree.

jon
