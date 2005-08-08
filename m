From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Don't allow softcursor use from userland
Date: Mon, 08 Aug 2005 08:59:33 +0800
Message-ID: <42F6AE75.6090409@gmail.com>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org> <42F5E3E7.3020901@gmail.com> <Pine.LNX.4.56.0508080013400.12912@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1vzI-0003rp-Ey
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 17:59:32 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1vzI-00056P-8V
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 17:59:32 -0700
Received: by wproxy.gmail.com with SMTP id i21so662169wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 17:59:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508080013400.12912@pentafluge.infradead.org>
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
>> James Simmons wrote:
>>     
>>> This patch forbids the cursor use from userland. The reason is that the 
>>> cursor area could be altered by a another process and the current system
>>> doesn't handle syncing those updates.
>>>
>>>       
>> I don't really like this change.  I prefer Jon's proposal of setting
>> fbops->fb_cursor = NULL and moving softcursor.c to drivers/video/console.
>> This will slash > 200 lines of source code and several bytes from the kernel
>> image size. Plus it's cleaner.
>>     
>
> One change at a time. If you want to properly do cursor in fbcon then just 
> moving softcursor there is not the answer. What if you have a driver that 
>   

See the patch again, there's only one logical change. And the intent of the
patch was never to support userspace cursor.

> has software image blit and hardware fillrect. You want to have fbcon use 
>   

Then the driver sets fbops->fb_cursor with its own version that does 
fillrect instead of imageblit.

I think you're still trying to overload fbops->fb_cursor. These drawing 
functions in info->fbops (fb_imageblit, fb_fillrect, fb_copyarea and
fb_cursor) are  for fbcon use _only_. They cannot be used in userspace
because of the inherent limitations of the code, and it depends on fields
that are internal to fbdev/fbcon (ie pseudo_palette). And even if you make it
work, I doubt it will be efficient code. Remember that the fbcon  hooks were
written in such a way so that we can have a very fast console, but it
sacrifices  userspace compatibility.

If you want to add userspace support for hardware cursors then you have to
create another API. If you don't want another API, then forget about userspace
support. Overloading fbops->fb_cursor is not the answer.

Tony




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
