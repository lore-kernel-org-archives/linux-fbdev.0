From: Jani Monoses <jani@iv.ro>
Subject: Re: gen_set_var() fix?
Date: Wed, 28 Aug 2002 12:16:19 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020828121619.05a8bf02.jani@iv.ro>
References: <20020828100048.2dde942e.jani@iv.ro>
	<1030525403.632.7.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iv.ro ([194.105.28.94])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17jytg-0004h1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Aug 2002 02:13:56 -0700
In-Reply-To: <1030525403.632.7.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Thanks
so not having check_var implies we only support one video mode?

> > 
> > 
> The original code is correct.  It means the driver supports only 1 video
> mode, which is the current one in info->var.  
> 
> Tony
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Jabber - The world's fastest growing 
> real-time communications platform! Don't just IM. Build it in! 
> http://www.jabber.com/osdn/xim
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
