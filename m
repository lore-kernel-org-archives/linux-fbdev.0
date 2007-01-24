From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] Recognize video=gx1fb:... option
Date: Wed, 24 Jan 2007 07:51:45 -0800
Message-ID: <20070124075145.8481a9c3.randy.dunlap@oracle.com>
References: <20070119211051.GC5013@martell.zuzino.mipt.ru>
	<20070124004826.0d1adffe.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751546AbXAXP4g@vger.kernel.org>
In-Reply-To: <20070124004826.0d1adffe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>, adaplas@pol.net, linux-kernel@vger.kernel.org, Jordan Crouse <jordan.crouse@amd.com>

On Wed, 24 Jan 2007 00:48:26 -0800 Andrew Morton wrote:

> On Sat, 20 Jan 2007 00:10:51 +0300
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Juergen Beisert reported that the following option doesn't work for him
> > 
> > 	video=gx1fb:1024x768-16@60
> > 
> > though sisfb was able to parse similar option correctly.
> > 
> 
> And does this patch fix it for him? ;)

Yes, Juergen replied to the patch:

Thank you very much. Yes it works. I tried these kernel parameters:

1) video=gx1fb:mode:1280x1024-16@60,crt:1
  -> CRT was active, 160x64 console
2) video=gx1fb:mode:1024x768-16@60,crt:1
  -> CRT was active, 128x48 console
3) video=gx1fb:mode:800x600-16@60,crt:0,panel:800x600
  -> CRT was disabled, 100x37 console
4) video=gx1fb:mode:1024x768-16@60,crt:0,panel:800x600
  -> CRT was disabled, 80x25 console

Sorry, I have no flatpanel, so I cannot test if the "panel" option works 
correctly. But somethings changes when I tried different values (see 3 and 
4).

Regards
Juergen


---
~Randy
