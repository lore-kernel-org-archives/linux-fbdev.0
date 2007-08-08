From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH/RFC] fbdev:
	fb_create_modedb()	non-static `int first = 1; '
Date: Thu, 09 Aug 2007 05:26:59 +0800
Message-ID: <1186608419.4825.0.camel@daplas>
References: <Pine.LNX.4.62.0708081410170.15170@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IIt3a-0003nr-Cd for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Aug 2007 14:27:06 -0700
Received: from rv-out-0910.google.com ([209.85.198.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IIt3Z-0002aV-Um
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Aug 2007 14:27:06 -0700
Received: by rv-out-0910.google.com with SMTP id k15so810793rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 08 Aug 2007 14:27:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0708081410170.15170@pademelon.sonytel.be>
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
Cc: "Geert.Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>

On Wed, 2007-08-08 at 14:11 +0200, Geert Uytterhoeven wrote:
> >From looking at the code flow, `int first' in fb_create_modedb() should be
> static.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
> Or should it be initialized to 1 outside the loop?

It should be outside the loop.  Thanks.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
