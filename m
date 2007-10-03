From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 06/17] platinumfb: Fix resource
	management
Date: Wed, 3 Oct 2007 13:56:29 -0700
Message-ID: <20071003135629.96ff8ebf.akpm@linux-foundation.org>
References: <46FDAA91.4080205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IdBGu-0004MJ-5J for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 13:56:47 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IdBGs-00040C-NR
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 13:56:43 -0700
In-Reply-To: <46FDAA91.4080205@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

On Sat, 29 Sep 2007 09:29:53 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> Current kernels have a non-working platinumfb due to some resource
> management issues. This fixes it.

Why isn't this 2.6.23 material?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
