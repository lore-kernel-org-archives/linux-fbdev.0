From: Keith Williams <espian@linuxinstruments.com>
Subject: Re: Enabling Hardware acceleration in existing
 framebuffer driver
Date: Fri, 04 Jul 2008 12:33:57 -0400
Message-ID: <486E50F5.5070401@linuxinstruments.com>
References: <486E4812.5070803@linuxinstruments.com>
	<20080704182215.6f64f848.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEoEp-0006KE-Rc for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 09:34:24 -0700
Received: from host5.the-web-host.com ([209.239.32.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KEoEo-0004fh-ES
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 09:34:23 -0700
Received: from [127.0.0.1] (fw.hemocleanse.com [72.12.202.234])
	by host5.the-web-host.com (8.12.11.20060614/8.12.9) with ESMTP id
	m64GYKYd003877 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 4 Jul 2008 12:34:21 -0400
In-Reply-To: <20080704182215.6f64f848.krzysztof.h1@poczta.fm>
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
To: linux-fbdev-devel@lists.sourceforge.net


> The fillrect acceleration is probably used but rarely. 
> One sure way to trigger it is to issue the "clear" command on the 
> frame buffer console. Try "time clear" on a big resolution screen with and 
> without your change. You should see a difference from few to few tens times
> in speed.
>
> The more useful is both the copyarea and imageblit acceleration. Both are
> used during console scrolling (the imageblit is preferred but on some cards
> the copyarea is faster).
>
> I don't know about the DirectFB so I cannot comment.
>
>   

Thanks for the reply.

The fillrect was the simplest to implement.  I agree that the others
will be much higher value.

In DirectFB there are a set of benchmarks that run through all of the
different drawing types including filled rectangles.  That is what I am
using as my baseline.

However, even with the above code I don't see a change in the benchmark
numbers leading me to believe that the acceleration is not being used.

Additionally, fbset shows accel to be false.  Even if I do a "fbset
-accel true", it still reports false.

This is why I don't believe that the acceleration is being picked-up.
Any other ideas with the driver code/things that I am missing?

Thanks,

Keith



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
