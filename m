From: Jim Hague <jim.hague@acm.org>
Subject: Re: New API and X option UseFBDev
Date: Tue, 09 Sep 2003 14:57:58 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030909145758.jim.hague@acm.org>
References: <20030909100849.GA17091@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wj0M-0004Vd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 06:58:02 -0700
Received: from mta05-svc.ntlworld.com ([62.253.162.45])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wj0L-0004cf-A8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 06:58:01 -0700
In-Reply-To: <20030909100849.GA17091@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 09-Sep-2003 Sven Luther wrote:
> On Tue, Sep 09, 2003 at 07:49:55AM +0100, Jim Hague wrote:
>> I have a problem when I try and run X (Debian 4.2.1-11 20030829103906). My
>> config uses the Glint driver with UseFBDev true, and works fine on 2.4.22.
>> [....]
>> It's occurred to me that maybe this just doesn't work and I need an updated
>> fbdevhw. Do I? Or should it really Just Work?
> 
> I think the glint driver is hardcoded to expect amiga hardware when
> using pm2 with fbdev. Just don't use the usefbdev option, and everything
> should be fine.
> 
> the glint driver does not really support usefbdev anyway, only as a
> hacky workaround for amigas with cybervision/bvision graphic board.

Unfortunately, I do rather think I need to use UseFBDev. Hardware is
Graphics Exxtreme, x86, BTW. Without, things just don't work properly -
something isn't quite right with the mode set by X, and you can't switch back
to the console. Well, you can try, but it seems to hang the kernel.

I'm currently using UseFBDev on 2.4, for the same reasons. I will keep on
digging.

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
