From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [FB PATCH]
Date: Sat, 28 Dec 2002 17:44:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212281743430.31728-100000@phoenix.infradead.org>
References: <20021227150934.A3005@twiddle.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021227150934.A3005@twiddle.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Henderson <rth@twiddle.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, torvalds@transmeta.com


> I got link errors due to a missing fb_blank function.  The best
> I can figure is that you were intending to call the fb_blank 
> fbops hook.  Certainly that seems to work.
> 
> I'm not sure how no one else ran into this. 

Okay that is weird. Yes it was suppose to call fb_blank the function.This 
function exist in fbmem.c and it is even exported for modular fbdev 
drivers. 
