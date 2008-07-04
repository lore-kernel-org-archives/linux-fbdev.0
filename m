From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Enabling Hardware acceleration in existing
 framebuffer driver
Date: Fri, 4 Jul 2008 19:32:26 +0200
Message-ID: <20080704193226.a1750cf8.krzysztof.h1@poczta.fm>
References: <486E4812.5070803@linuxinstruments.com>
	<20080704182215.6f64f848.krzysztof.h1@poczta.fm>
	<486E50F5.5070401@linuxinstruments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEp57-0003O2-Ud for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 10:28:25 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KEp56-0004ve-Ev
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 10:28:25 -0700
In-Reply-To: <486E50F5.5070401@linuxinstruments.com>
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
To: Keith Williams <espian@linuxinstruments.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 04 Jul 2008 12:33:57 -0400
Keith Williams <espian@linuxinstruments.com> wrote:

> The fillrect was the simplest to implement.  I agree that the others
> will be much higher value.
> 
> In DirectFB there are a set of benchmarks that run through all of the
> different drawing types including filled rectangles.  That is what I am
> using as my baseline.
> 

I don't know DirectFB. I am not sure if the DirectFB uses the frame buffer
acceleration or its own. 

> However, even with the above code I don't see a change in the benchmark
> numbers leading me to believe that the acceleration is not being used.
> 

Please do simple test: give "time clear" command from the command line.

> Additionally, fbset shows accel to be false.  Even if I do a "fbset
> -accel true", it still reports false.
> 

AFAIK, the fbset tool uses the obsolete FB_ACCELF_TEXT flag. 
If your driver does not set this flag and does not use it you won't
see any difference.

> This is why I don't believe that the acceleration is being picked-up.

The only sure way is to put printk inside the fillrect function and
watch if it appeared in the dmesg output. The "clear" command
is good at useing the fillrect acceleration.

Regards,
Krzysztof


----------------------------------------------------------------------
Pogoda na dzis.
Sprawdz >>> http://link.interia.pl/f1e42


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
