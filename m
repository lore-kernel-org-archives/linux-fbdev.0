From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Date: Tue, 11 Mar 2003 15:31:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0303111527500.23668-100000@phoenix.infradead.org>
References: <20030309212903.GC16578@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030309212903.GC16578@vana.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Hi James,
>   I tried to use fb_cursor and I have quite a lot problems with
> it:

I'm working on the code today. I just finished the final touchs on the 
pixmap buffer code. The next step is to make the pixmaps have flag for 
static data versus dynamic data. You can then use fastfonst with static 
buffer. This comes with the tile code. But first the cursor code today.

P.S
  You can grab my latest work on the matroxfb driver at 

http://phoenix.infradead.org/~jsimmons/matroxfb.diff.gz
