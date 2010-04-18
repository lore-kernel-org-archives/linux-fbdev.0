From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 07/16] viafb: Add 1200x900 DCON/LCD panel modes for OLPC
 XO-1.5
Date: Sun, 18 Apr 2010 11:39:30 -0600
Message-ID: <20100418113930.1ba08ee3@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<1270746946-12467-8-git-send-email-corbet@lwn.net>
	<4BBF9BC2.9070502@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBF9BC2.9070502@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 09 Apr 2010 23:27:30 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> What will happen if someone with no VX855 will try to enter 1200x900 
> mode? Probably the world won't be destroyed but I have a really ugly 
> feeling that the driver is not well prepared for this situation. 

OK, I'm certainly exposing my relative lack of understanding of
framebuffer issues (I'm here to add a camera driver, remember? :),
but...is this really something that older chipsets can't handle?  Or is
it just that nobody has had that size of panel before?

> Haven't 
> tested yet as I'm waiting for the official forward port but I think it 
> might be better to reschedule this patch for later or add some PLL 
> values that are supposed to work (using/executing the formulas in the 
> VIA open source X driver)

If it's really not acceptable, then it will stay out, but I would
rather get it merged.  I will leave it in the series for now; it can
come out later if need be.

Thanks,

jon
