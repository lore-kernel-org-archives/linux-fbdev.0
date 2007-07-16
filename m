From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] remove tx3912fb
Date: Mon, 16 Jul 2007 21:09:37 +0100
Message-ID: <20070716200937.GA23544@linux-mips.org>
References: <20070714210825.6bddf23f.yoichi_yuasa@tripeaks.co.jp>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IAWtw-0007ZD-NM for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Jul 2007 13:10:36 -0700
Received: from ftp.linux-mips.org ([194.74.144.162])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IAWtv-0001Qt-3V
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Jul 2007 13:10:36 -0700
Received: from localhost.localdomain ([127.0.0.1]:11413 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024759AbXGPUJk (ORCPT
	<rfc822;linux-fbdev-devel@lists.sourceforge.net>);
	Mon, 16 Jul 2007 21:09:40 +0100
Content-Disposition: inline
In-Reply-To: <20070714210825.6bddf23f.yoichi_yuasa@tripeaks.co.jp>
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
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Sat, Jul 14, 2007 at 09:08:25PM +0900, Yoichi Yuasa wrote:

> This patch has removed tx3912fb.
> Nino has already removed. it is no need anymore.

ACK.

Somebody is still working on Nino support but even assuming that'll
eventually yield a result this FB driver has not seen any testing on
hardware since several years so removing won't do any harm.

  Ralf

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
