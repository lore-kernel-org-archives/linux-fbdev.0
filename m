From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: Fbdev 2.5.49 BK fixes.
Date: Mon, 2 Dec 2002 21:11:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212022110150.20834-100000@phoenix.infradead.org>
References: <20021128083246.GA2703@zion.rivenstone.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021128083246.GA2703@zion.rivenstone.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joseph Fannin <jhf@rivenstone.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


>     aty128fb works for me here with:
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
> 
>     Thank you!

Great. I made more inprovements with my latest patch. Give it a try. 

>     There are a few glitches, but I've been unable to pin down
> anything serious as the fbdev patch's fault.  I'm still playing with
> things (like Antonio Daplas' patches).  I'll give a more full report
> later.

I just intergrated a bunch of his work. The subsystem is starting to 
really take shape. 

>     FWIW, the fbdev patch applies with a few minor offsets to 2.5.50
> except for the attached patch, which I extracted from bk.  So if you
> apply this patch in *reverse* to a clean 2.5.50 tree, the fbdev patch
> should then apply okay (patch complained about a reversed hunk in
> fbcon.c, but it should be harmless, I think.)

I noticed. My new patch fixes that.
