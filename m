From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 01/16] [FB] viafb: Fix various resource leaks during
 module_init()
Date: Fri, 9 Apr 2010 13:31:39 -0600
Message-ID: <20100409133139.1ab17828@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<1270746946-12467-2-git-send-email-corbet@lwn.net>
	<4BBE1F01.5000800@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBE1F01.5000800@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

On Thu, 08 Apr 2010 20:22:57 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> >  	if (!viafbinfo->screen_base) {
> >  		printk(KERN_INFO "ioremap failed\n");
> > -		return -ENOMEM;
> > +		rc = -EIO;
> 
> I don't know whether this is right (changing the return code) as Andrew 
> recommend a while ago:
> "It should return -ENOMEM rather than -1, but that's minor."
> So I did and now I wonder which one is correct?

To me it seems like -ENOMEM could be a bit confusing here; there's a lot of
things that could go wrong with that same error return.

That said, I did some digging around, and -ENOMEM does seem to be the
standard response to an ioremap() failure.  So I've changed it back.

> >  		if (!viafbinfo1) {
> >  			printk(KERN_ERR
> >  			"allocate the second framebuffer struct error\n");
> > -			framebuffer_release(viafbinfo);
> > -			return -ENOMEM;
> 
> rc = -ENOMEM;
> is missing?

Indeed.  Fixed.

Thanks,

jon
