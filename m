From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Blitter speed tests (was: smart
	blitter	usage for scrolling)
Date: Fri, 11 May 2007 04:31:34 +0800
Message-ID: <1178829094.4662.7.camel@daplas>
References: <46434cdea1ce4@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmFIa-0001bp-Kr for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 13:31:40 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HmFIZ-00050m-4r
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 13:31:40 -0700
Received: by py-out-1112.google.com with SMTP id a29so598473pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 May 2007 13:31:38 -0700 (PDT)
In-Reply-To: <46434cdea1ce4@wp.pl>
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

On Thu, 2007-05-10 at 18:48 +0200, Krzysztof Helt wrote:
> Hi,
> 
> Below are tests of different scrolling methods for cards I have.
> 
> All tested drivers use SCROLL_REDRAW method. I forced SCROLL_MOVE 
> method by adding flag FB_READS_FAST. 
> 
> Here are some conclusions:
> Comparing two new methods: smart blitting and smart blitting with 
> merge, the merge of blits gives some speed up at lower bit 
> depths, but it is usually lost at higher ones. So we can choose 
> both ways (with or without the merge).
> 
> The smart blitting is so much faster in many cases comparing to 
> the current dump SCROLL_MOVE, that it can replace the current 
> method. For some cards it is even faster than SCROLL_REDRAW with 
> accelerated fb_imageblit().
> 
> The drivers tdfxfb and nvidiafb will benefit from switching to 
> SCROLL_MOVE method if the smart blitting is added (the tdfxfb  
> even without it). I wonder if Geforce cards also shows this speed 
> up if switched to the SCROLL_MOVE method but I have no card to 
> test.

I'll do the test for nvidia cards.




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
