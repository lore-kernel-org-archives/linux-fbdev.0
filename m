From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: problem with gen_update_var
Date: Mon, 17 Jun 2002 12:27:09 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206171224150.31825-100000@www.transvirtual.com>
References: <1023690850.568.1.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17K29r-0006U0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jun 2002 12:27:23 -0700
In-Reply-To: <1023690850.568.1.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> Hi,
>
> gen_update_var will break panning/wrapping since it passes info->var to
> fb_pan_display.  However, fbcon updates display->var.

It works. The var info struct fb_info is always the foreground console.
Notice gen_update_var is only called when it is the foreground console.


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
