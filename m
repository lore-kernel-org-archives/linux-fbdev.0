From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 8 words bursts for fbdev driver
Date: Mon, 28 May 2007 23:40:08 +0800
Message-ID: <1180366808.4526.4.camel@daplas>
References: <1180365959.465af4876a6a8@imp.free.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HshKV-0004QB-Hx for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 08:40:19 -0700
Received: from wx-out-0506.google.com ([66.249.82.228])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HshKT-0002Ng-PF
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 08:40:19 -0700
Received: by wx-out-0506.google.com with SMTP id t15so1263030wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 28 May 2007 08:40:17 -0700 (PDT)
In-Reply-To: <1180365959.465af4876a6a8@imp.free.fr>
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

On Mon, 2007-05-28 at 17:25 +0200, xcsnake@free.fr wrote:
> Hello,
> 
> I have posted this message on the linux-kernel mailing list, but I think it
> could be more appropriate here.
> I'm working on a FPGA vga controller, with an arm cpu (at91rm9200). My FPGA is
> plugged on a 16 bits data bus. I'm trying to develop the framebuffer driver,
> from the epson s1d13xxxfb driver to use my controller. I have a first driver
> which works well. To accelerate my controller, I would like to read and write in
> my video memory (controlled by the FPGA) by 8 words bursts. Is it possible to
> tell the kernel that the memory must be accessed only by 8 words bursts ??
> My driver is available on http://xcsnake.free.fr/driver

You can write your own fillrect, imageblit and copyarea routine. The
same with fb_read and fb_write.  For userland that mmap's the
framebuffer, I don't think there's a way to tell them how to access the
framebuffer.

Tony 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
