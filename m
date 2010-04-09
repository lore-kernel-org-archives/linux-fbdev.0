From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 05/16] viafb: Determine type of 2D engine and store it
 in chip_info
Date: Fri, 9 Apr 2010 14:11:27 -0600
Message-ID: <20100409141127.42e4e1fa@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<1270746946-12467-6-git-send-email-corbet@lwn.net>
	<4BBE9CFC.2020804@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBE9CFC.2020804@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 09 Apr 2010 05:20:28 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> Just a minor nit:
> Could we change the default so that if someone adds support for a new 
> IGP (and misses this function) we default to either the newest or 
> preferably to none? I've just seen too much poorly maintained code in 
> this driver and defaulting to the oldest is hence a bad idea.
> Otherwise it's fine.

That would require making an exhaustive list of older chipset types.
It could probably be inferred through inspection of the code, but I
worry about making assumptions in this area...

Thanks,

jon
