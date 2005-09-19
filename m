From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
Date: Tue, 20 Sep 2005 06:07:48 +0800
Message-ID: <432F36B4.8030209@gmail.com>
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHTpo-0001lo-Ce
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 15:10:00 -0700
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHTpn-0004OS-SX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 15:10:00 -0700
Received: by zproxy.gmail.com with SMTP id 14so615879nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 15:09:52 -0700 (PDT)
In-Reply-To: <432F08C1.8010705@ppp0.net>
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
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Jan Dittmer wrote:
> jurriaan wrote:
>> After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
>> my console.
> 
> Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
> sorry. No fb options on the kernel command line.
> 

Can you try reversing this particular diff?

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff_plain;h=af99ea96012ec72ef57fd36655a6d8aaa22e809e;hp=30f80c23f934bb0a76719232f492153fc7cca00a

Tony




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
