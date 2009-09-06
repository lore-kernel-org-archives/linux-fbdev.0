From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [Linux-fbdev-devel] [PATCH v2] viafb: 2D engine rewrite (and
 viafb patches in general)
Date: Sun, 6 Sep 2009 07:40:02 -0600
Message-ID: <20090906074002.7976d4a5@bike.lwn.net>
References: <1251666438-5448-1-git-send-email-FlorianSchandinat@gmx.de>
	<1252097032-3568-1-git-send-email-FlorianSchandinat@gmx.de>
	<20090905161645.74a49a84@bike.lwn.net>
	<20090905160140.7b36527f.akpm@linux-foundation.org>
	<4AA3048D.2090605@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757963AbZIFNkE@vger.kernel.org>
In-Reply-To: <4AA3048D.2090605@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> Do you have a pointer to the OLPC tree?

git://dev.laptop.org/olpc-2.6

They are working in the olpc-2.6.30 branch, currently.

> I'd really like to see VX855/OLPC support in mainline as soon as 
> possible as I consider it a good thing to support "new" hardware early. 
> However even if I am capable to write such support based on Haralds work 
> I don't want to see it in mainline as long as no one with that hardware 
> tested it.

I do have the hardware, and I've taken on the responsibility for making
pieces of it work.  In my mind, that includes being responsible for
mainlining things too.  I will start to work in that direction; 2.6.33
should be a reasonable target for the bulk of it.

My thinking, FWIW, is to turn the viafb code into something more like a
regular multi-function device driver.  I've already integrated Harald's i2c
stuff with the OLPC code; I need to add proper GPIO support next.  Then
there will be the V4L2 chunk for the video capture engine.  Along the way,
I may try to introduce some foreign concepts like locking.

I have a tree on git.lwn.net now, but it's against the 2.6.30 base.  I will
try to bring things forward to a more current tree sometime soon and put it
up as, at least, a place where we can see the various lines of development
going on.

Sound good?

jon
