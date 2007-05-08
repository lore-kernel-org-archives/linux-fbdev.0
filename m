From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 07/20] arkfb: New framebuffer driver
	for ARK Logic cards
Date: Mon, 7 May 2007 23:31:02 -0700
Message-ID: <20070507233102.3ed6c42d.akpm@linux-foundation.org>
References: <463C9A29.4010505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlJER-0007RY-G1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:31:31 -0700
Received: from smtp1.linux-foundation.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlJEQ-0005dM-5L
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:31:31 -0700
In-Reply-To: <463C9A29.4010505@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 05 May 2007 22:52:25 +0800 "Antonino A. Daplas" <adaplas@gmail.com> wrote:

> This patch adds fbdev driver for graphics cards with
> ARK Logic 2000PV graphics chip with ICS 5342 ramdac.

also breaks with CONFIG_MTRR=n

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
