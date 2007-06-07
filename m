From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fb: epson1355fb: Kill off dead sh
	support.
Date: Thu, 07 Jun 2007 18:09:26 +0800
Message-ID: <1181210966.4502.6.camel@daplas>
References: <20070607095418.GA23002@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwEwM-0007A0-4c for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 03:10:02 -0700
Received: from wa-out-1112.google.com ([209.85.146.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HwEwL-0002O3-DC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 03:10:02 -0700
Received: by wa-out-1112.google.com with SMTP id k22so549936waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 07 Jun 2007 03:10:00 -0700 (PDT)
In-Reply-To: <20070607095418.GA23002@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 2007-06-07 at 18:54 +0900, Paul Mundt wrote:
> The SH board that was the only user for this code was removed entirely
> from the kernel quite some time ago, so there's no reason to leave
> the stubs in place. Additionally this driver was completely broken
> anyways, so there's not really a lot of point in fixing it up either.
> 
> I can't imagine that this driver gets any testing on ARM either, given
> that FB_BLANK_UNBLANKING doesn't exist, and kills the build regardless
> of which platform is compiling. This fixes that, too.
> 
> It wouldn't be a lot of work to finish the platform device conversion
> and go with a generic 8-bit read/write_reg and kill off the architecture
> dependence completely, should someone have any use for this driver.
> 

I wonder whether we have users for this driver at all. This hardware is
a pain because it's limited to 16-bit access only.

> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Antonino Daplas <adaplas@gmail.com>

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
