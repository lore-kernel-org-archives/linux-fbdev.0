From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Framebuffer display corruption on 2.6.12
Date: Sat, 13 Aug 2005 06:20:34 +0800
Message-ID: <42FD20B2.3080209@gmail.com>
References: <42FCD122.4070705@gentoo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3htn-0000kX-4z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 15:21:11 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3htk-0005eT-FK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 15:21:11 -0700
Received: by zproxy.gmail.com with SMTP id 9so475446nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Aug 2005 15:21:02 -0700 (PDT)
In-Reply-To: <42FCD122.4070705@gentoo.org>
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
To: linux-fbdev-devel@lists.sourceforge.net

Daniel Drake wrote:
> Hi,
> 
> This looks like a userspace issue, but apparently it only appears after 
> upgrading from 2.6.11 to 2.6.12...
> 
> Some Gentoo users have reported display corruption when using the 
> framebuffer, easily visible in dialog-based applications. Sample 
> screenshot:
> 
> https://bugs.gentoo.org/attachment.cgi?id=63264
> 
> Although the screenshot shows a framebuffer running on top of gentoo's 
> "framebuffer splash", the same issue exists if you use plain old vesafb 
> with no splash.
> 
> The issue has been reproduced in 2.6.13-rc5-mm1.

I can't reproduce it here.  But can you try to reproduce it with vgacon
and with fbcon.

> 
> Any pointers in the right direction would be appreciated. Should I get 
> this reported to the kernel bugzilla?
> 

You may. (Do it under Drivers->Console/Framebuffers) Some prefer bugzilla,
some don't. I don't mind which.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
