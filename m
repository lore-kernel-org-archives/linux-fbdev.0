From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 02/16] viafb: use proper pci config API
Date: Fri, 9 Apr 2010 13:46:10 -0600
Message-ID: <20100409134610.0b610f93@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<1270746946-12467-3-git-send-email-corbet@lwn.net>
	<4BBE2389.5010802@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBE2389.5010802@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 08 Apr 2010 20:42:17 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> something I am wondering about is whether we can't simply do:
> viaparinfo->memsize = pci_resource_len(pdev, 0);
> I suppose that this is not possible meaning that the pci len can be 
> longer than the actual memory but I just wanted to use the moment to 
> make sure.

That would make sense.  But if somebody who is closer to the hardware than
I am doesn't take that approach, I'm nervous about changing it.  Harald?

> This function was not designed to return an error (memsize is not 
> checked). Either return a default value (let's say 8MB) or add a check 
> for memsize.

That's a good point.  I put in a check.

Thanks,

jon
