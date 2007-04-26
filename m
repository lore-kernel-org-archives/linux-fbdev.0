From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 01/41] epson1355fb.c: Fix error
	handling code
Date: Thu, 26 Apr 2007 08:42:26 +0800
Message-ID: <1177548146.4660.2.camel@daplas>
References: <462EF229.4080903@gmail.com>
	<20070425173330.8901c396.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgs4A-0004bX-NX for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 17:42:35 -0700
Received: from qb-out-0506.google.com ([72.14.204.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgs49-00054r-E4
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 17:42:34 -0700
Received: by qb-out-0506.google.com with SMTP id e21so144933qba
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 17:42:32 -0700 (PDT)
In-Reply-To: <20070425173330.8901c396.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roland Stigge <stigge@antcom.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2007-04-25 at 17:33 -0700, Andrew Morton wrote:
> Well that was a bad day for fbdev bugs.

Still way better than -mm though :-)

> 
> If you think any of these should be in 2.6.21, please identify
> which ones, asap.
> 

Nothing critical, maybe the first one, but even that can wait.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
