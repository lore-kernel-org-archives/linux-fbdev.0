From: James Simmons <jsimmons@infradead.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Date: Wed, 22 Oct 2003 22:46:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310222242130.25125-100000@phoenix.infradead.org>
References: <20031022205043.GA725@rivenstone.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20031022205043.GA725@rivenstone.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jhf@rivenstone.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


>     The attached patch is needed to make tdfxfb compile after
> applying this patch and also in test8-mm1 (so presumably in your older
> patch as well) (tdfxfb_imageblt calls cfb_imageblt).

Thanks.
 
>     tdfx is still badly broken in -mm1 both before and after replacing
> the older fbdev patch in -mm1 with your new one.  The behavior is much
> the same as reported with other drivers -- out of range frequencies
> and the same backtraces.  With fbset working I can set a new
> resolution which gets me a barely usable console -- lots of
> artifacts.

The out frequencies range problems existed before the api change for many 
drivers. Now that i2c support is being added to drivers this will go away.
The backtraces is from having debug info turned on. I haven't traced that 
problem yet. Are the artifacts from shrinking the screen or enlarging it?
