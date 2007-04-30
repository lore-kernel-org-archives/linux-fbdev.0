From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pm2fb: Reset transparency settings
Date: Mon, 30 Apr 2007 14:58:45 +0800
Message-ID: <1177916325.4735.3.camel@daplas>
References: <4634ee8d7d1b2@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiPr2-0004vw-H3 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 23:59:24 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiPr2-0006kR-9B
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 23:59:24 -0700
Received: by py-out-1112.google.com with SMTP id a29so1268436pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 29 Apr 2007 23:59:24 -0700 (PDT)
In-Reply-To: <4634ee8d7d1b2@wp.pl>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, 2007-04-29 at 21:14 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt < krzysztof.h1@wp.pl>
> 
> This patch resets transparency settings when depth changes.
> Otherwise the 16 and 24-bit modes work incorrectly after
> switching from 32-bit mode.
> 
> ---
> This is a patch against 2.6.21 kernel.

You're forgetting your signed-off-line.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
