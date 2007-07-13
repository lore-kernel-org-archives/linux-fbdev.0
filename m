From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [RFC] SM501: Call fb suspend
	function	during suspend and resume.
Date: Fri, 13 Jul 2007 20:57:24 +0800
Message-ID: <1184331444.4702.15.camel@daplas>
References: <20070710090124.GA3628@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9Kil-0003k7-Ht for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:58:08 -0700
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9Kii-0003Tb-O2
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:58:07 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1168770nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 13 Jul 2007 05:58:04 -0700 (PDT)
In-Reply-To: <20070710090124.GA3628@fluff.org.uk>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ben Dooks <ben-linux@fluff.org>

On Tue, 2007-07-10 at 10:01 +0100, Ben Dooks wrote:
> I belive the following patch to be correct:
> 
> Call the fb_set_suspend() over suspend and resume.
> 
It's correct.  I'll be pushing your patches to akpm after the next -mm
release.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
