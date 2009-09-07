From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [Linux-fbdev-devel] [PATCH v2] viafb: 2D engine rewrite (and
 viafb patches in general)
Date: Mon, 07 Sep 2009 04:51:00 +0200
Message-ID: <4AA47514.8080801@gmx.de>
References: <1251666438-5448-1-git-send-email-FlorianSchandinat@gmx.de>	<1252097032-3568-1-git-send-email-FlorianSchandinat@gmx.de>	<20090905161645.74a49a84@bike.lwn.net>	<20090905160140.7b36527f.akpm@linux-foundation.org>	<4AA3048D.2090605@gmx.de> <20090906074002.7976d4a5@bike.lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758717AbZIGCvP@vger.kernel.org>
In-Reply-To: <20090906074002.7976d4a5@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Jonathan Corbet schrieb:
>> Do you have a pointer to the OLPC tree?
> 
> git://dev.laptop.org/olpc-2.6
> 
> They are working in the olpc-2.6.30 branch, currently.

Thanks. After having a look at it seems concerning viafb to be mostly 
Haralds patches with 1 or 2 extra ones.

>> I'd really like to see VX855/OLPC support in mainline as soon as 
>> possible as I consider it a good thing to support "new" hardware early. 
>> However even if I am capable to write such support based on Haralds work 
>> I don't want to see it in mainline as long as no one with that hardware 
>> tested it.
> 
> I do have the hardware, and I've taken on the responsibility for making
> pieces of it work.  In my mind, that includes being responsible for
> mainlining things too.  I will start to work in that direction; 2.6.33
> should be a reasonable target for the bulk of it.
> 
> My thinking, FWIW, is to turn the viafb code into something more like a
> regular multi-function device driver.  I've already integrated Harald's i2c
> stuff with the OLPC code; I need to add proper GPIO support next.  Then
> there will be the V4L2 chunk for the video capture engine.  Along the way,
> I may try to introduce some foreign concepts like locking.

Feel free to add the things you like. The main objective is probably to 
get things working and stable. I do not have an idea how good that will 
work out as I don't know how much code that requires. If you think 
that's the way to go, then we'll try it and see whether it leads to 
something usable and maintainable.

> I have a tree on git.lwn.net now, but it's against the 2.6.30 base.  I will
> try to bring things forward to a more current tree sometime soon and put it
> up as, at least, a place where we can see the various lines of development
> going on.
> 
> Sound good?

Jep, that's fine with me. I'll try to rebase&integrate the patches I 
consider interesting from Harald's tree in -mm. I guess that's a good 
thing to do as that's the latest used common base.
Any objections?


Regards,

Florian Tobias Schandinat
