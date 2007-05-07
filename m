From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: pm2fb with acceleration is slow
Date: Mon, 07 May 2007 17:09:01 +0800
Message-ID: <1178528941.4815.7.camel@daplas>
References: <463ed4f8341d4@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkzDV-0004UJ-J8 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 02:09:15 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkzDT-00038s-Nx
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 02:09:13 -0700
Received: by py-out-1112.google.com with SMTP id a29so1132840pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 May 2007 02:09:10 -0700 (PDT)
In-Reply-To: <463ed4f8341d4@wp.pl>
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

On Mon, 2007-05-07 at 09:27 +0200, Krzysztof Helt wrote:
> Hi,
> 
> Recently, I have added accelerated methods for fillrect and
> copyarea. Scrolling has become very slow (about ten times slower).
> 
> The fillrect function speeds ups things - the clear command is
> few times faster and scrolling is few percent faster.
> 
> The copyarea method makes scrolling much slower. Any hints?

Without any acceleration, the default scrolling is redraw, basically
it's all framebuffer writes with minimal reads.  With copyarea, reads
generally equal writes.

So one possibility is slow bus reads, even with acceleration. Another
possibility is that wait_pm2() is taking a long time, so you can try
removing that from copyarea.

Another possibility is that you're wait_pm2() function is also waiting
for vblank which can really slow it down.

You can also try to instrument copyarea, ie by making a private ioctl
that calls your copyarea function. Then compare how long it takes to say
copy 1000 500x500 rectangles, with and without the wait_pm2() function.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
