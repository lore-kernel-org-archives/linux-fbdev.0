From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch][revision #2] Add w100 framebuffer driver
Date: Thu, 13 Jan 2005 00:47:28 -0000
Message-ID: <03ba01c4f909$781fd330$0f01a8c0@max>
References: <200501081837.08883.rpurdie@rpsys.net> <200501130822.26095.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cot9M-0003II-IK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 16:47:44 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Cot9L-0007Uu-Jw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 16:47:44 -0800
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: linux-fbdev-devel@lists.sourceforge.net, adaplas@hotpop.com
Cc: kronos@people.it

Antonino A. Daplas:
> On Sunday 09 January 2005 02:37, Richard Purdie wrote:
>> +static void w100fb_clear_screen(uint32_t mode, long int offset);
>
> I'll submit the patch but would it be better to use u32/u32* and family?

I seem to recall reading somewhere that uint32_t was the preferred form in 
the kernel. The code I was working from used a mixture so I made it 
consistent. If u32 is preferred, I'm happy enough to change it...

> BTW, I'm also submitting Andrew's backlight/lcd patch to akpm. Do you 
> think
> you can port your backlight driver to this framework?

I've been communicating with Andrew offlist and my backlight driver actually 
uses his framework already! It was me who put him onto the blanking event 
idea as that was the previous stumbling block for his patch. I was planning 
on submitting the corgi backlight driver as soon as the class is approved 
(the other code it depends upon has just been approved).

Richard 



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
