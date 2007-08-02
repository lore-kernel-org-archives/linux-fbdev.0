From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cg6: fix memory size detection
Date: Wed, 01 Aug 2007 21:42:01 -0700 (PDT)
Message-ID: <20070801.214201.75429989.davem@davemloft.net>
References: <20070802011133.7b78fb84.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGSVd-000269-Nr for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 21:42:01 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IGSVd-0004uS-FE
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 21:42:01 -0700
In-Reply-To: <20070802011133.7b78fb84.krzysztof.h1@wp.pl>
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
To: krzysztof.h1@wp.pl
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Thu, 2 Aug 2007 01:11:33 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes memory size detection on the CG6 card. 
> The 1MB TGX card has dblbuf property set to 0.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Applied.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
