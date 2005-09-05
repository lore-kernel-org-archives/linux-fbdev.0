From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: how long before a new driver makes it into
 the mainline kernel
Date: Tue, 06 Sep 2005 06:36:29 +0800
Message-ID: <431CC86D.4020905@gmail.com>
References: <20050905112144.GB1810@home.fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ECPaQ-0003hc-DT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Sep 2005 15:37:10 -0700
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ECPaO-0007K9-3B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Sep 2005 15:37:10 -0700
Received: by zproxy.gmail.com with SMTP id s18so747116nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 05 Sep 2005 15:37:01 -0700 (PDT)
In-Reply-To: <20050905112144.GB1810@home.fluff.org>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Ben Dooks wrote:
> I've just been notified that the s3c2410 framebuffer driver has been
> submitted by Arnaud. I have a question about what path this will
> take to getting into the mainline kernel,

New drivers go to the mm tree first. I just sent the patch to Andrew.

> and how long it will be.

It's early in the cycle, so it should get to linux-2.6.14. 

Tony

PS: If this driver is already well tested, we can always tell Andrew
to get it to mainline quicker.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
