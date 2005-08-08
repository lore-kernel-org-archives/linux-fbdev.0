From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Don't allow softcursor use from userland
Date: Tue, 09 Aug 2005 07:56:13 +0800
Message-ID: <42F7F11D.40706@gmail.com>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org> <42F5E3E7.3020901@gmail.com> <Pine.LNX.4.56.0508080013400.12912@pentafluge.infradead.org> <42F6AE75.6090409@gmail.com> <Pine.LNX.4.56.0508081831220.27739@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2fVO-0005dx-SE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 18:35:42 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2f3K-0007I6-40
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 18:07:09 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1E2Pn6-0007ae-3A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 01:48:58 -0700
Received: by wproxy.gmail.com with SMTP id i21so929819wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Aug 2005 01:48:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508081831220.27739@pentafluge.infradead.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

James Simmons wrote:
> 
> What is wrong with brekaing this patch into smaller pieces????????????
> I'm not getting a answer!!!!! As I said no giant patches that tocuh every 
> driver.
> 
>>> has software image blit and hardware fillrect. You want to have fbcon use 
>>>   
>> Then the driver sets fbops->fb_cursor with its own version that does 
>> fillrect instead of imageblit.
> 
> No. fb_cursor is only used for a hardware cursor case. 

And what happens if the driver does not have support for a hardware cursor? 

> 
>> If you want to add userspace support for hardware cursors then you have to
>> create another API. If you don't want another API, then forget about userspace
>> support. Overloading fbops->fb_cursor is not the answer.
> 
> So fbops->fb_cursor will not be used at all for the console? 

You're getting it backwards.  fbops->fb_cursor is for the console. If you want
userspace hardware cursor, then we need a new API.  It's not something that I
want, just a fact.  Look at the code. Remember, I wrote the orginal fb_cursor
code, so I know its limitations. The sole purpose was to replace the 2.4
permanently blinking block and to allow users to have a choice of using an
underline or block cursor. 

But to overload fbops->fb_cursor for use in userspace will just introduce new
headaches and will be painful to debug.

> 
> Look the patch I sent is small and doesn't interfere with many drivers. It 
> does stop your desires either. Personally softcursor should go away.
> 

And force all maintainers to write forhardware cursor support?  Even X doesn't have
that 100% support. Might as well remove cfbimageblit, cfbfillrect and
cfbcopyarea too, if that's what you want.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
