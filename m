From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 12/13] fb: Move and rename extern
 declaration for global_mode_option
Date: Mon, 15 Oct 2007 14:43:40 -0700
Message-ID: <20071015144340.167d1cda.akpm@linux-foundation.org>
References: <20071012145052.640177000@pademelon.sonytel.be>
	<20071012145130.867069000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IhXj9-00023x-UD for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 14:43:56 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IhXj9-000562-LH
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 14:43:55 -0700
In-Reply-To: <20071012145130.867069000@pademelon.sonytel.be>
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
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

On Fri, 12 Oct 2007 16:51:04 +0200
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> -    if (mode_option || (mode_option = global_mode_option)) {
> +    if (mode_option || (mode_option = fb_mode_option)) {

I guess that equals-which-looks-like-it-should-be-equals-equals really
is intended to be an assignment?

I guess.  After staring at it for a while.  It's a pretty obnoxious way
of coding it, especially in kernel context where such things are unexpected...

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
