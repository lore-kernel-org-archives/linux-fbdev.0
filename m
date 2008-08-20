From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 0/2] metronomefb and
	am200epd fixes v9
Date: Wed, 20 Aug 2008 14:35:38 +0800
Message-ID: <f17812d70808192335w66a6995er38bc60f9556bf1f@mail.gmail.com>
References: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
	<20080819100339.GD1067@flint.arm.linux.org.uk>
	<45a44e480808190313y1f6e89a8r79611807664b712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVhIS-0000oK-NT for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 23:35:56 -0700
Received: from yx-out-1718.google.com ([74.125.44.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVhIS-0001nG-Gb
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 23:35:56 -0700
Received: by yx-out-1718.google.com with SMTP id 3so113250yxi.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 19 Aug 2008 23:35:55 -0700 (PDT)
In-Reply-To: <45a44e480808190313y1f6e89a8r79611807664b712@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk

>
> Ah sorry, it's missing metronomefb.h changes which is in patch 2/2. I
> had split them to make reviewing easier. I'll post patch 2/2 to the
> patch queue now.
>

Please make sure every commit is at-least build-able, this helps
to find regression easier.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
