From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2/2] intelfb/fbdev: Save info->flags in a local variable
Date: Tue, 16 Aug 2005 05:51:11 +0800
Message-ID: <43010E4F.6090502@gmail.com>
References: <430098A7.1080102@gmail.com> <Pine.LNX.4.58.0508150957230.3553@g5.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4msF-0007Pw-0y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 14:52:03 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E4msD-0000DL-NE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 14:52:03 -0700
Received: by wproxy.gmail.com with SMTP id i21so10574wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Aug 2005 14:51:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0508150957230.3553@g5.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Pavel Kysilka <goldenfish@bsys.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Linus Torvalds wrote:
> 
> On Mon, 15 Aug 2005, Antonino A. Daplas wrote:
>> @@ -697,7 +697,7 @@ fb_set_var(struct fb_info *info, struct 
>>  			    !list_empty(&info->modelist))
>>  				err = fb_add_videomode(&mode, &info->modelist);
>>  
>> -			if (!err && info->flags & FBINFO_MISC_USEREVENT) {
>> +			if (!err && flags & FBINFO_MISC_USEREVENT) {
>>  				struct fb_event event;
>>  				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
>>  					FB_EVENT_MODE_CHANGE_ALL :
> 
> This doesn't match my tree - I assume we're talking about the -mm tree 
> here.
> 
> I can/will fix up the thing by hand, but somebody should check it.
> 
> 		Linus
> 

Sorry about that, I forgot.  I checked your git tree, and it looks good.

Thanks.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
