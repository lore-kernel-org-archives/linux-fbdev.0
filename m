From: James Simmons <captain_delete@yahoo.com>
Subject: Re: RFC: Optimizing putcs()
Date: Thu, 8 Aug 2002 11:31:52 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020808183152.47469.qmail@web13002.mail.yahoo.com>
References: <1028657448.554.6.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web13002.mail.yahoo.com ([216.136.174.12])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cs4h-0006un-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 11:31:55 -0700
In-Reply-To: <1028657448.554.6.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org

> I took a crack at adding support for bpp24 for the
> cfb_* drawing
> functions.  I tried to keep the original code as
> much as possible, so
> the result may not be optimal.  My test shows though
> that bpp24 should
> be as fast as (maybe a tad slower than) bpp32.

Thanks.
 
> As for drawing the logo, will the source be
> containing indices to the
> palette?

I believe so. I haven't thought much about it.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
