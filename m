From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Thu, 22 Apr 2004 23:43:58 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
References: <20040422031855.GA19220@foogod.com>
        <Pine.LNX.4.44.0404222152260.25952-100000@phoenix.infradead.org>
        <20040423040313.GA4403@foogod.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGuPx-0008Vg-Qp
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 23:44:09 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGuPx-00009U-L2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 23:44:09 -0700
In-Reply-To: <20040423040313.GA4403@foogod.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: alex@foogod.com
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org

> I'm currently merging our two sets of patches into one driver.  I do
> note that patch gets a little confused when trying to do it itself and
> places a couple of bits of code in really odd places, which might have
> been part of why it didn't work for you.  I think I should have an
> updated patchset ready to post later tonight..

Ok, I've got everything except the blanking patch (which isn't finished
anyway) converted to apply cleanly to James' patched driver source. 
Everything works fine on my laptop as far as I can tell.  Additional
feedback is welcome.

I've put up a web page for the patches.  They can be found at
http://www.foogod.com/~alex/neofb/

-alex




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
