From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Silence radeon_pm warning
Date: Sun, 28 Oct 2007 20:06:12 -0700 (PDT)
Message-ID: <20071028.200612.179943206.davem@davemloft.net>
References: <20071029135911.ba1bfee2.sfr@canb.auug.org.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ImKx9-00088m-Jp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Oct 2007 20:06:21 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ImKx9-0001Yb-CT
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Oct 2007 20:06:11 -0700
In-Reply-To: <20071029135911.ba1bfee2.sfr@canb.auug.org.au>
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
To: sfr@canb.auug.org.au
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 29 Oct 2007 13:59:11 +1100

> drivers/video/aty/radeon_pm.c:30: warning: 'radeon_reinitialize_M10' declared 'static' but never defined
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
