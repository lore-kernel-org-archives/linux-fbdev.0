From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: how to handle MSB framebuffer in LSB	kernel?
Date: Tue, 14 Aug 2007 04:15:33 +0800
Message-ID: <1187036133.5058.3.camel@daplas>
References: <46c0b3de5046e@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKgKG-0000Nu-Ef for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 13:15:44 -0700
Received: from qb-out-0506.google.com ([72.14.204.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKgKD-0007W1-Pt
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 13:15:44 -0700
Received: by qb-out-0506.google.com with SMTP id c8so1903807qbc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 13:15:39 -0700 (PDT)
In-Reply-To: <46c0b3de5046e@wp.pl>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, 2007-08-13 at 21:41 +0200, Krzysztof Helt wrote:
> Hi,
> 
> I have a problem how to handle MSB framebuffer (s3c2410fb) in LSB 
> kernel (typical ARM kernel).
> 
> It is not a problem in 8+ bpp (bits per pixel) modes.
> The problem is how to reverse pixel order in 1, 2 and 4 bpp
> modes, because it does not work otherwise. Is there any fb flag
> or something?

If 4bpp, ab|cd|ef is reversed as ba|dc|ef? I don't think the drawing
libraries do not support pixel reversal. Either the hardware does it, or
we create a library for this.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
